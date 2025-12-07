import 'package:flutter/material.dart';
import '../services/auth_service.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService_Rapli _authService_Rapli = AuthService_Rapli();

  bool _isLoading_Rapli = false;
  bool _isPasswordVisible_Yogi = false;

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
    if (!_formKey.currentState!.validate()) return;

    final String email = _email_Yogi.text.trim();
    final String password = _password_Yogi.text.trim();

    setState(() => _isLoading_Rapli = true);

    try {
      final user = await _authService_Rapli.signInUser_Rapli(email, password);
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login gagal')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login gagal: $e')));
    } finally {
      setState(() => _isLoading_Rapli = false);
    }
  }

  InputDecoration _inputStyle_Yogi(String label, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black54),
      filled: true,
      fillColor: Colors.grey.shade200,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Color(0xFF003366), width: 2),
      ),
      suffixIcon: suffixIcon,
    );
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
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.login, size: 100, color: Colors.white),
                      const SizedBox(height: 40),

                      // Email
                      TextFormField(
                        controller: _email_Yogi,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.black,
                        decoration: _inputStyle_Yogi("Email"),
                        style: const TextStyle(color: Colors.black),
                        validator: _authService_Rapli.validateEmail_Rapli,
                      ),
                      const SizedBox(height: 20),

                      // Password
                      TextFormField(
                        controller: _password_Yogi,
                        obscureText: !_isPasswordVisible_Yogi,
                        cursorColor: Colors.black,
                        decoration: _inputStyle_Yogi(
                          "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible_Yogi
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible_Yogi =
                                    !_isPasswordVisible_Yogi;
                              });
                            },
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                        validator: _authService_Rapli.validatePassword_Rapli,
                      ),
                      const SizedBox(height: 40),

                      // Tombol Login
                      _isLoading_Rapli
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _login_Rapli,
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
                                "Masuk",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),

                      // Navigasi ke register
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/register'),
                        child: const Text(
                          "Belum punya akun? Daftar",
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
}
