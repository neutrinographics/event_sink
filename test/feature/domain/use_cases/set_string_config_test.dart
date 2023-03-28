import 'package:dartz/dartz.dart';
import 'package:event_sync/src/core/domain/config_options.dart';
import 'package:event_sync/src/feature/domain/repositories/config_repository.dart';
import 'package:event_sync/src/feature/domain/use_cases/set_string_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'set_string_config_test.mocks.dart';

@GenerateMocks([ConfigRepository])
void main() {
  late MockConfigRepository mockConfigRepository;
  late SetStringConfig useCase;

  setUp(() {
    mockConfigRepository = MockConfigRepository();

    useCase = SetStringConfig(configRepository: mockConfigRepository);
  });

  const tHost = 'host';
  const tOption = ConfigOption.serverHost;

  test(
    'should store a config',
    () async {
      // arrange
      when(mockConfigRepository.write(any, any))
          .thenAnswer((_) async => const Right(null));
      // act
      final result = await useCase(
          const SetStringConfigParams(option: tOption, value: tHost));
      // assert
      expect(result, const Right(null));
      verify(mockConfigRepository.write(tOption, tHost));
    },
  );
}
