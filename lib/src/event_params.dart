abstract class EventParams {
  /// Generates a class from a JSON object.
  factory EventParams.fromJson(Map<String, dynamic> json) =>
      throw Exception('You must override this method.');

  /// Converts the params to a JSON object.
  Map<String, dynamic> toJson();
}
