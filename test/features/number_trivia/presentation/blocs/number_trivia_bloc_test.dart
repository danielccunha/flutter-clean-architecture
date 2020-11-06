import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/utils/input_converter.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_clean_architecture/features/number_trivia/presentation/blocs/number_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('initialState should be empty', () {
    // assert
    expect(bloc.state, Empty());
  });

  group('GetTriviaConcreteNumberTrivia', () {
    const tNumberString = '1';
    const tNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(text: 'Test', number: 1);

    test(
        'should call the InputConverter to validate and convert the string to an unsigned integer',
        () async {
      // arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(const Right(tNumberParsed));

      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

      // assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [Error] when the input is invalid', () {
      // arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(const Left(InvalidInputFailure()));

      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));

      // assert
      expectLater(
        bloc.asBroadcastStream(),
        emitsInOrder([const Error(message: INVALID_INPUT_FAILURE_MESSAGE)]),
      );
    });
  });
}
