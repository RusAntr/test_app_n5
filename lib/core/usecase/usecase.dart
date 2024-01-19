/// Business logic interface
abstract interface class UseCase<Type, Params> {
  /// Calls business logic func
  Future<Type> call({Params params});
}
