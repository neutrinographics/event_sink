import 'package:recase/recase.dart';

/// These are global sync settings
enum ConfigOption {
  /// The remote API host
  serverHost,

  /// The API authentication token
  authToken,

  /// The Pin to use for authentication
  pin,

  /// The screen lock timeout in minutes
  lockTimeout,
}

extension ConfigOptionsExtension on ConfigOption {
  /// Returns a formatted key that can be used in the cache
  String get key {
    return ReCase(name).snakeCase;
  }
}