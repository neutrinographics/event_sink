import 'package:freezed_annotation/freezed_annotation.dart';

part 'stream_hash.freezed.dart';

@freezed
class StreamHash with _$StreamHash {
  const factory StreamHash({
    required String eventId,
    required String hash,
  }) = _StreamHash;
}
