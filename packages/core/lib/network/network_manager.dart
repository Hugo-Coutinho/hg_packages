import 'package:core/network/network_exception.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:logger/logger.dart';

abstract class NetworkInfoManager {
  Future<bool> get isConnected;
  Future connectionCheck();
}

class NetworkInfoManagerImpl implements NetworkInfoManager {
  final DataConnectionChecker _connectionChecker;
  final Logger _logger;

  NetworkInfoManagerImpl(this._connectionChecker, this._logger);

  @override
  Future<bool> get isConnected => _connectionChecker.hasConnection;

  @override
  Future connectionCheck() async {
    if (await isConnected) {
      _logger.d('device with internet connection ok');
      return Future.value();
    }
    _logger.e('device without internet connection');
    throw NetworkException();
  }
}