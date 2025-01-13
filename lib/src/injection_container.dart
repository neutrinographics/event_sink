import 'package:clean_cache/cache/memory_cache.dart';
import 'package:clock/clock.dart';
import 'package:event_sink/src/core/data/event_resolver.dart';
import 'package:event_sink/src/core/data/event_sorter.dart';
import 'package:event_sink/src/core/data/event_stream_rebaser.dart';
import 'package:event_sink/src/core/data/id_generator.dart';
import 'package:event_sink/src/core/hash_generator.dart';
import 'package:event_sink/src/core/network/network.dart';
import 'package:event_sink/src/core/time/time_info.dart';
import 'package:event_sink/src/event_controller.dart';
import 'package:event_sink/src/event_remote_adapter.dart';
import 'package:event_sink/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/data/remote/data_sources/event_remote_data_source.dart';
import 'package:event_sink/src/feature/data/repositories/event_repository_impl.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sink/src/feature/domain/use_cases/add_event.dart';
import 'package:event_sink/src/feature/domain/use_cases/apply_events.dart';
import 'package:event_sink/src/feature/domain/use_cases/clear_cache.dart';
import 'package:event_sink/src/feature/domain/use_cases/list_events.dart';
import 'package:event_sink/src/feature/domain/use_cases/sync_events.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'core/data/cache.dart';

/// Service Locator (sl)

// TRICKY: register a new instance so that it does not conflict with the global
// instance of any calling code that also uses GetIt.
final sl = GetIt.asNewInstance();

Future<void> init({
  required Map<String, EventRemoteAdapter> remoteAdapters,
}) async {
  // Controllers
  sl.registerFactory(() => EventController(
        syncEvents: sl(),
        applyEvents: sl(),
        addEvent: sl(),
        clearCache: sl(),
        listEvents: sl(),
      ));

  // Remote adapters
  sl.registerLazySingleton<Map<String, EventRemoteAdapter>>(
      () => remoteAdapters);

  // Use cases
  sl.registerLazySingleton(() => ClearCache(eventRepository: sl()));
  sl.registerLazySingleton(() => ApplyEvents(eventRepository: sl()));
  sl.registerLazySingleton(() => SyncEvents(
        eventRepository: sl(),
      ));
  sl.registerLazySingleton(() => AddEvent(eventRepository: sl()));
  sl.registerLazySingleton(() => ListEvents(eventRepository: sl()));

  // Repositories
  sl.registerLazySingleton<EventRepository>(() => EventRepositoryImpl(
        localDataSource: sl(),
        remoteAdapters: sl(),
        idGenerator: sl(),
        hashGenerator: sl(),
        timeInfo: sl(),
        eventResolver: sl(),
      ));

  // Data sources
  final eventCache =
      await buildHybridHiveCache<String, EventModel>('event_sink-events');
  sl.registerLazySingleton<EventLocalDataSource>(
    () => EventLocalDataSourceImpl(
      eventCache: eventCache,
      poolCache: MemoryCache(),
      remoteAdapters: sl(),
      eventSorter: sl(),
      hashGenerator: sl(),
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
  sl.registerLazySingleton<EventSorter>(() => EventSorterImpl());
  sl.registerLazySingleton<EventResolver>(() => EventResolverImpl());
  sl.registerLazySingleton<EventStreamRebaser>(
      () => EventStreamRebaserImpl(sl()));

  // External
  sl.registerLazySingleton<HashGenerator>(() => const HashGeneratorImpl());
  sl.registerLazySingleton(() => const Uuid());
  sl.registerLazySingleton(() => const Clock());
  sl.registerLazySingleton(() => http.Client());
}
