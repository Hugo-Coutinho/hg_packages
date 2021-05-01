import 'dart:async';
import 'package:database/store_name.dart';
import 'package:sembast/sembast.dart';

abstract class DatabaseGateway {
  Future create(String id, Map<String, dynamic> map, StoreName store);
  Future<List<Map<String, dynamic>>> findAll(StoreName store);
  Future remove(String id, StoreName store);
}

class DatabaseGatewayImpl extends DatabaseGateway {
  final Database _db;
  DatabaseGatewayImpl(this._db);

  @override
  Future create(String id, Map<String, dynamic> map, StoreName store) async {
    final storeMap = stringMapStoreFactory.store(store.toShortString());
    await storeMap.record(id).put(_db, map);
  }

  @override
  Future<List<Map<String, dynamic>>> findAll(StoreName store) async {
    final storeMap = stringMapStoreFactory.store(store.toShortString());
    final allRecords = await storeMap.find(_db);
    return allRecords.map((record) => record.value).toList();
  }

  @override
  Future remove(String id, StoreName store) async {
    final storeMap = stringMapStoreFactory.store(store.toShortString());
    await storeMap.record(id).delete(_db);
  }
}