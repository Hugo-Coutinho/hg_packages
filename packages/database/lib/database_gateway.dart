import 'dart:async';
import 'package:sembast/sembast.dart';
import 'database_exception.dart';

abstract class DatabaseGateway {
  Future create(String id, Map<String, dynamic> map, String store);
  Future update(String id, Map<String, dynamic> map, String store);
  Future<List<Map<String, dynamic>>> findAll(String store);
  Future remove(String id, String store);
}

class DatabaseGatewayImpl extends DatabaseGateway {
  final Database _db;
  DatabaseGatewayImpl(this._db);

  @override
  Future create(String id, Map<String, dynamic> map, String store) async {
    final storeMap = stringMapStoreFactory.store(store);
    await storeMap.record(id).put(_db, map).catchError( (error) { throw DatabaseGatewayException(); });
  }

  @override
  Future update(String id, Map<String, dynamic> map, String store) async {
    final storeMap = stringMapStoreFactory.store(store);
    await storeMap.record(id).update(_db, map);
  }

  @override
  Future<List<Map<String, dynamic>>> findAll(String store) async {
    try {
      final storeMap = stringMapStoreFactory.store(store);
      final allRecords = await storeMap.find(_db);
      return allRecords.map((record) => record.value).toList();
    } catch(e) {
      throw DatabaseGatewayException();
    }
  }

  @override
  Future remove(String id, String store) async {
    final storeMap = stringMapStoreFactory.store(store);
    await storeMap.record(id).delete(_db).catchError( (error) { throw DatabaseGatewayException(); });
  }
}