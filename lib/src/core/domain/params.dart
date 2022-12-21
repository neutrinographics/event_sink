import 'package:equatable/equatable.dart';

/// Used by code requiring typed parameters whenever the code doesn't accept any parameters.
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
