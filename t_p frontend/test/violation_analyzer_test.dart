import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:traffic_patrol/src/services/violation_analyzer.dart';

// Helper to build a fake DetectedObject with labels
DetectedObject fakeObject(List<String> labelNames) {
  return DetectedObject(
    boundingBox: const Rect.fromLTWH(0, 0, 100, 100),
    labels: labelNames
        .map((name) => Label(text: name, confidence: 0.9, index: 0))
        .toList(),
    trackingId: null,
  );
}

void main() {
  group('ViolationAnalyzer', () {
    test('detects no-helmet violation', () {
      final objects = [
        fakeObject(['Person']),
        fakeObject(['Motorcycle']),
      ];
      final result = ViolationAnalyzer.analyze(objects);
      expect(result, contains('No helmet'));
    });

    test('no violation when helmet present', () {
      final objects = [
        fakeObject(['Person']),
        fakeObject(['Motorcycle']),
        fakeObject(['Helmet']),
      ];
      final result = ViolationAnalyzer.analyze(objects);
      expect(result, isNot(contains('⚠️')));
    });

    test('detects signal jump', () {
      final objects = [
        fakeObject(['Car']),
        fakeObject(['Traffic light']),
      ];
      final result = ViolationAnalyzer.analyze(objects);
      expect(result, contains('signal jump'));
    });

    test('detects overloading with 3 persons on motorcycle', () {
      final objects = [
        fakeObject(['Person']),
        fakeObject(['Person']),
        fakeObject(['Person']),
        fakeObject(['Motorcycle']),
      ];
      final result = ViolationAnalyzer.analyze(objects);
      expect(result, contains('overloading'));
    });

    test('returns no violation for lone car', () {
      final objects = [fakeObject(['Car'])];
      final result = ViolationAnalyzer.analyze(objects);
      expect(result, isNot(contains('⚠️')));
    });

    test('returns empty string for no objects', () {
      expect(ViolationAnalyzer.analyze([]), isEmpty);
    });
  });
}