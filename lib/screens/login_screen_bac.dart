import 'package:flutter/material.dart';
import '../controllers/auth_controller_bac.dart';

class LoginScreenBac extends StatefulWidget {
  @override
  _LoginScreenBacState createState() => _LoginScreenBacState();
}

class _LoginScreenBacState extends State<LoginScreenBac> {
  final _formKey = GlobalKey<FormState>();
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final authC = AuthControllerBac();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // email
              TextFormField(
                controller: emailC,
                decoration: InputDecoration(labelText: "Email"),
                validator: (v) {
                  if (v == null || v.isEmpty) return "Email wajib diisi";
                  if (!v.contains("@")) return "Email tidak valid";
                  return null;
                },
              ),

              // password
              TextFormField(
                controller: passC,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                validator: (v) =>
                    v != null && v.length >= 6 ? null : "Minimal 6 karakter",
              ),

              SizedBox(height: 20),

              ElevatedButton(
                child: Text("LOGIN"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authC.loginBac(
                      email: emailC.text,
                      password: passC.text,
                      context: context,
                    );
                  }
                },
              ),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: Text("Belum punya akun? Daftar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
