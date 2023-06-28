import 'package:clean_cache/cache/memory_cache.dart';
import 'package:clock/clock.dart';

import 'package:event_sink/src/core/data/id_generator.dart';
import 'package:event_sink/src/core/network/network.dart';
import 'package:event_sink/src/core/time/time_info.dart';
import 'package:event_sink/src/feature/data/local/data_sources/config_local_data_source.dart';
import 'package:event_sink/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sink/src/feature/data/local/models/config_model.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/data/remote/data_sources/event_remote_data_source.dart';
import 'package:event_sink/src/feature/data/repositories/config_repository_impl.dart';
import 'package:event_sink/src/feature/data/repositories/event_repository_impl.dart';
import 'package:event_sink/src/feature/domain/repositories/config_repository.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sink/src/feature/domain/use_cases/add_event.dart';
import 'package:event_sink/src/feature/domain/use_cases/apply_events.dart';
import 'package:event_sink/src/feature/domain/use_cases/clear_cache.dart';
import 'package:event_sink/src/feature/domain/use_cases/set_string_config.dart';
import 'package:event_sink/src/feature/domain/use_cases/sync_events.dart';
import 'package:event_sink/src/event_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

/// Service Locator (sl)

// TRICKY: register a new instance so that it does not conflict with the global
// instance of any calling code that also uses GetIt.
final sl = GetIt.asNewInstance();

void init() {
  // Controllers
  sl.registerFactory(() => EventController(
        syncEvents: sl(),
        applyEvents: sl(),
        addEvent: sl(),
        setConfig: sl(),
        clearCache: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => ClearCache(eventRepository: sl()));
  sl.registerLazySingleton(() => ApplyEvents(eventRepository: sl()));
  sl.registerLazySingleton(() => SyncEvents(
        eventRepository: sl(),
      ));
  sl.registerLazySingleton(() => AddEvent(eventRepository: sl()));
  sl.registerLazySingleton(() => SetStringConfig(configRepository: sl()));

  // Repositories
  sl.registerLazySingleton<EventRepository>(() => EventRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        idGenerator: sl(),
        timeInfo: sl(),
      ));
  sl.registerLazySingleton<ConfigRepository>(() => ConfigRepositoryImpl(
        localDataSource: sl(),
      ));

  // Data sources
  final configCache = MemoryCache<String, ConfigModel>();
  sl.registerLazySingleton<ConfigLocalDataSource>(
    () => ConfigLocalDataSourceImpl(
      cache: configCache,
    ),
  );
  final eventCache = MemoryCache<String, EventModel>();
  final poolCache = MemoryCache<int, List<String>>();
  sl.registerLazySingleton<EventLocalDataSource>(
    () => EventLocalDataSourceImpl(
      eventCache: eventCache,
      poolCache: poolCache,
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
