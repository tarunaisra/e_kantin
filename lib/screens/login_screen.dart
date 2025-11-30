import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen_Yogi extends StatefulWidget {
  const LoginScreen_Yogi({super.key});

  @override
  State<LoginScreen_Yogi> createState() => _LoginScreen_YogiState();
}

class _LoginScreen_YogiState extends State<LoginScreen_Yogi>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final TextEditingController _email_Yogi = TextEditingController();
  final TextEditingController _password_Yogi = TextEditingController();

  final FirebaseAuth _auth_Rapli = FirebaseAuth.instance;
  bool _isLoading_Rapli = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _email_Yogi.dispose();
    _password_Yogi.dispose();
    super.dispose();
  }

  Future<void> _login_Rapli() async {
    String email = _email_Yogi.text.trim();
    String password = _password_Yogi.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email & Password tidak boleh kosong")));
      return;
    }

    setState(() => _isLoading_Rapli = true);

    try {
      await _auth_Rapli.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "Login gagal")));
    }

    setState(() => _isLoading_Rapli = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF003366), Color(0xFF000033)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _animation,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.login, size: 100, color: Colors.white),
                  SizedBox(height: 40),

                  TextField(
                    controller: _email_Yogi,
                    decoration: input("Email"),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 20),

                  TextField(
                    controller: _password_Yogi,
                    obscureText: true,
                    decoration: input("Password"),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 40),

                  _isLoading_Rapli
                      ? CircularProgressIndicator(color: Colors.white)
                      : ElevatedButton(
                          onPressed: _login_Rapli,
                          style: button(),
                          child: Text("Masuk",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),

                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: Text("Belum punya akun? Daftar",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration input(String label) => InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      );

  ButtonStyle button() => ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        minimumSize: Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 10,
      );
}
