abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

abstract class Params {}

final class NoParams extends Params {}