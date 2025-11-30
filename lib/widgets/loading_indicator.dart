import 'package:flutter/material.dart';

/// Loading indicator widget - Anggota 5 (Rapli)
/// Watermark: suffix `_Rapli` applied to class and helpers
class LoadingIndicator_Rapli extends StatelessWidget {
  const LoadingIndicator_Rapli({super.key});

  /// Named route (optional) - register in `main.dart` to use `pushNamed`
  static const String routeName_Rapli = '/loading_rapli';

  /// Convenience route builder
  static Route<dynamic> route_Rapli() {
    return MaterialPageRoute<void>(builder: (_) => const LoadingIndicator_Rapli());
  }

  @override
  Widget build(BuildContext context) => const Center(child: CircularProgressIndicator());
}
