import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/core/usecase/usecase.dart';
import 'package:quickcar_aplication/data/models/auth/create_upload_request.dart';
import 'package:quickcar_aplication/domain/repository/auth/auth.dart';
import 'package:quickcar_aplication/service_locator.dart';

class UploadImageUseCase implements Usecase<Either<Exception, String>, CreateUploadRequest> {
  UploadImageUseCase(AuthRepository authRepository);

  @override
  Future<Either<Exception, String>> call({CreateUploadRequest? params}) async {
    if (params == null) {
      return Left(Exception('Los parámetros de carga de imagen son nulos.'));
    }
    return await sl<AuthRepository>().uploadImages(params.folder, params.imageFile);
  }
}
