enum PullStrategy { rebase, append }

/// This defines a remote adapter, used to sync data with a remote.
/// This is used when registering remotes in the [RemoteSinkConfig] annotation.
class RemoteAdapter {
  const RemoteAdapter({
    required this.name,
    required this.priority,
    required this.pullStrategy,
  });

  /// The remote adapter name.
  final String name;

  /// The priority of the remote adapter.
  /// Lower values are prioritized.
  final int priority;

  /// Pull strategy to use when syncing with the remote.
  final PullStrategy pullStrategy;
}
