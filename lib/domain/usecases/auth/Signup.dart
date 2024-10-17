import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/core/usecase/usecase.dart';
import 'package:quickcar_aplication/data/models/auth/create_user_request.dart';
import 'package:quickcar_aplication/domain/repository/auth/auth.dart';

class SignUpUseCase implements Usecase<Either<Exception, String>, CreateUserRequest> {
  final AuthRepository authRepository;

  // Constructor que recibe el AuthRepository
  SignUpUseCase(this.authRepository);

  @override
  Future<Either<Exception, String>> call({CreateUserRequest? params}) async {
    if (params != null) {
      // Usa el repositorio inyectado para llamar al método signup
      return authRepository.signup(params);
    } else {
      return Left(Exception("CreateUserRequest no proporcionado"));
    }
  }
}

