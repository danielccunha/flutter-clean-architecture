import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/errors/failures.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    final value = int.tryParse(str);
    if (value != null && !value.isNegative) {
      return Right(value);
    }

    return const Left(InvalidInputFailure());
  }
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure();
}
