import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nimControllerbac = TextEditingController();
  final TextEditingController nameControllerbac = TextEditingController();
  final TextEditingController emailControllerbac = TextEditingController();
  final TextEditingController passwordControllerbac = TextEditingController();
  final GlobalKey<FormState> formKeybac = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  bool loadingbac = false;

  Future<void> _submitRegisterbac() async {
    if (!formKeybac.currentState!.validate()) return;
    setState(() => loadingbac = true);
    try {
      await _authController.registerbac(
        emailbac: emailControllerbac.text.trim(),
        passbac: passwordControllerbac.text,
        context: context,
      );
      // Save user to Firestore using NIM as document id
      await _db.collection('Users').doc(nimControllerbac.text.trim()).set({
        'user id': nimControllerbac.text.trim(),
        'email': emailControllerbac.text.trim(),
        'full name': nameControllerbac.text.trim(),
        // WARNING: do not store plain passwords in real systems
        'password': passwordControllerbac.text,
      });
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Register gagal: $e')));
    } finally {
      setState(() => loadingbac = false);
    }
  }

  @override
  void dispose() {
    nimControllerbac.dispose();
    nameControllerbac.dispose();
    emailControllerbac.dispose();
    passwordControllerbac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nimFieldbac = TextFormField(
      controller: nimControllerbac,
      decoration: const InputDecoration(labelText: 'NIM (user id)'),
      validator: (v) => (v == null || v.isEmpty) ? 'NIM wajib' : null,
    );

    final nameFieldbac = TextFormField(
      controller: nameControllerbac,
      decoration: const InputDecoration(labelText: 'Nama Lengkap'),
      validator: (v) => (v == null || v.isEmpty) ? 'Nama wajib' : null,
    );

    final emailFieldbac = TextFormField(
      controller: emailControllerbac,
      decoration: const InputDecoration(labelText: 'Email (kampus)'),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Email wajib';
        if (!v.contains('@')) return 'Email tidak valid';
        if (!v.endsWith('@kampus.ac.id')) return 'Gunakan domain kampus (.ac.id)';
        return null;
      },
    );

    final passwordFieldbac = TextFormField(
      controller: passwordControllerbac,
      obscureText: true,
      decoration: const InputDecoration(labelText: 'Password'),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Password wajib';
        if (v.length < 6) return 'Minimal 6 karakter';
        return null;
      },
    );

    final registerButtonbac = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: loadingbac ? null : _submitRegisterbac,
        child: loadingbac ? const CircularProgressIndicator() : const Text('DAFTAR'),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKeybac,
          child: ListView(
            children: [
              nimFieldbac,
              const SizedBox(height: 12),
              nameFieldbac,
              const SizedBox(height: 12),
              emailFieldbac,
              const SizedBox(height: 12),
              passwordFieldbac,
              const SizedBox(height: 20),
              registerButtonbac,
            ],
          ),
        ),
      ),
    );
  }
}
