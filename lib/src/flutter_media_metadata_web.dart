/// This file is a part of flutter_media_metadata_plus (https://github.com/PuzzleTakX/flutter_media_metadata_plus).
///

/// Copyright (c) 2024-2026, Bahman Teymouri Nezhad (PuzzleTakX) (Maintainer).
/// All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:js' show allowInterop;
// ignore: deprecated_member_use
import 'package:js/js.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:flutter_media_metadata_plus/src/models/metadata.dart';

/// ## MetadataRetriever
///
/// Use [MetadataRetriever.fromBytes] to extract [Metadata] from bytes of media file.
///
class MetadataRetriever {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'flutter_media_metadata_plus',
      const StandardMethodCodec(),
      registrar,
    );
    final pluginInstance = MetadataRetriever();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) => throw PlatformException(
        code: 'Unimplemented',
        details:
            'flutter_media_metadata_plus for web doesn\'t implement \'${call.method}\'',
      );

  /// Extracts [Metadata] from a [File]. Works on Windows, Linux, macOS, Android & iOS.
  static Future<Metadata> fromFile(dynamic _) async {
    throw UnimplementedError(
      '[MetadataRetriever.fromFile] is not supported on web. This method is only available for Windows, Linux, macOS, Android or iOS. Use [MetadataRetriever.fromBytes] instead.',
    );
  }

  /// Extracts [Metadata] from [Uint8List]. Works only on Web.
  static Future<Metadata> fromBytes(Uint8List bytes) {
    final completer = Completer<Metadata>();
    MediaInfo(
      _Opts(
        chunkSize: 256 * 1024,
        coverData: true,
        format: 'JSON',
      ),
      allowInterop(
        (mediainfo) {
          mediainfo
              .analyzeData(
            allowInterop(() => bytes.length),
            allowInterop(
              (chunkSize, offset) => _Promise(
                allowInterop(
                  (resolve, reject) {
                    resolve(
                      bytes.sublist(
                        offset,
                        offset + (chunkSize as int),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
              .then(
            allowInterop(
              (result) {
                var rawMetadataJson = jsonDecode(result as String)['media']['track'];
                bool isFound = false;
                final tracks =
                    rawMetadataJson is List ? rawMetadataJson : [rawMetadataJson];

                dynamic targetData;
                for (final data in tracks) {
                  if (data is Map && data['@type'] == 'General') {
                    isFound = true;
                    targetData = data;
                    break;
                  }
                }

                if (!isFound) {
                  completer.completeError(Exception('Metadata not found'));
                  return;
                }

                final metadata = <String, dynamic>{
                  'metadata': {},
                  'albumArt': targetData['Cover_Data'] != null
                      ? base64Decode(targetData['Cover_Data'] as String)
                      : null,
                  'filePath': null,
                };
                _kMetadataKeys.forEach((key, value) {
                  metadata['metadata'][key] = targetData[value];
                });
                completer.complete(Metadata.fromJson(metadata));
              },
            ),
            allowInterop(
              () {
                completer.completeError(Exception('MediaInfo analysis failed'));
              },
            ),
          );
        },
      ),
      allowInterop(
        () {
          completer.completeError(Exception('MediaInfo initialization failed'));
        },
      ),
    );
    return completer.future;
  }
}

@JS('Promise')
class _Promise<T> {
  external _Promise(
      void Function(void Function(T result) resolve, Function reject) executor);
  external _Promise then(void Function(T result) onFulfilled,
      [Function onRejected]);
}

@JS('MediaInfo')
// ignore: non_constant_identifier_names
external String MediaInfo(
  Object opts,
  void Function(_MediaInfo) successCallback,
  void Function() erroCallback,
);

@JS()
@anonymous
class _Opts {
  external int get chunkSize;
  external bool get coverData;
  external String get format;

  external factory _Opts({int chunkSize, bool coverData, String format});
}

@JS()
@anonymous
class _MediaInfo {
  external _Promise<dynamic> analyzeData(int Function() getSize,
      _Promise<Uint8List> Function(dynamic chunkSize, dynamic offset) promise);
}

const _kMetadataKeys = <String, String>{
  "trackName": "Track",
  "trackArtistNames": "Performer",
  "albumName": "Album",
  "albumArtistName": "Album_Performer",
  "trackNumber": "Track_Position",
  "albumLength": "Track_Position_Total",
  "year": "Recorded_Date",
  "genre": "Genre",
  "writerName": "WrittenBy",
  "trackDuration": "Duration",
  "bitrate": "OverallBitRate",
};
