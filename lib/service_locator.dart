import 'package:get_it/get_it.dart';
import 'package:quickcar_aplication/data/repository/auth/auth_repository_impl.dart';
import 'package:quickcar_aplication/data/sources/auth/auth_firebase_service.dart';
import 'package:quickcar_aplication/domain/repository/auth/auth.dart';
import 'package:quickcar_aplication/domain/usecases/auth/Signup.dart';
import 'package:quickcar_aplication/domain/usecases/auth/Singin.dart';
import 'package:quickcar_aplication/domain/usecases/auth/Singout.dart';
import 'package:quickcar_aplication/domain/usecases/auth/upload_image.dart';
import 'package:quickcar_aplication/domain/usecases/getData/get_user_infomation_use_case.dart';


final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Registrar el servicio de autenticación de Firebase
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  // Registrar el repositorio de autenticación
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // Registrar casos de uso de usuario
   sl.registerSingleton<SignUpUseCase>(SignUpUseCase(sl<AuthRepository>()));
  // registrar subida de fotos 
  sl.registerSingleton<UploadImageUseCase>(UploadImageUseCase());


  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SignoutUseCase>(SignoutUseCase());

  // Registrar el caso de uso para obtener la información del usuario
  sl.registerSingleton<GetUserInformationUseCase>(GetUserInformationUseCase());
}
