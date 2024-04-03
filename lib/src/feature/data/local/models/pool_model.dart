import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'pool_model.freezed.dart';

part 'pool_model.g.dart';

@freezed
class PoolModel extends HiveObject with _$PoolModel {
  PoolModel._();

  @HiveType(typeId: 2)
  factory PoolModel({
    @HiveField(0) required int id,
    @HiveField(1) required List<String> eventIds,
  }) = _PoolModel;
}
