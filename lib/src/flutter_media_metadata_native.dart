/// This file is a part of flutter_media_metadata_plus (https://github.com/PuzzleTakX/flutter_media_metadata_plus).
///
/// Copyright (c) 2021-2022, Hitesh Kumar Saini (Original Author).
/// Copyright (c) 2024-2026, Bahman Teymouri Nezhad (PuzzleTakX) (Maintainer).
/// All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'dart:io';
import 'package:flutter/services.dart';

import 'package:flutter_media_metadata_plus/src/models/metadata.dart';

/// ## MetadataRetriever
///
/// Use [MetadataRetriever.fromFile] to extract [Metadata] from a media file.
///
class MetadataRetriever {
  /// Extracts [Metadata] from a [File]. Works on Windows, Linux, macOS, Android & iOS.
  static Future<Metadata> fromFile(dynamic file) async {
    if (file is! File) {
      throw ArgumentError('file must be a File object');
    }
    final Map<dynamic, dynamic>? metadata = await _kChannel.invokeMethod(
      'MetadataRetriever',
      {
        'filePath': file.path,
      },
    );

    if (metadata == null) {
      throw Exception('Failed to extract metadata from file: ${file.path}');
    }

    final result = Map<String, dynamic>.from(metadata);
    result['filePath'] = file.path;
    return Metadata.fromJson(result);
  }

  /// Extracts [Metadata] from [Uint8List]. Not supported on native platforms.
  static Future<Metadata> fromBytes(dynamic _) async {
    throw UnimplementedError(
      '[MetadataRetriever.fromBytes] is only available for web. Use [MetadataRetriever.fromFile] instead.',
    );
  }
}

var _kChannel = const MethodChannel('flutter_media_metadata_plus');
