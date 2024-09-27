import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/core/usecase/usecase.dart';
import 'package:quickcar_aplication/domain/repository/auth/auth.dart';
import 'package:quickcar_aplication/service_locator.dart';

class SignoutUseCase implements Usecase<Either<Exception, void>, void> {
  @override
  Future<Either<Exception, void>> call({void params}) async {
    return await sl<AuthRepository>().signout();
  }
}
