import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';

Future<void> exportBytes({
  required Uint8List bytes,
  required String fileName,
  required String mimeType,
}) async {
  final directory = await getTemporaryDirectory();
  final file = File('${directory.path}/$fileName');
  await file.writeAsBytes(bytes);

  await Share.shareXFiles([XFile(file.path, mimeType: mimeType)]);
}
