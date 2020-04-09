import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dao/anotacao_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'keepit.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(AnotacaoDao.tabelaSql);
  }, version: 1);
}