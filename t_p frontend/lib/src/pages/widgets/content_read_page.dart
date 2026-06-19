import 'package:flutter/material.dart';

/// Placeholder page for showing Content history / list.
///
/// This is introduced to support separate "Read" pages for
/// Content, Violation, and Points.
class ContentReadPage extends StatelessWidget {
  const ContentReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contents')),
      body: const Center(
        child: Text(
          'Content Read page (to be wired to backend API).',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
