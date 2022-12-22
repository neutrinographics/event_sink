import 'package:dartz/dartz.dart';
import 'package:event_sync/event_sync.dart';
import 'package:event_sync/src/core/error/failure.dart';
import 'package:event_sync/src/feature/domain/entities/event_stub.dart';

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
  /// Downloads events from the server and stores it in the device
  /// event cache.
  Future<Either<Failure, void>> fetch();

  /// Uploads events to the server that have been generated on this device.
  Future<Either<Failure, void>> push();

  /// Re-applies any un-synced events on top of the event from the server.
  /// This is akin to a git rebase.
  Future<Either<Failure, void>> rebase();

  /// Adds an event to the cache, which can then later be applied to the graph
  /// or synced to the server.
  Future<Either<Failure, void>> add(EventInfo event);

  /// Returns a sorted list of events in the active graph
  Future<Either<Failure, List<EventInfo>>> list();

  /// Marks an event as having been reduced into the graph.
  Future<Either<Failure, void>> markReduced(EventInfo event);

  /// Clear the local cache of [Event].
  Future<Either<Failure, void>> clearCache();
}
