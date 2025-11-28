import 'package:flutter/material.dart';
import '../services/auth_service.dart';

/// Register Screen (UI: Yogi, Auth: Rapli)
class RegisterScreen_Yogi extends StatefulWidget {
  const RegisterScreen_Yogi({super.key});

  @override
  State<RegisterScreen_Yogi> createState() => _RegisterScreenState_Yogi();
}

class _RegisterScreenState_Yogi extends State<RegisterScreen_Yogi>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final AuthService_Rapli _authService_Rapli = AuthService_Rapli();
  final GlobalKey<FormState> _formKey_Yogi = GlobalKey<FormState>();

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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey_Yogi,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person_add, size: 100, color: Colors.white),
                      const SizedBox(height: 20),
                      const Text(
                        'Daftar Akun',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40),

                      TextFormField(
                        controller: _nim_Yogi,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "NIM tidak boleh kosong" : null,
                        decoration: _inputStyle_Yogi("NIM"),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _name_Yogi,
                        validator: (value) =>
                            value!.isEmpty ? "Nama tidak boleh kosong" : null,
                        decoration: _inputStyle_Yogi("Nama Lengkap"),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _email_Yogi,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            _authService_Rapli.validateEmail_Rapli(value),
                        decoration: _inputStyle_Yogi("Email"),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _password_Yogi,
                        obscureText: true,
                        validator: (value) =>
                            _authService_Rapli.validatePassword_Rapli(value),
                        decoration: _inputStyle_Yogi("Password"),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _confirmPassword_Yogi,
                        obscureText: true,
                        validator: (value) {
                          if (value != _password_Yogi.text) {
                            return "Konfirmasi password tidak cocok";
                          }
                          return null;
                        },
                        decoration: _inputStyle_Yogi("Konfirmasi Password"),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 40),

                      _isLoading_Yogi
                          ? const CircularProgressIndicator()
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
                                    Navigator.pushReplacementNamed(
                                        context, '/login'); // ← Sesuai tugas
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Registrasi gagal, coba lagi."),
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF003366),
                                minimumSize: const Size(double.infinity, 55),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 10,
                              ),
                              child: const Text(
                                'Daftar Sekarang',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),

                      TextButton(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, '/login'),
                        child: const Text(
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

  InputDecoration _inputStyle_Yogi(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.white.withOpacity(0.8),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
    );
  }
}
