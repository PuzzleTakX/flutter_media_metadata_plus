## 1.2.9

- Fixed dangling library doc comments to improve static analysis score.

## 1.2.8

- Added Swift Package Manager (SPM) support for iOS and macOS.
- Improved pub.dev score for platform support.

## 1.2.7

- Cleaned up unnecessary imports in Web platform.
- Refactored JS interop for better stability and analysis scores.

## 1.2.6

- Refactored conditional exports to use `dart.library.js_interop`.
- Synchronized method signatures across platforms to fix analysis errors.
- Cleaned up all traces of `allowInterop` for WASM compatibility.
- Fixed 0/20 platform support score on pub.dev.

## 1.2.5

- Migrated from `package:js` to `dart:js_interop` for Web platform.
- Full compatibility with WASM and modern Dart standards.
- Removed discontinued `js` dependency.
- Fixed `allowInterop` analysis issues for pub.dev scores.
- Raised minimum SDK to Dart 3.3.0 and Flutter 3.19.0.

## 1.2.4

- Fixed `allowInterop` analysis error on Web platform for pub.dev scores.
- Improved explicit JS interop imports.

## 1.2.3

- Fixed `allowInterop` undefined error on Web platform.
- Improved JS interop reliability for metadata extraction on Web.

## 1.2.1

- Fixed Gradle configuration issue for newer Flutter versions.
- Refactored `FilePicker` usage in example for better error handling.
- Removed redundant imports and fixed `allowInterop` undefined error on Web.
- Added package logo and screenshots for pub.dev.
- Updated dependencies for better compatibility.

## 1.2.0

- Migrated to Dart 3.0 and Flutter 3.10.
- Renamed package to `flutter_media_metadata_plus`.
- Updated repository to [PuzzleTakX/flutter_media_metadata_plus](https://github.com/PuzzleTakX/flutter_media_metadata_plus).
- Improved metadata extraction performance and processing speed across all platforms.
- Optimized memory usage during album art retrieval.
- Updated Android Gradle Plugin to 8.2.1 and Gradle to 8.5.
- Raised minimum Android SDK to 19 and target SDK to 34.
- Refactored documentation and project structure for better maintenance.

## 1.0.0

- Now supporting all platforms Windows, Linux, macOS, Android, iOS & Web.
- Add web support (@alexmercerind).
- Add iOS support (@DiscombobulatedDrag).
- Revert to using `CompletableFuture` on Android (@alexmercerind).

## 0.1.3

- Add macOS support (@DiscombobulatedDrag).
- Add optional `createNewInstance` argument to `MetadataRetriever.fromFile` (@alexmercerind).
  - Works only on Android.
  - Creates new `MediaMetadataRetriever` instance.
  - Forces `CompletableFuture`.

## 0.1.2

- Add iOS support (@DiscombobulatedDrag)
- Linux: Use `wcstombs` for `std::wstring` conversion (@alexmercerind).
- Linux: Fix segmentation fault with no album art files (@alexmercerind).
- Windows: Fix media having no tags & embedded album art container causing crash (@alexmercerind).
- Windows: Fix UTF16 tags not being parsed properly (@alexmercerind).
- Windows: Add `file_path` to metadata (@alexmercerind).
- Windows & Linux: Fix FLAC album arts (@alexmercerind).
- Windows & Linux: Use Format `Stream_General` for METADATA_BLOCK_PICTURE detection (@alexmercerind).

## 0.1.1

- Added Windows support.
- Moved `MediaMetadataRetriever.setDataSource` & `MediaMetadataRetriever.extractMetadata` calls to another non-UI thread on Android.
- Improved Linux support.
- Added support for embedded album arts on Windows & Linux.
- Changed API to single call, `MetadataRetriever.fromFile`.

## 0.1.0

- Migrated to null-safety
- `trackArtistNames` is now `List<String>` instead of `List<dynamic>`

## 0.0.3+2

- Update documentation.

## 0.0.3

- [media_metadata_retriever](https://github.com/PuzzleTakX/flutter_media_metadata_plus) is now [flutter_media_metadata_plus](https://github.com/PuzzleTakX/flutter_media_metadata_plus).
- Added Linux support with album arts.
- Uses [MediaInfoLib](https://github.com/MediaArea/MediaInfoLib) on Linux.

## 0.0.1+4

- Updated Metadata class structure.
- Now bitrate & duration in stored in Metadata itself.

## 0.0.1+3

- More minor changes.

## 0.0.1+2

- Minor updates to documentation.

## 0.0.1

- Support for retriving metadata of a media file in Android.
- Uses [MediaMetadataRetriever](https://developer.android.com/reference/android/media/MediaMetadataRetriever).
