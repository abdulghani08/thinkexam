import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/auth_user.dart';
import '../../repositories/auth_repository.dart';
import '../base_usecase.dart';

/// Get current authenticated user use case
class GetCurrentUserUseCase extends BaseUseCase<AuthUser, NoParams> {
  final AuthRepository repository;

  const GetCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, AuthUser>> call(NoParams params) {
    return repository.getCurrentUser();
  }
}
