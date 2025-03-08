import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker? connectionChecker;

  NetworkInfoImpl([this.connectionChecker]);

  @override
  Future<bool> get isConnected async {
    // For web platform, always return true
    if (kIsWeb) {
      return true;
    }

    // For non-web platforms, use the connection checker
    return await connectionChecker?.hasConnection ?? true;
  }
}
