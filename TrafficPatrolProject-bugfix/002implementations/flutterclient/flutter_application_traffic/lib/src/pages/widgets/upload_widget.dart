import 'dart:convert';
import 'dart:typed_data';
import 'package:built_collection/src/list.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:openapi/openapi.dart';
import 'package:image/image.dart' as img;

import 'config.dart';

class CameraApp extends StatefulWidget {
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  final Openapi _openapi = Openapi();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(
      _cameras[0],
      ResolutionPreset.medium,
    );
    await _controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  void _capturePhoto() async {
    try {
      final XFile photo = await _controller.takePicture();
      final imageBytes = await photo.readAsBytes();

      // Show dialog to enter description
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Enter Description'),
          content: TextField(
            controller: _descriptionController,
            decoration: InputDecoration(hintText: 'Enter description here'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _sendPhotoToBackend(imageBytes);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error capturing photo: $e');
    }
  }

  Future<void> _sendPhotoToBackend(final imageBytes) async {
    String? appUserIdString = await Configuration.secureStorage.read(key: 'appuserId') ;
        String? appUserNumberString = await Configuration.secureStorage.read(key: 'appUsernumber') ;
    String? jwt = await  Configuration.secureStorage.read(key: 'jwt');
    print('${appUserNumberString}');
    int? appUserId = int.tryParse(appUserIdString!);
    int? appUserNumber = int.tryParse(appUserNumberString!);
    AppUserDTOBuilder appUserDTOBuilder = AppUserDTOBuilder()
                                       ..id = appUserId
                                       ..phoneNumber = appUserNumber;
    final contentDTOBuilder = ContentDTOBuilder()
      ..contentType = await getImageContentType(imageBytes)
      ..appUser =appUserDTOBuilder;
      ContentDTO contentDTO = contentDTOBuilder.build();
     final contentResponse = await _openapi.getContentResourceApi().createContent(contentDTO: contentDTO,
     headers: {'Authorization': 'Bearer $jwt'});
    //final imageList = ListBuilder<String>([String.fromCharCodes(imageBytes)]);
 if(contentResponse.statusCode == 201){
  try{
    AppUserDTOBuilder _appUserResponseDtoBuilder = AppUserDTOBuilder()
                                                 ..id = contentResponse.data?.appUser?.id
                                                 ..phoneNumber = contentResponse.data?.appUser?.phoneNumber;
      debugPrint('${appUserDTOBuilder.build().id}');
     ContentDTOBuilder _contentResponseDTOBuilder = ContentDTOBuilder()
                                                       ..id =contentResponse.data?.id
                                                       ..appUser = _appUserResponseDtoBuilder;
    
    final contentBlobDTOBuilder = ContentBlobDTOBuilder()
      ..contentBlobContentType = _descriptionController.text
      ..content = _contentResponseDTOBuilder;

    final contentBlobDTO = contentBlobDTOBuilder.build();

    final response = await _openapi.getContentBlobResourceApi().createContentBlob(
      contentBlobDTO: contentBlobDTO,
      headers: {'Authorization': 'Bearer $jwt'},
    );

    if (response.statusCode == 201) {
      print('Photo uploaded successfully');
      showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Uploaded Image'),
        content: Image.memory(
          imageBytes,
          fit: BoxFit.cover,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
    } else {
      print('Failed to upload photo');
    }
  }catch(e){
      print('${e}');
  }
 }else{
    debugPrint('${contentResponse.statusCode}');
     print('Failed to upload');
 }
  }
 Future<String> getImageContentType(Uint8List imageBytes) async {
  // Decode image bytes
  img.Image? image = img.decodeImage(imageBytes);
  
  // Check if image is not null and get the image format
  if (image != null) {
    
      return image.format.toString();
    
    // Add more checks for other image formats if needed
  }
  
  // Default to 'application/octet-stream' if image format is unknown
  return 'application/octet-stream';
}
   @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return 
      Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
             Positioned.fill(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: CameraPreview(_controller),
            ),
          ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.flash_off),
                          color: Colors.white,
                          iconSize: 30.0,
                        ),
                        GestureDetector(
                          onTap: _capturePhoto,
                          child: Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.flip_camera_ios),
                          color: Colors.white,
                          iconSize: 30.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    
  }
}
