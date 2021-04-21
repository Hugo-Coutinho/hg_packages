import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final GetIt coreLocator = GetIt.instance;

setupCoreLocator() async {
  coreLocator.registerFactory(() => Logger());
}