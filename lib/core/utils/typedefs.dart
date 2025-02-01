import 'package:dartz/dartz.dart';
import 'package:taski_to_do/core/failures/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
