import 'package:flutter/material.dart';

class EmptyStateRapli extends StatelessWidget {
  final String message;
  const EmptyStateRapli({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
