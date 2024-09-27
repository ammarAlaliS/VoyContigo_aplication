import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickcar_aplication/data/models/auth/create_user_request.dart';
import 'package:quickcar_aplication/data/models/auth/sign_in_user_request.dart';

abstract class AuthFirebaseService {
  Future<Either<Exception, String>> signup(CreateUserRequest createUserRequest);
  Future<Either<Exception, String>> signin(
      CreateSignInUserRequest createSignInUserRequest);
  Future<Either<Exception, void>> signout(); // Añadir también signout
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  // Implementación del método signup
  @override
  Future<Either<Exception, String>> signup(
      CreateUserRequest createUserRequest) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserRequest.email, 
          password: createUserRequest.password);
      return const Right("El registro fue exitoso");
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'La contraseña es muy débil.';
      } else if (e.code == 'email-already-in-use') {
        message = 'El correo electrónico ya está en uso.';
      }
      return Left(Exception(message)); 
    }
  }

  // Implementación del método signin
  @override
  Future<Either<Exception, String>> signin(
      CreateSignInUserRequest createSignInUserRequest) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: createSignInUserRequest.email,
          password: createSignInUserRequest.password);
      return const Right("Inicio de sesión exitoso");
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case 'user-not-found':
          message = 'No existe un usuario con este correo electrónico.';
          break;
        case 'wrong-password':
          message = 'La contraseña es incorrecta.';
          break;
        case 'invalid-email':
          message = 'El correo electrónico no es válido.';
          break;
        case 'too-many-requests':
          message = 'Demasiados intentos fallidos. Intenta de nuevo más tarde.';
          break;
        case 'user-disabled':
          message = 'El usuario ha sido deshabilitado.';
          break;
        default:
          message =
              'Ha ocurrido un error inesperado. Intenta de nuevo más tarde.';
      }
      return Left(Exception(message)); 
    }
  }

  // Implementación del método signout
  @override
  Future<Either<Exception, void>> signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(null);
    } catch (e) {
      return Left(Exception("Error al cerrar sesión"));
    }
  }
}
