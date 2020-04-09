import 'package:lista_anotacoes/models/anotacao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:lista_anotacoes/database/anotacao_database.dart';

class AnotacaoDao {
  static const String tabelaSql = 'CREATE TABLE $_nomeTabela('
      '$_id INTEGER PRIMARY KEY, '
      '$_titulo TEXT, '
      '$_observacao TEXT)';

  static const String _nomeTabela = 'anotacao';
  static const String _id = 'id';
  static const String _titulo = 'titulo';
  static const String _observacao = 'observacao';

  Future<int> save(Anotacao anotacao) async {
    final Database db = await getDatabase();
    Map<String, dynamic> anotacaoMap = _toMap(anotacao);
    return db.insert(_nomeTabela, anotacaoMap);
  }

  Map<String, dynamic> _toMap(Anotacao anotacao) {
    final Map<String, dynamic> anotacaoMap = Map();
    anotacaoMap[_titulo] = anotacao.titulo;
    anotacaoMap[_observacao] = anotacao.observacao;
    return anotacaoMap;
  }

  Future<List<Anotacao>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_nomeTabela);
    List<Anotacao> anotacoes = _toList(result);
    return anotacoes;
  }

  List<Anotacao> _toList(List<Map<String, dynamic>> result) {
    final List<Anotacao> anotacoes = List();
    for (Map<String, dynamic> row in result) {
      final Anotacao anotacao = Anotacao(
        row[_id],
        row[_titulo],
        row[_observacao],
      );
      anotacoes.add(anotacao);
    }
    return anotacoes;
  }

  Future<int> update(Anotacao anotacao) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> anotacaoMap = _toMap(anotacao);
    return db.update(
      _nomeTabela,
      anotacaoMap,
      where: 'id = ?',
      whereArgs: [anotacao.id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _nomeTabela,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}