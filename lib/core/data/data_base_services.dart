import '/domain/entities/base_entity.dart';
import 'data_base.dart';

const String _whereId = 'id = ?';

abstract class DataBaseServices<R extends BaseEntity> {
  Future<void> _open() async {
    CreateDataBase.open();
  }

  Future<void> insert(R model) async {
    await _open();
    CreateDataBase.db.insert(model.table, model.toMap);
  }

  Future<void> delete(R model) async {
    await _open();
    await CreateDataBase.db
        .delete(model.table, where: _whereId, whereArgs: [model.id]);
  }

  Future<void> update(R model) async {
    await _open();
    await CreateDataBase.db.update(model.table, model.toMap,
        where: _whereId, whereArgs: [model.id]);
  }

  ///To retrieve data
  ///
  ///by default select all elements  to filter data use [condition] param
  ///
  ///   ex: condition: 'id = ${element.id}'
  Future<List<R>> retrieveAll(
    String table,
    R Function(Map<String, dynamic> map) convertor, {
    String? condition,
  }) async {
    String query = 'SELECT * FROM $table';
    if (condition != null) query += ' WHERE $condition';
    return _retrieveByQuery(query, convertor);
  }

  Future<List<R>> _retrieveByQuery(
      String query, R Function(Map<String, dynamic> map) convertor) async {
    try {
      await _open();
      var map = await CreateDataBase.db.rawQuery(query);
      return map.map(convertor).toList().cast();
    } catch (e) {
      return [];
    }
  }
}
