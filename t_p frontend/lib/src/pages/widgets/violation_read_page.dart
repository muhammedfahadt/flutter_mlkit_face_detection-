import 'package:flutter/material.dart';

/// Placeholder page for showing Violation history / list.
///
/// This is introduced to support separate "Read" pages for
/// Content, Violation, and Points.
class ViolationReadPage extends StatelessWidget {
  const ViolationReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Violations')),
      body: const Center(
        child: Text(
          'Violation Read page (to be wired to backend API).',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
