import 'package:dartz/dartz.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/event_data.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/data/local/models/stream_hash.dart';
import 'package:event_sink/src/feature/domain/entities/event_info.dart';
import 'package:event_sink/src/feature/domain/entities/event_stub.dart';

/// This is the contract for reading and writing [Event]s to the repository.
/// Events are units of change that are synchronized to and from the server.
/// This forms the heart of the dataflow within the system.
///
/// Events are reduced to form a cached version of the graph state.
///
/// The normal logical flow of the repository is:
///
/// 1. fetch events from the server
/// 2. rebase un-synced events onto new ones from the server
/// 3. push all un-synced events to the server.
abstract class EventRepository {
  /// Downloads events from a remote adapter and stores it in the device
  /// event cache.
  Future<Either<Failure, void>> fetch({
    required String remoteAdapterName,
    required String pool,
  });

  /// Uploads events to the server that have been generated on this device.
  Future<Either<Failure, void>> push({
    required String remoteAdapterName,
    required String pool,
  });

  /// Re-applies any un-synced events on top of the event from the server.
  /// This is akin to a git rebase.
  Future<Either<Failure, void>> rebase(String pool);

  /// Adds an event to the cache, which can then later be applied to the graph
  /// or synced to the server.
  Future<Either<Failure, void>> add(EventInfo<EventData> event, String pool);

  /// Returns a sorted list of events (stub)
  Future<Either<Failure, List<EventStub>>> list(String pool);

  /// Returns locally cached list of events
  Future<Either<Failure, List<EventModel>>> listEvents(String pool);

  /// Returns an event by its ID.
  Future<Either<Failure, EventModel>> get(String eventId);

  /// Marks an event as having been reduced into the graph.
  Future<Either<Failure, void>> markApplied(EventStub event);

  /// Mark events as having been reduced into the graph.
  Future<Either<Failure, void>> markAppliedList(List<EventStub> events);

  /// Clear the local cache for all pools.
  Future<Either<Failure, void>> clearCache();

  /// Clear the local cache of the pool.
  Future<Either<Failure, void>> clearPoolCache(String pool);

  /// Returns the hash of all events in a stream.
  Future<Either<Failure, String>> getStreamRootHash(
    String pool,
    String streamId,
  );

  /// Returns list of event's ID and hash within a stream.
  Future<Either<Failure, List<StreamHash>>> listStreamHashes(
    String pool,
    String streamId,
  );
}
