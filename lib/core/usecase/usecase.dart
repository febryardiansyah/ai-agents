abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

abstract class Params {}

class NoParams extends Params {}