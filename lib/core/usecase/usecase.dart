abstract class Usecase<Type,Params>{
  Future<void> call({Params params});
}