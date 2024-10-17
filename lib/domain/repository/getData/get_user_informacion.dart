import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/domain/usecases/getData/get_user_infomation_use_case.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';

abstract class GetUserInformacionRepository {
  Future<Either<Failure, UserState>> getUserInformation(String userId);
}
