import 'dart:convert';

import 'package:flutter_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastNumberTrivia', () {
    final tCachedTriviaJson = fixture('trivia_cached.json');
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      json.decode(tCachedTriviaJson) as Map<String, dynamic>,
    );

    test(
        'should return NumberTrivia from SharedPreferences when there is one in the cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(tCachedTriviaJson);

      // act
      final result = await dataSource.getLastNumberTrivia();

      // assert
      verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a CacheException when there is not a cached value',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      // act
      final result = dataSource.getLastNumberTrivia();

      // assert
      expect(result, throwsA(isA<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    const tNumberTriviaModel = NumberTriviaModel(text: 'Test', number: 1);
    final tNumberTriviaModelJson = json.encode(tNumberTriviaModel.toJson());

    test('should call SharedPreferences to cache the data', () async {
      // act
      await dataSource.cacheNumberTrivia(tNumberTriviaModel);

      // assert
      verify(mockSharedPreferences.setString(
        CACHED_NUMBER_TRIVIA,
        tNumberTriviaModelJson,
      ));
    });
  });
}
