/// ## flutter_media_metadata_plus
///
/// A high-performance Flutter plugin to read metadata and album art of media files.
///
/// MIT License.
/// Copyright (c) 2024-2026, Bahman Teymouri Nezhad (PuzzleTakX) (Maintainer).
///
/// _Minimal Example_
/// ```dart
/// final metadata = await MetadataRetriever.fromFile(file);
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
library flutter_media_metadata_plus;

export 'package:flutter_media_metadata_plus/src/flutter_media_metadata_native.dart'
    if (dart.library.html) 'package:flutter_media_metadata_plus/src/flutter_media_metadata_web.dart';
export 'package:flutter_media_metadata_plus/src/models/metadata.dart';
