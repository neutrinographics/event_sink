import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sync/src/core/domain/config_options.dart';
import 'package:event_sync/src/core/domain/usecase.dart';
import 'package:event_sync/src/core/error/failure.dart';
import 'package:event_sync/src/feature/domain/repositories/config_repository.dart';

class SetStringConfig extends UseCase<void, SetStringConfigParams> {
  ConfigRepository configRepository;

  SetStringConfig({
    required this.configRepository,
  });

  @override
  Future<Either<Failure, void>> call(SetStringConfigParams params) {
    return configRepository.write<String>(params.option, params.value);
  }
}

class SetStringConfigParams extends Equatable {
  final ConfigOption option;
  final String value;

  const SetStringConfigParams({required this.option, required this.value});

  @override
  List<Object?> get props => [option, value];
}
