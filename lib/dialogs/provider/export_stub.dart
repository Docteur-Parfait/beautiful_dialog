import 'dart:typed_data';
import 'export_interface.dart';

class ExportProviderImpl implements ExportProvider {
  @override
  Future<void> exportBytes({
    required Uint8List bytes,
    required String fileName,
    required String mimeType,
  }) async {
    throw UnsupportedError('Exports are not supported on this platform.');
  }
}
