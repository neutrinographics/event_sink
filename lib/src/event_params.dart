abstract class EventParams {
  /// Generates a class from a JSON object.
  EventParams fromJson(Map<String, dynamic> json);

  /// Converts the params to a JSON object.
  Map<String, dynamic> toJson();
}
