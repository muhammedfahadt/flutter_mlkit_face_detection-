import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

class ViolationAnalyzer {
  static String analyze(List<DetectedObject> objects) {
    final labels = objects
        .expand((o) => o.labels)
        .map((l) => l.text.toLowerCase())
        .toSet();

    final List<String> violations = [];

    if ((labels.contains('motorcycle') || labels.contains('bicycle')) &&
        !labels.contains('helmet') &&
        labels.contains('person')) {
      violations.add('No helmet on rider');
    }

    if (labels.contains('traffic light') &&
        (labels.contains('car') ||
            labels.contains('motorcycle') ||
            labels.contains('truck'))) {
      violations.add('Vehicle near signal — possible signal jump');
    }

    final personCount = objects
        .where((o) => o.labels.any((l) => l.text.toLowerCase() == 'person'))
        .length;
    if (personCount >= 3 &&
        (labels.contains('motorcycle') || labels.contains('bicycle'))) {
      violations.add('Vehicle overloading ($personCount persons)');
    }

    if (violations.isEmpty && objects.isNotEmpty) {
      final names = objects
          .map((o) => o.labels.isNotEmpty ? o.labels.first.text : 'Object')
          .join(', ');
      return 'Detected: $names. No clear violation.';
    } else if (violations.isNotEmpty) {
      return '⚠️ Violation: ${violations.join('; ')}';
    }
    return '';
  }
}