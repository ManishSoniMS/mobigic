import 'package:dartz/dartz.dart';

import '../error/failure.dart';

/// A function that returns a [Either] of type [T]
typedef FailureOr<T> = Future<Either<Failure, T>>;
