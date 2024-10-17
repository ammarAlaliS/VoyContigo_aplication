import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/domain/repository/getData/get_user_informacion.dart';
import 'package:quickcar_aplication/domain/usecases/getData/get_user_infomation_use_case.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';
import 'package:quickcar_aplication/service_locator.dart';

class UserDataRepoImpl extends GetUserInformacionRepository {
  @override
  Future<Either<Failure, UserState>> getUserInformation(String userId) async {
    
    if (userId.isEmpty) {
      return Left(Failure("El ID de usuario no puede ser nulo o vacío."));
    }

    try {
      final result = await sl<GetUserInformationUseCase>().call(params: userId);
      return result.fold(
        (exception) => Left(Failure(exception.message)),
        (userInfo) => Right(userInfo),
      );
    } catch (e) {
      return Left(Failure("Error al obtener los datos del usuario: ${e.toString()}"));
    }
  }
}
