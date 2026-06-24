// camera_service.dart
import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:openapi/openapi.dart';

import 'package:built_collection/built_collection.dart';

// OpenAPI provides PointsResourceApi + PointsDTO.

class CameraService {
  final Openapi _openapi = Openapi();
  AppUserDTO? _currentUser;

  /// Upload evidence image + (optionally) create a Violation.
  ///
  /// Current violation workflow:
  /// - Always create Content + ContentBlob (evidence)
  /// - Create Violation only when [description] starts with "⚠️".
  Future<void> uploadPhoto({
    required Uint8List imageBytes,
    required String description,
  }) async {
    debugPrint('Uploading photo...');
    debugPrint('Description: $description');

    final isViolation = description.trimLeft().startsWith('⚠️');
    
    // 1) Create Content (metadata)
    final contentResponse = await _openapi
        .getContentResourceApi()
        .createContent(
          contentDTO: ContentDTO(
            (b) => b
              ..contentType = 'image/jpeg'
              ..appUser = (AppUserDTOBuilder()
                ..id = _currentUser?.id
                ..phoneNumber = _currentUser?.phoneNumber),
          ),
          headers: {'Authorization': 'Bearer ${Openapi.bearerToken}'},
        );
        debugPrint('Content created. statusCode=${contentResponse.statusCode}, data=${contentResponse.data}');
        debugPrint('Content ID: ${Openapi.bearerToken}');

    if (contentResponse.statusCode != 201 || contentResponse.data == null) {
      throw Exception('Failed to create content');
    }

    final contentData = contentResponse.data!;

    // 2) Create Content Blob (actual bytes)
    await _openapi.getContentBlobResourceApi().createContentBlob(
      contentBlobDTO: ContentBlobDTO(
        (b) => b
          ..content = (ContentDTOBuilder()..id = contentData.id)
          ..contentBlob = ListBuilder<String>(
            imageBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).toList(),
          ),
      ),
      headers: {'Authorization': 'Bearer ${Openapi.bearerToken}'},
    );
    await _openapi.getContentBlobResourceApi().createContentBlob(
      contentBlobDTO: ContentBlobDTO(
        (b) => b
          ..content = (ContentDTOBuilder()..id = contentData.id)
          ..contentBlob = ListBuilder<String>(
            imageBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).toList(),
          ),
      ),
      headers: {'Authorization': 'Bearer ${Openapi.bearerToken}'},
    );

    debugPrint('Evidence uploaded. contentId=${contentData.id}');

    // 3) Create Violation (rule: only when AI says it is a violation)
    if (!isViolation) return;

    // The backend expects a ViolationDTO referencing evidence via ContentDTO.
    // Map our rule output into violationType and description into content.status.
    // If your backend uses a different field for description, adjust here.
    final violationType = 'TRAFFIC_VIOLATION';

    await _openapi.getViolationResourceApi().createViolation(
      violationDTO: ViolationDTO(
        (b) => b
          ..violationType = violationType
          ..content = (ContentDTOBuilder()
            ..id = contentData.id
            ..status = description),
      ),
      headers: {'Authorization': 'Bearer ${Openapi.bearerToken}'},
    );

    debugPrint('Violation created.');

    await _openapi.getPointsResourceApi().createPoints(
      pointsDTO: PointsDTO(
        (b) => b
          ..appUser = (AppUserDTOBuilder()..id = _currentUser?.id)
          ..pointsEarned = 10
          ..uploadDateTime = DateTime.now().toUtc().toIso8601String() as DateTime
        
            ),
      headers: {'Authorization': 'Bearer ${Openapi.bearerToken}'},
    );
  }
}
