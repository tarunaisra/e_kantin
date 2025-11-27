import 'package:flutter/material.dart';

class HomeScreenBac extends StatelessWidget {
  const HomeScreenBac({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(child: Text("Selamat datang di Smart E-Kantin")),
    );
  }
}
