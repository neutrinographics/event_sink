import 'package:clock/clock.dart';

abstract class TimeInfo {
  DateTime now();
}

class TimeInfoImpl implements TimeInfo {
  final Clock clock;

  TimeInfoImpl(this.clock);

  @override
  DateTime now() => clock.now();
}
