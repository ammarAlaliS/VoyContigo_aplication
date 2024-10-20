import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/core/usecase/usecase.dart';
import 'package:quickcar_aplication/data/models/auth/create_user_request.dart';
import 'package:quickcar_aplication/domain/repository/auth/auth.dart';
import 'package:quickcar_aplication/service_locator.dart';

class VerifyEmailUseCase implements Usecase<Either,CreateUserRequest> {
  VerifyEmailUseCase(AuthRepository authRepository);

  @override
  Future<Either> call({CreateUserRequest ? params}) async{
    return sl<AuthRepository>().verifyEmailAndCreateUserTable(params!);
  }

}