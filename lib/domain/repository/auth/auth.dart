import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/data/models/auth/create_user_request.dart';
import 'package:quickcar_aplication/data/models/auth/sign_in_user_request.dart';

abstract class AuthRepository {

  Future<Either<Exception, String>> signup(CreateUserRequest createUserRequest);
  Future<Either<Exception, String>> signin(CreateSignInUserRequest createSignInUserRequest);
  Future<Either<Exception, void>> signout();

}
