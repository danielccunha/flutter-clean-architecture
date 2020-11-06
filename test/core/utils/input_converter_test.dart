import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/utils/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  test(
      'should return an integer when the string represents an unsigned integer',
      () {
    // arrange
    const str = '123';

    // act
    final result = inputConverter.stringToUnsignedInteger(str);

    // assert
    expect(result, const Right(123));
  });

  test('should return a Failure when the string is not an integer', () {
    // arrange
    const str = '1.0';

    // act
    final result = inputConverter.stringToUnsignedInteger(str);

    // assert
    expect(result, const Left(InvalidInputFailure()));
  });

  test('should return a Failure when the string is not a negative integer', () {
    // arrange
    const str = '-1';

    // act
    final result = inputConverter.stringToUnsignedInteger(str);

    // assert
    expect(result, const Left(InvalidInputFailure()));
  });
}
