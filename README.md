# flutter_media_metadata_plus

[![Pub Version](https://img.shields.io/pub/v/flutter_media_metadata_plus?logo=flutter&color=blue)](https://pub.dev/packages/flutter_media_metadata_plus)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A high-performance Flutter plugin designed to extract 🔖 metadata and 🎵 album art from media files across all platforms. This package is a modernized fork and continuation of the original `flutter_media_metadata`, optimized for Dart 3 and high-speed processing.

---

## 🚀 Key Features

*   **Multi-Platform Support:** Works seamlessly on Android, iOS, Windows, Linux, macOS, and Web.
*   **High Performance:** Optimized native implementations (C++, Java, Swift) for lightning-fast metadata extraction.
*   **Rich Metadata:** Retrieve track name, artists, album info, genre, year, duration, bitrate, and more.
*   **Album Art Extraction:** Highly efficient retrieval of embedded album covers.
*   **Modern Dart:** Fully compatible with Dart 3.x and Null Safety.

---

## 📊 Performance & Optimization

`flutter_media_metadata_plus` is built with performance in mind:
*   **Asynchronous Processing:** Heavy lifting is done on background threads/isolates to keep the UI smooth.
*   **Native Efficiency:** Utilizes `MediaMetadataRetriever` on Android, `AVFoundation` on iOS/macOS, and `MediaInfoLib` on Windows/Linux for optimal speed.
*   **Memory Efficient:** Optimized memory management when handling high-resolution album arts.

---

## 💻 Platforms

| Platform | Support | Backend |
| :--- | :---: | :--- |
| **Android** | ✔️ | `MediaMetadataRetriever` |
| **iOS** | ✔️ | `AVFoundation` |
| **Windows** | ✔️ | `MediaInfoLib` (C++) |
| **Linux** | ✔️ | `MediaInfoLib` (C++) |
| **macOS** | ✔️ | `AVFoundation` |
| **Web** | ✔️ | `mediainfo.js` |

---

## 📦 Installation

Add `flutter_media_metadata_plus` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_media_metadata_plus: ^1.2.0
```

### Web Configuration

For Web support, add the following script to your `index.html` before the `main.dart.js` script:

```html
<script type="text/javascript" src="https://unpkg.com/mediainfo.js/dist/mediainfo.min.js"></script>
```

---

## 📖 Usage

### Mobile & Desktop (File based)

```dart
import 'dart:io';
import 'package:flutter_media_metadata_plus/flutter_media_metadata_plus.dart';

final metadata = await MetadataRetriever.fromFile(File(filePath));

print('Title: ${metadata.trackName}');
print('Artist: ${metadata.trackArtistNames?.join(', ')}');
print('Album: ${metadata.albumName}');
print('Duration: ${metadata.trackDuration}ms');

if (metadata.albumArt != null) {
  // Use Image.memory(metadata.albumArt!)
}
```

### Web (Bytes based)

```dart
import 'package:flutter_media_metadata_plus/flutter_media_metadata_plus.dart';

final metadata = await MetadataRetriever.fromBytes(uInt8ListBytes);
```

---

## 👨‍💻 Maintainer

**Bahman Teymouri Nezhad (PuzzleTakX)**

I am a passionate Flutter developer focused on building high-quality, performant tools for the community. This package is part of an effort to provide reliable and up-to-date media handling solutions for Flutter developers.

---

## 📄 License

This library is licensed under the **MIT License**.

Copyright (c) 2021-2022 Hitesh Kumar Saini (Original Author)
Copyright (c) 2024-2026 Bahman Teymouri Nezhad (PuzzleTakX) (Maintainer)
