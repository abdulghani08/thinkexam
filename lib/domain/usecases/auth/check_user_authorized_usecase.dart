import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../repositories/auth_repository.dart';
import '../base_usecase.dart';

/// Check if user is authorized use case
class CheckUserAuthorizedUseCase extends BaseUseCase<bool, String> {
  final AuthRepository repository;

  const CheckUserAuthorizedUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String userId) {
    return repository.isUserAuthorized(userId);
  }
}
