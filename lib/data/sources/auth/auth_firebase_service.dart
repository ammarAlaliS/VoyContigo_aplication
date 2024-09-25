import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickcar_aplication/data/models/auth/create_user_request.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserRequest createUserRequest);
  Future<void> singin();
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
        message = 'The password provided is to weak';
      }else if (e.code == 'email-already-in-use'){
        message = 'An account already exists with that email';
      }

      return Left(message);

    } 
  }

  @override
  Future<void> singin() {
    throw UnimplementedError();
  }

}
