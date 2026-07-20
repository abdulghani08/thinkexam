import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';

/// Base use case class
/// All use cases should extend this class
/// [Type] is the return type of the use case
/// [Params] is the parameter type (use NoParams if no parameters needed)
abstract class BaseUseCase<Type, Params> {
  const BaseUseCase();

  Future<Either<Failure, Type>> call(Params params);
}

/// Use this when a use case doesn't require any parameters
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
