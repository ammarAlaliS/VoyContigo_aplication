import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/core/usecase/usecase.dart';
import 'package:quickcar_aplication/domain/repository/getData/get_user_informacion.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';
import 'package:quickcar_aplication/service_locator.dart';

class Failure {
  final String message;

  Failure(this.message);
}

class GetUserInformationUseCase implements Usecase<Either<Failure, UserState>, String> {
  @override
  Future<Either<Failure, UserState>> call({String? params}) async {
    // Verifica si el parámetro es nulo
    if (params == null) {
      return Left(Failure("El parámetro ID de usuario no puede ser nulo"));
    }
    
    // Intenta obtener la información del usuario del repositorio
    try {
      return await sl<GetUserInformacionRepository>().getUserInformation(params);
    } catch (e) {
      // Manejo de excepciones en caso de que el repositorio falle
      return Left(Failure("Error al obtener la información del usuario: ${e.toString()}"));
    }
  }
}
