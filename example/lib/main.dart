import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_media_metadata_plus/flutter_media_metadata_plus.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF121212),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? _child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'flutter_media_metadata_plus',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final result = await FilePicker.pickFiles();
            if (result == null || result.count == 0) return;
            if (kIsWeb) {
              /// Use [MetadataRetriever.fromBytes] on Web.
              try {
                final metadata = await MetadataRetriever.fromBytes(
                  result.files.first.bytes!,
                );
                showData(metadata);
              } catch (_) {
                setState(() {
                  _child = const Text('Couldn\'t extract metadata');
                });
              }
            } else {
              /// Use [MetadataRetriever.fromFile] on Windows, Linux, macOS, Android or iOS.
              try {
                final metadata = await MetadataRetriever.fromFile(
                  File(result.files.first.path!),
                );
                showData(metadata);
              } catch (_) {
                setState(() {
                  _child = const Text('Couldn\'t extract metadata');
                });
              }
            }
          } catch (_) {
            setState(() {
              _child = const Text('Couldn\'t select file');
            });
          }
        },
        child: const Icon(Icons.file_present),
      ),
      body: Center(
        child: _child ?? const Text('Press FAB to open a media file'),
      ),
    );
  }

  void showData(Metadata metadata) {
    setState(() {
      _child = ListView(
        scrollDirection: MediaQuery.of(context).size.height >
                MediaQuery.of(context).size.width
            ? Axis.vertical
            : Axis.horizontal,
        children: [
          if (MediaQuery.of(context).size.height <=
              MediaQuery.of(context).size.width)
            const SizedBox(
              width: 16.0,
            ),
          metadata.albumArt == null
              ? Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height >
                          MediaQuery.of(context).size.width
                      ? MediaQuery.of(context).size.width
                      : 256.0,
                  width: MediaQuery.of(context).size.height >
                          MediaQuery.of(context).size.width
                      ? MediaQuery.of(context).size.width
                      : 256.0,
                  child: const Text('null'),
                )
              : Image.memory(
                  metadata.albumArt!,
                  height: MediaQuery.of(context).size.height >
                          MediaQuery.of(context).size.width
                      ? MediaQuery.of(context).size.width
                      : 256.0,
                  width: MediaQuery.of(context).size.height >
                          MediaQuery.of(context).size.width
                      ? MediaQuery.of(context).size.width
                      : 256.0,
                ),
          const SizedBox(
            width: 16.0,
          ),
          SingleChildScrollView(
            scrollDirection: MediaQuery.of(context).size.height >
                    MediaQuery.of(context).size.width
                ? Axis.horizontal
                : Axis.vertical,
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Text(
                    'Property',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Value',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              rows: [
                DataRow(
                  cells: [
                    const DataCell(Text('trackName')),
                    DataCell(Text('${metadata.trackName}')),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('trackArtistNames')),
                    DataCell(Text('${metadata.trackArtistNames}')),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('albumName')),
                    DataCell(Text('${metadata.albumName}')),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('albumArtistName')),
                    DataCell(Text('${metadata.albumArtistName}')),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('trackNumber')),
                    DataCell(Text('${metadata.trackNumber}')),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('albumLength')),
                    DataCell(Text('${metadata.albumLength}')),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('year')),
                    DataCell(Text('${metadata.year}')),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('genre')),
                    DataCell(Text('${metadata.genre}')),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('authorName')),
                    DataCell(Text('${metadata.authorName}')),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('writerName')),
                    DataCell(Text('${metadata.writerName}')),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('discNumber')),
                    DataCell(Text('${metadata.discNumber}')),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('mimeType')),
                    DataCell(Text('${metadata.mimeType}')),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('trackDuration')),
                    DataCell(Text('${metadata.trackDuration}')),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('bitrate')),
                    DataCell(Text('${metadata.bitrate}')),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('filePath')),
                    DataCell(Text('${metadata.filePath}')),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
