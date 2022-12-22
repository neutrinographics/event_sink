import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

abstract class IdGenerator {
  String generateId();
}

class IdGeneratorImpl implements IdGenerator {
  final Uuid _uuid;

  IdGeneratorImpl(this._uuid);

  @override
  String generateId() {
    return _uuid.v4(options: {'rng': UuidUtil.cryptoRNG});
  }
}
