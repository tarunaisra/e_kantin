import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // --- LATAR BELAKANG PROFESIONAL BARU ---
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
        // -------------------------------------
        child: FadeTransition(
          opacity: _animation,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                // Tambahkan SingleChildScrollView agar keyboard tidak menyebabkan overflow
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person_add,
                      size: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Daftar Akun', // Ubah teks menjadi lebih formal
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // --- Field Nama ---
                    TextField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      cursorColor: Colors.white,
                      onChanged: (value) {
                        if (kDebugMode) print('Nama: $value');
                      },
                      decoration: InputDecoration(
                        labelText: 'Nama Lengkap',
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
                    const SizedBox(height: 20),

                    // --- Field Konfirmasi Password ---
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      cursorColor: Colors.white,
                      onChanged: (value) {
                        if (kDebugMode) print('Konfirmasi Password: $value');
                      },
                      decoration: InputDecoration(
                        labelText: 'Konfirmasi Password',
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

                    // --- Tombol Daftar ---
                    ElevatedButton(
                      onPressed: () {
                        // Simulasi registrasi berhasil, navigasi ke login
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(
                          0xFF003366,
                        ), // Warna teks sesuai gradient baru
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

                    // --- Tombol Masuk ---
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        'Sudah punya akun? Masuk',
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
