import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/data/models/auth/create_user_request.dart';
import 'package:quickcar_aplication/data/sources/auth/auth_firebase_service.dart';
import 'package:quickcar_aplication/domain/repository/auth/auth.dart';
import 'package:quickcar_aplication/service_locator.dart';

class AuthRepositoryImpl extends AuhtRepository {
  @override
  Future<Either> signup(CreateUserRequest createUserRequest) async {
    return await sl<AuthFirebaseService>().signup(createUserRequest);
  }

  @override
  Future<void> singin() {
    throw UnimplementedError();
  }

}