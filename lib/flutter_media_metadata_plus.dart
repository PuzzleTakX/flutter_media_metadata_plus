/// ## flutter_media_metadata_plus
///
/// A high-performance Flutter plugin to read metadata and album art of media files.
///
/// MIT License.
/// Copyright (c) 2024-2026, Bahman Teymouri Nezhad (PuzzleTakX) (Maintainer).
///
library flutter_media_metadata_plus;

export 'package:flutter_media_metadata_plus/src/flutter_media_metadata_native.dart'
    if (dart.library.js_interop) 'package:flutter_media_metadata_plus/src/flutter_media_metadata_web.dart';
export 'package:flutter_media_metadata_plus/src/models/metadata.dart';
