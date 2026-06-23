import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:traffic_patrol/src/pages/widgets/camera_service.dart';
import 'app_home_page.dart';
import 'dart:typed_data';

class CameraApp extends StatefulWidget {
  final Function(Locale) onLocaleChanged;
  const CameraApp({super.key, required this.onLocaleChanged});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController? _controller;
  final CameraService _service = CameraService();
  final TextEditingController _descController = TextEditingController();

  // Object detector — uses the base model (no custom .tflite needed)
  late final ObjectDetector _objectDetector;
  List<DetectedObject> _detectedObjects = [];
  Size _imageSize = Size.zero;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _objectDetector = ObjectDetector(
      options: ObjectDetectorOptions(
        // ✅ Use the bundled base model — no tflite file needed
        mode: DetectionMode.stream,         // stream for live preview
        classifyObjects: true,              // enables label output
        multipleObjects: true,              // detect all objects per frame
      ),
    );
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;
      _controller = CameraController(
        cameras[0],
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _controller!.initialize();

      // ✅ Stream frames into detector instead of one-shot labeling
      _controller!.startImageStream(_processFrame);

      if (mounted) setState(() {});
    } catch (e) {
      debugPrint("Camera error: $e");
    }
  }

  // ─── Frame processing ───────────────────────────────────────────────────────

  Future<void> _processFrame(CameraImage image) async {
    if (_isProcessing) return;  // drop frames while busy
    _isProcessing = true;

    try {
      final inputImage = _buildInputImage(image);
      if (inputImage == null) return;

      final objects = await _objectDetector.processImage(inputImage);

      if (mounted) {
        setState(() {
          _detectedObjects = objects;
          _imageSize = Size(
            image.width.toDouble(),
            image.height.toDouble(),
          );
        });
      }
    } catch (e) {
      debugPrint("Detection error: $e");
    } finally {
      _isProcessing = false;
    }
  }

 // ─── Replace your entire _buildInputImage method with this ───────────────────

InputImage? _buildInputImage(CameraImage image) {
  // Step 1: Log what your phone actually outputs (remove after fix confirmed)
  debugPrint('📷 Format: ${image.format.raw} | Planes: ${image.planes.length} '
      '| Size: ${image.width}x${image.height}');

  final rotation = _getRotation();
  if (rotation == null) return null;

  // Step 2: Try converting to NV21 — works on virtually all Android cameras
  try {
    final nv21Bytes = _convertToNv21(image);
    if (nv21Bytes != null) {
      return InputImage.fromBytes(
        bytes: nv21Bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: rotation,
          format: InputImageFormat.nv21,         // force NV21 — ML Kit loves this
          bytesPerRow: image.width,              // NV21 stride = width
        ),
      );
    }
  } catch (e) {
    debugPrint('NV21 conversion failed: $e');
  }

  // Step 3: Fallback — try yuv_420_888 directly
  try {
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format != null && image.planes.isNotEmpty) {
      return InputImage.fromBytes(
        bytes: image.planes[0].bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: rotation,
          format: format,
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );
    }
  } catch (e) {
    debugPrint('Direct format fallback failed: $e');
  }

  debugPrint('❌ Could not convert image format: ${image.format.raw}');
  return null;
}

// ─── YUV_420_888 → NV21 converter ────────────────────────────────────────────
// Most Android cameras output YUV_420_888 (format raw = 35).
// ML Kit's object detector requires NV21 (Y plane + interleaved VU).
// This manually reorders the bytes into the NV21 layout.

Uint8List? _convertToNv21(CameraImage image) {
  if (image.planes.length < 2) return null;

  final int width  = image.width;
  final int height = image.height;

  final yPlane  = image.planes[0];
  final uPlane  = image.planes[1];
  final vPlane  = image.planes[2];

  final int ySize  = width * height;
  final int uvSize = (width ~/ 2) * (height ~/ 2);

  final nv21 = Uint8List(ySize + uvSize * 2);

  // Copy Y plane row by row (handles row stride != width)
  int nv21Index = 0;
  for (int row = 0; row < height; row++) {
    final rowStart = row * yPlane.bytesPerRow;
    nv21.setRange(nv21Index, nv21Index + width, yPlane.bytes, rowStart);
    nv21Index += width;
  }

  // Interleave V and U bytes → NV21 = Y + VU (not UV)
  final int uvHeight = height ~/ 2;
  final int uvWidth  = width  ~/ 2;
  final int vStride  = vPlane.bytesPerRow;
  final int uStride  = uPlane.bytesPerRow;
  final int vPixelStride = vPlane.bytesPerPixel ?? 1;
  final int uPixelStride = uPlane.bytesPerPixel ?? 1;

  for (int row = 0; row < uvHeight; row++) {
    for (int col = 0; col < uvWidth; col++) {
      final vIndex = row * vStride + col * vPixelStride;
      final uIndex = row * uStride + col * uPixelStride;

      if (vIndex < vPlane.bytes.length && uIndex < uPlane.bytes.length) {
        nv21[nv21Index++] = vPlane.bytes[vIndex]; // V first in NV21
        nv21[nv21Index++] = uPlane.bytes[uIndex]; // then U
      }
    }
  }

  return nv21;
}

