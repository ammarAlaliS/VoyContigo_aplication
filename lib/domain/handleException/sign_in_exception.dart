class SignInException implements Exception {
  final String message;
  SignInException(this.message);
  @override
  String toString() => message;
}
