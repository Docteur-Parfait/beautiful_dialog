import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

Future<void> exportBytes({
  required Uint8List bytes,
  required String fileName,
  required String mimeType,
}) async {
  if (kIsWeb) {
    _exportBytesWeb(bytes: bytes, fileName: fileName, mimeType: mimeType);
  } else {
    throw UnsupportedError('exportBytes is only supported on the web');
  }
}

void _exportBytesWeb({
  required Uint8List bytes,
  required String fileName,
  required String mimeType,
}) {
  // Import 'dart:html' only if running in a web environment

  final blob = html.Blob([bytes], mimeType);
  final url = html.Url.createObjectUrlFromBlob(blob);

  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', fileName)
    ..click();

  html.Url.revokeObjectUrl(url);
}
