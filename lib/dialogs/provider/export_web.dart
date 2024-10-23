import 'dart:html' as html;
import 'dart:typed_data';
import 'export_interface.dart';

class ExportProviderImpl implements ExportProvider {
  @override
  Future<void> exportBytes({
    required Uint8List bytes,
    required String fileName,
    required String mimeType,
  }) async {
    final blob = html.Blob([bytes], mimeType);
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();

    html.Url.revokeObjectUrl(url);
  }
}
