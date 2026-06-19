// camera_service.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

class CameraService {
  final Openapi _openapi = Openapi();
  AppUserDTO appUserDTO = AppUserDTO();

  Future<void> uploadPhoto({
    required Uint8List imageBytes,
    required String description,
  }) async {
    debugPrint('Uploading photo...');
    debugPrint('Description: $description');


    // 1. Create Content
    final contentResponse = await _openapi
        .getContentResourceApi()
        .createContent(
          contentDTO: ContentDTO(
            (b) => b
              ..contentType = 'image/jpeg'
              ..appUser = (AppUserDTOBuilder()
                ..id = 1
                ..phoneNumber = 7994651274),
          ),
          headers: {'Authorization': 'Bearer ${Openapi.bearerToken}'},
        );

    if (contentResponse.statusCode != 201 || contentResponse.data == null)
      // ignore: curly_braces_in_flow_control_structures
      throw Exception("Failed to create content");

    // 2. Create Content Blob
    final contentData = contentResponse.data!;
    await _openapi.getContentBlobResourceApi().createContentBlob(
      contentBlobDTO: ContentBlobDTO(
        (b) => b..content = (ContentDTOBuilder()..id = contentData.id),
      ),
      headers: {'Authorization': 'Bearer ${Openapi.bearerToken}'},
    );
    debugPrint('Log ');
    debugPrint(contentResponse.statusCode.toString());
    debugPrint(contentData.id.toString());
  }
}
