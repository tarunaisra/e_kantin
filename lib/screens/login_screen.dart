import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // NOTE: variable widget names MUST have watermark 'bac'
  final TextEditingController emailControllerbac = TextEditingController();
  final TextEditingController passwordControllerbac = TextEditingController();
  final GlobalKey<FormState> formKeybac = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  bool loadingbac = false;

  // function logic MUST have watermark 'bac'
  Future<void> _submitLoginbac() async {
    if (!formKeybac.currentState!.validate()) return;
    setState(() => loadingbac = true);
    await _authController.loginbac(
      emailbac: emailControllerbac.text.trim(),
      passbac: passwordControllerbac.text,
      context: context,
    );
    setState(() => loadingbac = false);
  }

  @override
  void dispose() {
    emailControllerbac.dispose();
    passwordControllerbac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // UI widgets variables also suffixed bac where they are named
    final emailFieldbac = TextFormField(
      controller: emailControllerbac,
      decoration: const InputDecoration(labelText: 'Email (kampus)'),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Email wajib diisi';
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
        if (v == null || v.isEmpty) return 'Password wajib diisi';
        if (v.length < 6) return 'Minimal 6 karakter';
        return null;
      },
    );

    final loginButtonbac = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: loadingbac ? null : _submitLoginbac,
        child: loadingbac ? const CircularProgressIndicator() : const Text('LOGIN'),
      ),
    );

    final toRegisterButtonbac = TextButton(
      onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
      child: const Text('Belum punya akun? Daftar'),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKeybac,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              emailFieldbac,
              const SizedBox(height: 12),
              passwordFieldbac,
              const SizedBox(height: 20),
              loginButtonbac,
              toRegisterButtonbac,
            ],
          ),
        ),
      ),
    );
  }
}
