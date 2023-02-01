import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sync/src/core/domain/config_options.dart';
import 'package:event_sync/src/core/domain/usecase.dart';
import 'package:event_sync/src/core/error/failure.dart';
import 'package:event_sync/src/feature/domain/repositories/config_repository.dart';

class SetConfig extends UseCase<void, SetConfigParams> {
  ConfigRepository configRepository;

  SetConfig({
    required this.configRepository,
  });

  @override
  Future<Either<Failure, void>> call(SetConfigParams params) {
    return configRepository.write(params.option, params.value);
  }
}

class SetConfigParams<T> extends Equatable {
  final ConfigOption option;
  final T value;

  const SetConfigParams({required this.option, required this.value});

  @override
  List<Object?> get props => [option, value];
}
