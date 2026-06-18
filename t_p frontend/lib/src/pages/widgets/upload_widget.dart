import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:traffic_patrol/src/pages/widgets/camera_service.dart';

import 'app_home_page.dart';
import 'login_form.dart';

import 'app_home_page.dart';

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController? _controller;
  final CameraService _service = CameraService();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      _controller = CameraController(cameras[0], ResolutionPreset.medium);
      await _controller!.initialize();

      if (mounted) {
        setState(() {}); // This tells Flutter to rebuild and remove the spinner
      }
    } catch (e) {
      debugPrint("Camera error: $e");
    }
  }

  // Don't forget to dispose the controller when the screen closes!
  @override
  void dispose() {
    _controller?.dispose();
    _descController.dispose();
    super.dispose();
  }

  // Helper to handle the dialog and upload flow
  void _handleCapture() async {
    final photo = await _controller?.takePicture();
    if (photo == null) return;

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator()),
    );

    String aiDescription = "";
    try {
      final inputImage = InputImage.fromFilePath(photo.path);
      final imageLabeler = ImageLabeler(
        options: ImageLabelerOptions(confidenceThreshold: 0.6),
      );
      final labels = await imageLabeler.processImage(inputImage);

      final trafficKeywords = [
        'Car',
        'Vehicle',
        'Motorcycle',
        'Truck',
        'Bus',
        'Bicycle',
        'Traffic',
        'License plate',
        'Wheel',
        'Tire',
      ];

      List<String> detected = [];
      bool possibleViolation = false;

      for (ImageLabel label in labels) {
        detected.add(
          "${label.label} (${(label.confidence * 100).toStringAsFixed(1)}%)",
        );
        if (trafficKeywords.any(
          (kw) => label.label.toLowerCase().contains(kw.toLowerCase()),
        )) {
          possibleViolation = true;
        }
      }

      if (detected.isNotEmpty) {
        aiDescription = "AI Detection: ${detected.join(', ')}.";
        if (possibleViolation) {
          aiDescription = "Traffic violation candidate. $aiDescription";
        }
      }
      imageLabeler.close();
    } catch (e) {
      debugPrint("ML Kit error: $e");
    }

    if (!mounted) return;
    Navigator.pop(context); // Dismiss loading dialog

    _descController.text = aiDescription;

    final bytes = await photo.readAsBytes();

    if (!mounted) return;

    final description = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Enter Description'),
        content: TextField(
          controller: _descController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Describe the violation...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, _descController.text),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (description == null) {
      debugPrint('description is null');
    }

    if (description != null) {
      try {
        await _service.uploadPhoto(imageBytes: bytes, description: description);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Success!')));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller?.value.isInitialized != true)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Camera'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Home',
            icon: const Icon(Icons.home_outlined),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const AppHomePage()),
                (_) => false,
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: CameraPreview(_controller!),
          ),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.flash_off, color: Colors.white),
            GestureDetector(
              onTap: _handleCapture,
              child: Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const Icon(Icons.flip_camera_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
