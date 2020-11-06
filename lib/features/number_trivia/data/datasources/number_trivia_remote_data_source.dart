import 'dart:convert';

import 'package:flutter_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  const NumberTriviaRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
    return _getTriviaFromEndpoint('$number');
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return _getTriviaFromEndpoint('random');
  }

  Future<NumberTriviaModel> _getTriviaFromEndpoint(String endpoint) async {
    final response = await client.get(
      'http://numbersapi.com/$endpoint',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final decodedJson = json.decode(response.body) as Map<String, dynamic>;
    return NumberTriviaModel.fromJson(decodedJson);
  }
}
