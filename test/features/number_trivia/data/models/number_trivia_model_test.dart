import 'dart:convert';

import 'package:flutter_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test');

  test('should be a subclass of NumberTrivia entity', () {
    // assert
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJSON', () {
    test('should return a valid model when the JSON number is an integer', () {
      // arrange
      final jsonMap = json.decode(fixture('trivia.json')) as Map<String, dynamic>;

      // act
      final result = NumberTriviaModel.fromJSON(jsonMap);

      // assert
      expect(result, tNumberTriviaModel);
    });

    test('should return a valid model when the JSON number is regarded as a double', () {
      // arrange
      final jsonMap = json.decode(fixture('trivia_double.json')) as Map<String, dynamic>;

      // act
      final result = NumberTriviaModel.fromJSON(jsonMap);

      // assert
      expect(result, tNumberTriviaModel);
    });
  });

  group('toJSON', () {
    test('should return a JSON map containing the proper data', () {
      // act
      final result = tNumberTriviaModel.toJSON();

      // assert
      final expectedMap = {'number': 1, 'text': 'Test'};
      expect(result, expectedMap);
    });
  });
}
