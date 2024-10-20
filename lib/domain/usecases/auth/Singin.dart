import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/core/usecase/usecase.dart';
import 'package:quickcar_aplication/data/models/auth/sign_in_user_request.dart';
import 'package:quickcar_aplication/domain/handleException/sign_in_exception.dart';
import 'package:quickcar_aplication/domain/repository/auth/auth.dart';
import 'package:quickcar_aplication/service_locator.dart';

class SignInUseCase implements Usecase<Either<SignInException, String>, CreateSignInUserRequest> {
  SignInUseCase(AuthRepository authRepository);

  @override
  Future<Either<SignInException, String>> call({CreateSignInUserRequest? params}) async {
    return await sl<AuthRepository>().signin(params!);
  }
}
