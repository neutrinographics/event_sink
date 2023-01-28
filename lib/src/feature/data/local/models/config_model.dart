import 'package:event_sync/src/core/domain/config_options.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_model.freezed.dart';

part 'config_model.g.dart';

/// Represents a one-off setting.
/// This is useful for storing generic app settings.
@freezed
class ConfigModel with _$ConfigModel {
  const factory ConfigModel.bool({
    required ConfigOption key,
    required bool value,
  }) = _ConfigBoolModel;

  const factory ConfigModel.string({
    required ConfigOption key,
    required String value,
  }) = _ConfigStringModel;

  const factory ConfigModel.int({
    required ConfigOption key,
    required int value,
  }) = _ConfigIntModel;

  const factory ConfigModel.double({
    required ConfigOption key,
    required double value,
  }) = _ConfigDoubleModel;

  const factory ConfigModel.date({
    required ConfigOption key,
    required DateTime value,
  }) = _ConfigDateModel;

  factory ConfigModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigModelFromJson(json);
}
