import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<void> exportDB() async {
  final dir = await getApplicationDocumentsDirectory();
  final dbFile = File('${dir.path}/icash.db');

  final download = Directory('/storage/emulated/0/Download/i-cash');

  if (!await download.exists()) {
    await download.create(recursive: true);
  }

  await dbFile.copy('${download.path}/icash_backup.db');
}
