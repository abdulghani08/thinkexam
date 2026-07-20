import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/user_role.dart';
import '../../repositories/auth_repository.dart';
import '../base_usecase.dart';

/// Get user role use case
class GetUserRoleUseCase extends BaseUseCase<UserRole, GetUserRoleParams> {
  final AuthRepository repository;

  const GetUserRoleUseCase(this.repository);

  @override
  Future<Either<Failure, UserRole>> call(GetUserRoleParams params) {
    return repository.getUserRole(params.userId, email: params.email);
  }
}

/// Parameters for getting user role
class GetUserRoleParams {
  final String userId;
  final String? email;

  const GetUserRoleParams({required this.userId, this.email});
}
