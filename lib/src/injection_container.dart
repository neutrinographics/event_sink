import 'package:event_sync/event_sync.dart';
import 'package:get_it/get_it.dart';

/// Service Locator (sl)

final sl = GetIt.instance;

void init() {
  print("The injection container is ready");
  sl.registerLazySingleton<NetworkController>(() => DefaultNetworkController());

  // Repositories

  // Data sources

  // Core

  // External
}
