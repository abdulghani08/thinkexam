import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/auth_user.dart';
import '../../repositories/auth_repository.dart';
import '../base_usecase.dart';

/// Sign in with Google use case
class SignInWithGoogleUseCase extends BaseUseCase<AuthUser, NoParams> {
  final AuthRepository repository;

  const SignInWithGoogleUseCase(this.repository);

  @override
  Future<Either<Failure, AuthUser>> call(NoParams params) {
    return repository.signInWithGoogle();
  }
}
