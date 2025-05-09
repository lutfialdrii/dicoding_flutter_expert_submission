import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/datasources/tv_serie_remote_data_source.dart';
import 'package:ditonton/domain/entities/tv_serie.dart';
import 'package:ditonton/domain/entities/tv_serie_detail.dart';
import 'package:ditonton/domain/repositories/tv_serie_repository.dart';

class TvSerieRepositoryImpl implements TvSerieRepository {
  final TvSerieRemoteDataSource remoteDataSource;

  TvSerieRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<TvSerie>>> getOnairTvSeries() async {
    try {
      final result = await remoteDataSource.getOnairTvSeries();
      return Right(result.map(
        (e) {
          return e.toEntity();
        },
      ).toList());
    } on ServerException {
      return Left(ServerFailure(""));
    } on SocketException {
      return Left(ConnectionFailure("Failed to connect to the network"));
    }
  }

  @override
  Future<Either<Failure, List<TvSerie>>> getPopularTvSeries() async {
    try {
      final result = await remoteDataSource.getPopularTvSeries();
      return Right(result.map(
        (e) {
          return e.toEntity();
        },
      ).toList());
    } on ServerException {
      return Left(ServerFailure(""));
    } on SocketException {
      return Left(ConnectionFailure("Failed to connect to the network"));
    }
  }

  @override
  Future<Either<Failure, List<TvSerie>>> getTopRatedTvSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedTvSeries();
      return Right(result.map(
        (e) {
          return e.toEntity();
        },
      ).toList());
    } on ServerException {
      return Left(ServerFailure(""));
    } on SocketException {
      return Left(ConnectionFailure("Failed to connect to the network"));
    }
  }

  @override
  Future<Either<Failure, TvSerieDetail>> getTvSerieDetail(int id) async {
    try {
      final result = await remoteDataSource.getTVSerieDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(""));
    } on SocketException {
      return Left(ConnectionFailure("Failed to connect to the network"));
    }
  }

  @override
  Future<Either<Failure, List<TvSerie>>> getTvSerieRecommendations(
      int id) async {
    try {
      final result = await remoteDataSource.getTvSerieRecommendations(id);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(""));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSerie>>> searchTvSeries(String query) async {
    try {
      final result = await remoteDataSource.searchTvSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
