// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:camera/camera.dart';
// import 'package:traffic_patrol/src/pages/widgets/upload_widget.dart';

// class MockCameraController extends Mock implements CameraController {}
//      final Function(Locale) onLocaleChanged;

// void main() {
//   testWidgets('shows loading spinner before camera initializes', (tester) async {
//     // Don't inject a real controller — widget shows spinner
//     await tester.pumpWidget(
//       const MaterialApp(
//         home: CameraApp(onLocaleChanged: null),
//       ),
//     );
//     expect(find.byType(CircularProgressIndicator), findsOneWidget);
//   });

//   testWidgets('shows capture button after init', (tester) async {
//     // For full widget test, you'd inject a mock controller
//     // and call setState to simulate initialization
//     await tester.pumpWidget(
//       const MaterialApp(
//         home: CameraApp(onLocaleChanged: ),
//       ),
//     );
//     await tester.pump();
//     // The white circle capture button
//     expect(find.byType(GestureDetector), findsWidgets);
//   });
// }