/// Represents data that will be stored in the event.
abstract class EventData {
  /// Generates a class from a JSON object.
  factory EventData.fromJson(Map<String, dynamic> json) =>
      throw Exception('You must override this method.');

  /// Converts the params to a JSON object.
  Map<String, dynamic> toJson();
}
