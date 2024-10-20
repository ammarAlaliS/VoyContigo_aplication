import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';

abstract class GetUserInformacionRepository {
  Future<Either<Exception, UserState>> getUserInformation(String userId);
}
