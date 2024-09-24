import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickcar_aplication/data/models/auth/create_user_request.dart';

abstract class AuthFirebaseService {
  Future<void> signup(CreateUserRequest createUserRequest);
  Future<void> singin();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<void> signup(CreateUserRequest createUserRequest) async {
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserRequest.email, 
        password: createUserRequest.password);
    } on FirebaseAuthException catch(e){

    }
  }

  @override
  Future<void> singin() {
    throw UnimplementedError();
  }

}
