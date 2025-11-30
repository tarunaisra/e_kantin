import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // --- LATAR BELAKANG PROFESIONAL BARU (SAMA DENGAN REGISTER) ---
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF003366), // Biru Tua (Navy)
              Color(0xFF000033), // Biru Sangat Tua
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // -----------------------------------------------------------
        child: FadeTransition(
          opacity: _animation,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                // Ditambahkan agar aman saat keyboard muncul
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.login, size: 100, color: Colors.white),
                    const SizedBox(height: 20),
                    const Text(
                      'Selamat Datang',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // --- Field Email ---
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.white,
                      onChanged: (value) {
                        if (kDebugMode) print('Email: $value');
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        // --- PERBAIKAN: Ganti withValues menjadi withOpacity ---
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 20),

                    // --- Field Password ---
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      cursorColor: Colors.white,
                      onChanged: (value) {
                        if (kDebugMode) print('Password: $value');
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        // --- PERBAIKAN: Ganti withValues menjadi withOpacity ---
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 40),

                    // --- Tombol Masuk ---
                    ElevatedButton(
                      onPressed: () {
                        // Simulasi login berhasil, navigasi ke home
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        // Warna teks disesuaikan dengan gradient baru
                        foregroundColor: const Color(0xFF003366),
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 10,
                      ),
                      child: const Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- Tombol Daftar ---
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Belum punya akun? Daftar',
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
    );
  }
}
