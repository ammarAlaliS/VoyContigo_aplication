import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/core/usecase/usecase.dart';
import 'package:quickcar_aplication/data/models/auth/sign_in_user_request.dart';
import 'package:quickcar_aplication/domain/repository/auth/auth.dart';
import 'package:quickcar_aplication/service_locator.dart';

class SingInUseCase implements Usecase<Either,CreateSignInUserRequest>{
  @override
  Future<Either> call({CreateSignInUserRequest ?  params}) async{
     return await sl<AuhtRepository>().singin(params!);
  }
  
}