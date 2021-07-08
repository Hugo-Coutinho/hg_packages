import 'package:core/network/network_manager.dart';
import 'package:core/preferences/preferences_manager.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt coreLocator = GetIt.instance;

setupCoreLocator() async {
  coreLocator.registerFactory(() => Logger());
  coreLocator.registerFactory(() => DataConnectionChecker());
  final preferences = await SharedPreferences.getInstance();
  coreLocator.registerFactory<PreferencesManager>(() => PreferencesManagerImpl(preferences));
  coreLocator.registerFactory<NetworkInfoManager>(() => NetworkInfoManagerImpl(coreLocator(), coreLocator()));
}