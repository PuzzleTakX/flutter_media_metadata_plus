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
/// ```dart
/// final metadata = MetadataRetriever.fromFile(file);
/// String? trackName = metadata.trackName;
/// List<String>? trackArtistNames = metadata.trackArtistNames;
/// String? albumName = metadata.albumName;
/// String? albumArtistName = metadata.albumArtistName;
/// int? trackNumber = metadata.trackNumber;
/// int? albumLength = metadata.albumLength;
/// int? year = metadata.year;
/// String? genre = metadata.genre;
/// String? authorName = metadata.authorName;
/// String? writerName = metadata.writerName;
/// int? discNumber = metadata.discNumber;
/// String? mimeType = metadata.mimeType;
/// int? trackDuration = metadata.trackDuration;
/// int? bitrate = metadata.bitrate;
/// Uint8List? albumArt = metadata.albumArt;
/// ```
///
class MetadataRetriever {
  /// Extracts [Metadata] from a [File]. Works on Windows, Linux, macOS, Android & iOS.
  static Future<Metadata> fromFile(File file) async {
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

  /// Extracts [Metadata] from [Uint8List]. Works only on Web.
  static Future<Metadata> fromBytes(dynamic _) async {
    throw UnimplementedError(
      '[MetadataRetriever.fromBytes] is not supported on ${Platform.operatingSystem}. This method is only available for web. Use [MetadataRetriever.fromFile] instead.',
    );
  }
}

var _kChannel = const MethodChannel('flutter_media_metadata_plus');
