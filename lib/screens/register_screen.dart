import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

/// Register Screen 
class RegisterScreen_Yogi extends StatefulWidget {
  const RegisterScreen_Yogi({super.key});

  @override
  State<RegisterScreen_Yogi> createState() => _RegisterScreenState_Yogi();
}

/// State Class 
class _RegisterScreenState_Yogi extends State<RegisterScreen_Yogi>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final AuthService_Rapli _authService_Rapli = AuthService_Rapli();

  final GlobalKey<FormState> _formKey_Yogi = GlobalKey<FormState>();

  // Controllers (UI Developer: Yogi)
  final TextEditingController _name_Yogi = TextEditingController();
  final TextEditingController _email_Yogi = TextEditingController();
  final TextEditingController _password_Yogi = TextEditingController();
  final TextEditingController _confirmPassword_Yogi = TextEditingController();
  final TextEditingController _nim_Yogi = TextEditingController();

  bool _isLoading_Yogi = false;

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
    _name_Yogi.dispose();
    _email_Yogi.dispose();
    _password_Yogi.dispose();
    _confirmPassword_Yogi.dispose();
    _nim_Yogi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _animation,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey_Yogi,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_add, size: 100, color: Colors.white),
                      SizedBox(height: 20),
                      Text(
                        'Daftar',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 40),

                      // NIM
                      TextFormField(
                        controller: _nim_Yogi,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white,
                        validator: (value) =>
                            value!.isEmpty ? "NIM tidak boleh kosong" : null,
                        decoration: _inputStyle_Yogi("NIM"),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 20),

                      // Nama
                      TextFormField(
                        controller: _name_Yogi,
                        cursorColor: Colors.white,
                        validator: (value) =>
                            value!.isEmpty ? "Nama tidak boleh kosong" : null,
                        decoration: _inputStyle_Yogi("Nama"),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 20),

                      // Email
                      TextFormField(
                        controller: _email_Yogi,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.white,
                        validator: (value) =>
                            _authService_Rapli.validateEmail_Rapli(value),
                        decoration: _inputStyle_Yogi("Email"),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 20),

                      // Password
                      TextFormField(
                        controller: _password_Yogi,
                        obscureText: true,
                        cursorColor: Colors.white,
                        validator: (value) =>
                            _authService_Rapli.validatePassword_Rapli(value),
                        decoration: _inputStyle_Yogi("Password"),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 20),

                      // Konfirmasi Password
                      TextFormField(
                        controller: _confirmPassword_Yogi,
                        obscureText: true,
                        cursorColor: Colors.white,
                        validator: (value) {
                          if (value != _password_Yogi.text) {
                            return "Konfirmasi Password tidak cocok";
                          }
                          return null;
                        },
                        decoration: _inputStyle_Yogi("Konfirmasi Password"),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 40),

                      // BUTTON DAFTAR
                      _isLoading_Yogi
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () async {
                                if (_formKey_Yogi.currentState!.validate()) {
                                  setState(() => _isLoading_Yogi = true);

                                  final user =
                                      await _authService_Rapli.registerUser_Rapli(
                                    email: _email_Yogi.text.trim(),
                                    password: _password_Yogi.text.trim(),
                                    nim: _nim_Yogi.text.trim(),
                                    fullName: _name_Yogi.text.trim(),
                                  );

                                  setState(() => _isLoading_Yogi = false);

                                  if (user != null) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen_Yogi(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Registrasi gagal, coba lagi.")),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.blue,
                                minimumSize: Size(double.infinity, 55),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 10,
                              ),
                              child: Text(
                                'Daftar',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                      SizedBox(height: 20),

                      // Tombol ke login
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/login'),
                        child: Text(
                          "Sudah punya akun? Masuk",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Styling Input Field (UI Developer: Yogi)
  InputDecoration _inputStyle_Yogi(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.white.withOpacity(0.8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
    );
  }
}
