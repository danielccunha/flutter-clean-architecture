part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class Empty extends NumberTriviaState {
  const Empty();
}

class Loading extends NumberTriviaState {
  const Loading();
}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  const Loaded({
    @required this.trivia,
  });

  @override
  List<Object> get props => [trivia];
}

class Error extends NumberTriviaState {
  final String message;

  const Error({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
