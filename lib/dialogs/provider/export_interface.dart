import 'dart:typed_data';

abstract class ExportProvider {
  Future<void> exportBytes({
    required Uint8List bytes,
    required String fileName,
    required String mimeType,
  });
}
