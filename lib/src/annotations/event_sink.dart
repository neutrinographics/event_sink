import 'package:event_sink/src/annotations/params/data_source.dart';
import 'package:event_sink/src/annotations/params/event.dart';

/// Defines a new event sink controller.
class EventSinkConfig {
  final List<DataSource> dataSources;
  final List<Event> events;

  const EventSinkConfig({
    required this.dataSources,
    required this.events,
  });
}
