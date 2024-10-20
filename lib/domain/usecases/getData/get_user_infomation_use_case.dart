import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/core/usecase/usecase.dart';
import 'package:quickcar_aplication/domain/repository/getData/get_user_informacion.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';
import 'package:quickcar_aplication/service_locator.dart';



class GetUserInformationUseCase implements Usecase<Either<Exception, UserState>, String> {
  GetUserInformationUseCase(GetUserInformacionRepository getUserInformacionRepository);

  @override
  Future<Either<Exception, UserState>> call({String? params}) async {
    // Verifica si el parámetro es nulo
    if (params == null) {
      return Left(Exception("El parámetro ID de usuario no puede ser nulo"));
    }
    
    try {
      return await sl<GetUserInformacionRepository>().getUserInformation(params);
    } catch (e) {
      // Manejo de excepciones en caso de que el repositorio falle
      return Left(Exception("Error al obtener la información del usuario: ${e.toString()}"));
    }
  }
}
