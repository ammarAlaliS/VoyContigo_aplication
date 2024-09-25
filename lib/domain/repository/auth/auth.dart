// aqui agreamos los metodos que vamos a utlizar 

import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/data/models/auth/create_user_request.dart';

abstract class AuhtRepository{
  Future<Either> signup(CreateUserRequest createUserRequest);
  Future<void> singin();
}