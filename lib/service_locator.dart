import 'package:get_it/get_it.dart';
import 'package:quickcar_aplication/data/repository/auth/auth_repository_impl.dart';
import 'package:quickcar_aplication/data/sources/auth/auth_firebase_service.dart';
import 'package:quickcar_aplication/domain/repository/auth/auth.dart';
import 'package:quickcar_aplication/domain/usecases/auth/Signup.dart';
import 'package:quickcar_aplication/domain/usecases/auth/Singin.dart';
import 'package:quickcar_aplication/domain/usecases/auth/Singout.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SignoutUseCase>(SignoutUseCase());
}
