import 'package:event_sink/event_sink.dart';

/// This defines an implementation of [EventRemoteDataSource].
/// This is used when registering data sources in
/// the [EventSinkConfig] annotation.
class DataSource<T extends EventRemoteDataSource> {
  /// The unique name of the data source.
  final String name;

  const DataSource({required this.name});
}
