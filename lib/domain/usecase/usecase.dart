import 'package:dartz/dartz.dart';
import 'package:flutter_countries_states/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
