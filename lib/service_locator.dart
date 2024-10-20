import 'package:get_it/get_it.dart';
import 'package:quickcar_aplication/data/repository/auth/auth_repository_impl.dart';
import 'package:quickcar_aplication/data/repository/userData/user_data_reposository_impl.dart';
import 'package:quickcar_aplication/data/sources/auth/auth_firebase_service.dart';
import 'package:quickcar_aplication/data/sources/userData/auth_get_user_data_firebase_services.dart';
import 'package:quickcar_aplication/domain/repository/auth/auth.dart';
import 'package:quickcar_aplication/domain/repository/getData/get_user_informacion.dart';
import 'package:quickcar_aplication/domain/usecases/auth/Signup.dart';
import 'package:quickcar_aplication/domain/usecases/auth/Singin.dart';
import 'package:quickcar_aplication/domain/usecases/auth/Singout.dart';
import 'package:quickcar_aplication/domain/usecases/auth/upload_image.dart';
import 'package:quickcar_aplication/domain/usecases/auth/verify_email.dart';
import 'package:quickcar_aplication/domain/usecases/getData/get_user_infomation_use_case.dart';

// Instancia de GetIt para gestionar las dependencias
final sl = GetIt.instance;

// Función para inicializar las dependencias
Future<void> initializeDependencies() async {
  // Registrar el servicio de autenticación de Firebase
  // Esto permite utilizar el servicio de autenticación en otras partes de la aplicación
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  // Registrar el servicio de obtención de datos del usuario
  // Esto es necesario para que el repositorio de usuario pueda acceder a los datos de autenticación
  sl.registerSingleton<AuthGetUserDataFirebaseServices>(AuthGetUserDataFirebaseServicesImpl());

  // Registrar el repositorio de autenticación con la dependencia del servicio de autenticación
  // Esto conecta el repositorio con el servicio de autenticación registrado anteriormente
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl<AuthFirebaseService>()));

  // Registrar el repositorio para obtener información del usuario,
  // asegurándose de que se utilice el servicio de obtención de datos de usuario
  sl.registerSingleton<GetUserInformacionRepository>(GetUserInformacionRepositoryImpl(sl<AuthGetUserDataFirebaseServices>()));

  // Registrar casos de uso de usuario con la dependencia del repositorio
  // Estos casos de uso encapsulan la lógica de negocio relacionada con la autenticación
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase(sl<AuthRepository>()));
  sl.registerSingleton<SignInUseCase>(SignInUseCase(sl<AuthRepository>()));
  sl.registerSingleton<SignoutUseCase>(SignoutUseCase(sl<AuthRepository>()));

  // Registrar caso de uso para subir imágenes
  // Permite a los usuarios subir imágenes a través de la funcionalidad de autenticación
  sl.registerSingleton<UploadImageUseCase>(UploadImageUseCase(sl<AuthRepository>()));

  // Registrar caso de uso para verificar el correo electrónico
  sl.registerSingleton<VerifyEmailUseCase>(VerifyEmailUseCase(sl<AuthRepository>()));

  // Registrar el caso de uso para obtener la información del usuario
  // Esto se conecta al repositorio que se registró anteriormente
  sl.registerSingleton<GetUserInformationUseCase>(GetUserInformationUseCase(sl<GetUserInformacionRepository>()));
}
