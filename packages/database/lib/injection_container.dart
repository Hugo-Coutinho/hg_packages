import 'package:core/get_it/injection_container.dart';
import 'package:database/database.dart';

Future setupDatabaseManagerLocator() async {
  final db = await DatabaseManager.instance.database;
  coreLocator.registerFactory<DatabaseGateway>(() => DatabaseGatewayImpl(db));
}