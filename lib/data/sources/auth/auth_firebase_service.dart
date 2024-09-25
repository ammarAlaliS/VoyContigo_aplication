import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickcar_aplication/data/models/auth/create_user_request.dart';
import 'package:quickcar_aplication/data/models/auth/sign_in_user_request.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserRequest createUserRequest);
  Future<Either> singin(CreateSignInUserRequest createSignInUserRequest);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  
  @override
  Future<Either> signup(CreateUserRequest createUserRequest) async {
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserRequest.email, 
        password: createUserRequest.password);
        return const Right( "El registro fue exitoso");
    } on FirebaseAuthException catch(e){
      String message = '';
      if(e.code == 'weak-password'){
        message = 'La contraseña es muy debil ';
      }else if (e.code == 'email-already-in-use'){
        message = 'El correo electronico ya esta en uso';
      }
      return Left(message);
    } 
  }

  @override
  Future<Either> singin(CreateSignInUserRequest createSignInUserRequest) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: createSignInUserRequest.email, 
        password: createSignInUserRequest.password);
        return const Right("Inicio de sesion exitoso");
    }  on FirebaseAuthException catch (e) {
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
        default:
          message = 'Ha ocurrido un error inesperado. Intenta de nuevo más tarde.';
      }
      return Left(message);
    } catch (e) {
      return const Left('Error de conexión. Intenta de nuevo más tarde.');
    }
  }
}
