import 'package:clock/clock.dart';

import 'package:event_sync/event_sync.dart';
import 'package:event_sync/src/core/data/id_generator.dart';
import 'package:event_sync/src/core/data/local_cache.dart';
import 'package:event_sync/src/core/network/network.dart';
import 'package:event_sync/src/core/time/time_info.dart';
import 'package:event_sync/src/feature/data/local/data_sources/config_local_data_source.dart';
import 'package:event_sync/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sync/src/feature/data/local/models/config_model.dart';
import 'package:event_sync/src/feature/data/local/models/event_model.dart';
import 'package:event_sync/src/feature/data/remote/data_sources/event_remote_data_source.dart';
import 'package:event_sync/src/feature/data/repositories/event_repository_impl.dart';
import 'package:event_sync/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sync/src/feature/domain/use_cases/add_event.dart';
import 'package:event_sync/src/feature/domain/use_cases/apply_events.dart';
import 'package:event_sync/src/feature/domain/use_cases/sync_events.dart';
import 'package:event_sync/src/sync_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

/// Service Locator (sl)

final sl = GetIt.instance;

void init() {
  // this is a test
  sl.registerLazySingleton<NetworkController>(() => DefaultNetworkController());

  // Controllers
  sl.registerFactory(() => SyncController(
        syncEvents: sl(),
        applyEvents: sl(),
        addEvent: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => ApplyEvents(eventRepository: sl()));
  sl.registerLazySingleton(() => SyncEvents(eventRepository: sl()));
  sl.registerLazySingleton(() => AddEvent(eventRepository: sl()));

  // Repositories
  sl.registerLazySingleton<EventRepository>(() => EventRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        configLocalDataSource: sl(),
        idGenerator: sl(),
        timeInfo: sl(),
      ));

  // Data sources
  final configCache = MemoryCacheImpl<String, ConfigModel>();
  sl.registerLazySingleton<ConfigLocalDataSource>(
    () => ConfigLocalDataSourceImpl(
      cache: configCache,
    ),
  );
  final eventCache = MemoryCacheImpl<String, EventModel>();
  sl.registerLazySingleton<EventLocalDataSource>(
    () => EventLocalDataSourceImpl(
      cache: eventCache,
    ),
  );
  sl.registerLazySingleton<EventRemoteDataSource>(
    () => EventRemoteDataSourceImpl(
      network: sl(),
    ),
  );

  // Core
  sl.registerLazySingleton<TimeInfo>(() => TimeInfoImpl(sl()));
  sl.registerLazySingleton<IdGenerator>(() => IdGeneratorImpl(sl()));
  sl.registerLazySingleton<Network>(() => NetworkImpl(sl()));

  // External
  sl.registerLazySingleton(() => const Uuid());
  sl.registerLazySingleton(() => const Clock());
  sl.registerLazySingleton(() => http.Client());
}
