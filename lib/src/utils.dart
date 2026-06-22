// This file is a part of flutter_media_metadata_plus (https://github.com/PuzzleTakX/flutter_media_metadata_plus).
//
// Copyright (c) 2021-2022, Hitesh Kumar Saini (Original Author).
// Copyright (c) 2024-2026, Bahman Teymouri Nezhad (PuzzleTakX) (Maintainer).
// All rights reserved.
// Use of this source code is governed by MIT license that can be found in the LICENSE file.

/// Safely parses [int] from a [String].
int? parseInteger(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is int) {
    return value;
  } else if (value is String) {
    try {
      try {
        return int.parse(value);
      } catch (_) {
        return int.parse(value.split('/').first);
      }
    } catch (_) {}
  }
  return null;
}
