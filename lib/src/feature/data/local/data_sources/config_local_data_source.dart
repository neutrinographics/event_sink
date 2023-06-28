import 'package:clean_cache/clean_cache.dart';
import 'package:event_sink/src/core/domain/config_options.dart';
import 'package:event_sink/src/feature/data/local/models/config_model.dart';

abstract class ConfigLocalDataSource {
  Future<void> write(ConfigModel model);

  Future<ConfigModel> read(ConfigOption option);

  Future<void> delete(ConfigOption option);

  Future<void> clear();
}

class ConfigLocalDataSourceImpl implements ConfigLocalDataSource {
  final CleanCache<String, ConfigModel> cache;

  ConfigLocalDataSourceImpl({required this.cache});

  @override
  Future<void> write(ConfigModel model) => cache.write(model.option.key, model);

  @override
  Future<ConfigModel> read(ConfigOption option) => cache.read(option.key);

  @override
  Future<void> delete(ConfigOption option) => cache.delete(option.key);

  @override
  Future<void> clear() => cache.clear();
}
