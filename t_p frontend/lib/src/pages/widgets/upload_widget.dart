import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:traffic_patrol/src/pages/widgets/camera_service.dart';


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
    super.dispose();
  }
  // Helper to handle the dialog and upload flow
  void _handleCapture() async {
    final photo = await _controller?.takePicture();
    if (photo == null) return;
    
    final bytes = await photo.readAsBytes();

    if (!mounted) return;
    
    final description = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Enter Description'),
        content: TextField(controller: _descController),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, _descController.text), child: const Text('OK'))
        ],
      ),
    );
 if (description == null){debugPrint('description is null');}
 
    if (description != null) {
      try {
        await _service.uploadPhoto(imageBytes: bytes, description: description);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Success!')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller?.value.isInitialized != true) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      backgroundColor: Colors.black,
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
              child: Container(height: 70, width: 70, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
            ),
            const Icon(Icons.flip_camera_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }
}