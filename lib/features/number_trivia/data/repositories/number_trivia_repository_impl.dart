import 'package:flutter_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture/core/platform/network_info.dart';
import 'package:flutter_clean_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:meta/meta.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        final trivia = await remoteDataSource.getConcreteNumberTrivia(number);
        await localDataSource.cacheNumberTrivia(trivia);

        return Right(trivia);
      } else {
        final trivia = await localDataSource.getLastNumberTrivia();
        return Right(trivia);
      }
    } on ServerException {
      return const Left(ServerFailure());
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
