
import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/data/sources/userData/auth_get_user_data_firebase_services.dart';
import 'package:quickcar_aplication/domain/repository/getData/get_user_informacion.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';
import 'package:quickcar_aplication/service_locator.dart';

class GetUserInformacionRepositoryImpl extends GetUserInformacionRepository {
  final AuthGetUserDataFirebaseServices authGetUserDataFirebaseServices;

  // Constructor inicializando el servicio
  GetUserInformacionRepositoryImpl(this.authGetUserDataFirebaseServices);
  
  @override
  Future<Either<Exception, UserState>> getUserInformation(String userId) async {
     if (userId.isEmpty) {
      return Left(Exception("El ID de usuario no puede ser nulo o vacío."));
    }

    try {
      // Llamada asíncrona al servicio de datos de usuario
      final result = await  sl<AuthGetUserDataFirebaseServices>().getUserState(userId);
      
      
      // Uso del fold para manejar el resultado
      return result.fold(
        (exception) => Left(Exception(exception)),
        (userInfo) => Right(userInfo),
      );
    } catch (e) {
      // Captura de excepciones y retorno en caso de error
      return Left(Exception("Error al obtener los datos del usuario: ${e.toString()}"));
    }
  }

}

