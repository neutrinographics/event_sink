import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'package:uuid/uuid.dart';

abstract class IdGenerator {
  String generateId();
}

class IdGeneratorImpl implements IdGenerator {
  final Uuid _uuid;

  IdGeneratorImpl(this._uuid);

  @override
  String generateId() {
    final options = V4Options(null, CryptoRNG());
    return _uuid.v4(config: options);
  }
}