// ─── Sensor rotation helper ───────────────────────────────────────────────────
InputImageRotation? _getRotation() {
  final sensorOrientation = _controller!.description.sensorOrientation;
  debugPrint('📐 Sensor orientation: $sensorOrientation°');

  switch (sensorOrientation) {
    case 0:   return InputImageRotation.rotation0deg;
    case 90:  return InputImageRotation.rotation90deg;
    case 180: return InputImageRotation.rotation180deg;
    case 270: return InputImageRotation.rotation270deg;
    default:
      debugPrint('⚠️ Unknown sensor orientation: $sensorOrientation');
      return InputImageRotation.rotation90deg; // safe default for most Android phones
  }
}

  // ─── Violation logic (rule engine) ──────────────────────────────────────────

  String _analyzeViolations(List<DetectedObject> objects) {
    final labels = objects
        .expand((o) => o.labels)
        .map((l) => l.text.toLowerCase())
        .toSet();

    final List<String> violations = [];

    // Rule 1: motorcycle/bicycle present but no helmet detected
    if ((labels.contains('motorcycle') || labels.contains('bicycle')) &&
        !labels.contains('helmet') &&
        labels.contains('person')) {
      violations.add('No helmet on rider');
    }

    // Rule 2: vehicle near red traffic light
    if (labels.contains('traffic light') &&
        (labels.contains('car') ||
            labels.contains('motorcycle') ||
            labels.contains('truck'))) {
      violations.add('Vehicle near signal — possible signal jump');
    }

    // Rule 3: count persons on a single vehicle
    final personCount = objects
        .where((o) =>
            o.labels.any((l) => l.text.toLowerCase() == 'person'))
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

  // ─── Capture & upload ────────────────────────────────────────────────────────

  void _handleCapture() async {
    // Pause stream so takePicture() doesn't conflict
    await _controller?.stopImageStream();

    final photo = await _controller?.takePicture();
    if (photo == null) {
      await _controller?.startImageStream(_processFrame);
      return;
    }

    if (!mounted) return;

    final aiDescription = _analyzeViolations(_detectedObjects);
    _descController.text = aiDescription;

    final bytes = await photo.readAsBytes();
    if (!mounted) return;

    final description = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Describe the violation'),
        content: TextField(
          controller: _descController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Edit or confirm the AI description...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx), // cancel
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, _descController.text),
            child: const Text('Upload'),
          ),
        ],
      ),
    );

    // Resume stream regardless
    if (mounted) await _controller?.startImageStream(_processFrame);

    if (description != null && description.isNotEmpty) {
      try {
        await _service.uploadPhoto(imageBytes: bytes, description: description);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Uploaded successfully!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Upload error: $e')));
        }
      }
    }
  }

  @override
  void dispose() {
    _controller?.stopImageStream();
    _controller?.dispose();
    _objectDetector.close();
    _descController.dispose();
    super.dispose();
  }

  // ─── UI ──────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (_controller?.value.isInitialized != true) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => AppHomePage(onLocaleChanged: (_) {}),
              ),
              (_) => false,
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CameraPreview(_controller!),
          // ✅ Draw bounding boxes over live preview
          if (_detectedObjects.isNotEmpty)
            CustomPaint(
              painter: BoundingBoxPainter(
                objects: _detectedObjects,
                imageSize: _imageSize,
                previewSize: MediaQuery.of(context).size,
              ),
            ),
          _buildViolationBanner(),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildViolationBanner() {
    final desc = _analyzeViolations(_detectedObjects);
    if (desc.isEmpty) return const SizedBox.shrink();
    final isViolation = desc.startsWith('⚠️');
    return Positioned(
      top: 12,
      left: 12,
      right: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isViolation
              ? Colors.red.withOpacity(0.85)
              : Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          desc,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
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

// ─── Bounding box overlay ────────────────────────────────────────────────────

class BoundingBoxPainter extends CustomPainter {
  final List<DetectedObject> objects;
  final Size imageSize;
  final Size previewSize;

  BoundingBoxPainter({
    required this.objects,
    required this.imageSize,
    required this.previewSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (imageSize == Size.zero) return;

    final scaleX = previewSize.width / imageSize.width;
    final scaleY = previewSize.height / imageSize.height;

    final boxPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.greenAccent;

    final violationPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = Colors.redAccent;

    for (final obj in objects) {
      final r = obj.boundingBox;
      final rect = Rect.fromLTRB(
        r.left * scaleX,
        r.top * scaleY,
        r.right * scaleX,
        r.bottom * scaleY,
      );

      final label =
          obj.labels.isNotEmpty ? obj.labels.first.text : 'Object';
      final isViolationObj = ['motorcycle', 'bicycle', 'traffic light']
          .contains(label.toLowerCase());

      canvas.drawRect(rect, isViolationObj ? violationPaint : boxPaint);

      // Draw label
      final tp = TextPainter(
        text: TextSpan(
          text: label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        textDirection: ui.TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(rect.left + 4, rect.top + 4));
    }
  }

  @override
  bool shouldRepaint(BoundingBoxPainter old) =>
      old.objects != objects || old.previewSize != previewSize;
}