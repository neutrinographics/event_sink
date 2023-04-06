import 'dart:convert';

import 'package:event_sink/src/core/network/response.dart';

/// Utility to read the response message.
/// This will parse the response and piece together as much information as possible.
String responseMessage(Response response) {
  List<String> message = [];

  final phrase = response.reasonPhrase;
  if (phrase != null) {
    message.add(phrase);
  }

  try {
    final data = json.decode(
      response.body.isEmpty ? '{}' : response.body,
    );
    if (data.containsKey('response') && data['response'] != null) {
      message.add(data['response'].toString());
    }
  } catch (_) {
    message.add('Unable to read response.');
  }
  if (response.url != null) {
    message.add("While requesting ${response.url}");
  }
  return message.join('. ');
}
