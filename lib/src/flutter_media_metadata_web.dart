/// This file is a part of flutter_media_metadata_plus (https://github.com/PuzzleTakX/flutter_media_metadata_plus).
///
/// Copyright (c) 2024-2026, Bahman Teymouri Nezhad (PuzzleTakX) (Maintainer).
/// All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
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

  /// Extracts [Metadata] from a [File]. Not supported on web.
  static Future<Metadata> fromFile(dynamic _) async {
    throw UnimplementedError(
      '[MetadataRetriever.fromFile] is not supported on web. Use [MetadataRetriever.fromBytes] instead.',
    );
  }

  /// Extracts [Metadata] from [Uint8List]. Works only on Web.
  static Future<Metadata> fromBytes(dynamic bytes) {
    if (bytes is! Uint8List) {
      throw ArgumentError('bytes must be a Uint8List');
    }
    final completer = Completer<Metadata>();

    final successCallback = (JSObject mediainfo) {
      final info = mediainfo as _MediaInfo;
      info
          .analyzeData(
        (() => bytes.length.toJS).toJS,
        ((JSNumber chunkSize, JSNumber offset) {
          final start = offset.toDartInt;
          var end = start + chunkSize.toDartInt;
          if (end > bytes.length) end = bytes.length;
          return Future.value(bytes.sublist(start, end).toJS).toJS;
        }).toJS,
      )
          .toDart
          .then(
        (JSString result) {
          final resultString = result.toDart;
          try {
            var rawMetadataJson = jsonDecode(resultString)['media']['track'];
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

            final metadataMap = <String, dynamic>{
              'metadata': {},
              'albumArt': targetData['Cover_Data'] != null
                  ? base64Decode(targetData['Cover_Data'] as String)
                  : null,
              'filePath': null,
            };
            _kMetadataKeys.forEach((key, value) {
              metadataMap['metadata'][key] = targetData[value];
            });
            completer.complete(Metadata.fromJson(metadataMap));
          } catch (e) {
            completer.completeError(e);
          }
        },
      ).onError((error, stackTrace) {
        completer.completeError(Exception('MediaInfo analysis failed: $error'));
      });
    }.toJS;

    final errorCallback = (() {
      completer.completeError(Exception('MediaInfo initialization failed'));
    }).toJS;

    final opts = JSObject();
    _setChunkSize(opts, (256 * 1024).toJS);
    _setCoverData(opts, true.toJS);
    _setFormat(opts, 'JSON'.toJS);

    mediaInfoInit(opts, successCallback, errorCallback);

    return completer.future;
  }
}

@JS('MediaInfo')
external void mediaInfoInit(
  JSObject opts,
  JSFunction successCallback,
  JSFunction errorCallback,
);

@JS()
@staticInterop
class _MediaInfo {}

extension _MediaInfoExtension on _MediaInfo {
  @JS('analyzeData')
  external JSPromise<JSString> analyzeData(
    JSFunction getSize,
    JSFunction readChunk,
  );
}

@JS()
extension on JSObject {
  @JS('chunkSize')
  external set chunkSize(JSNumber value);
  @JS('coverData')
  external set coverData(JSBoolean value);
  @JS('format')
  external set format(JSString value);
}

void _setChunkSize(JSObject o, JSNumber v) => o.chunkSize = v;
void _setCoverData(JSObject o, JSBoolean v) => o.coverData = v;
void _setFormat(JSObject o, JSString v) => o.format = v;

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
