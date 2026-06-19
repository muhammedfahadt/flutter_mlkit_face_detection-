import 'package:flutter/material.dart';

/// Placeholder page for showing Points history / list.
///
/// This is introduced to support separate "Read" pages for
/// Content, Violation, and Points.
class PointsReadPage extends StatelessWidget {
  const PointsReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Points')),
      body: const Center(
        child: Text(
          'Points Read page (to be wired to backend API).',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
