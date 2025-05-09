import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tv_serie_detail_model.dart';
import 'package:ditonton/data/models/tv_serie_model.dart';
import 'package:ditonton/data/repositories/tv_serie_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_serie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSerieRepositoryImpl repository;
  late MockTvSerieRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSerieRemoteDataSource();
    repository = TvSerieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  final tTvSerieModel = TvSerieModel(
    adult: false,
    backdropPath: '/',
    genreIds: [0],
    id: 0,
    name: 'Anu',
    overview: '',
    popularity: 0,
    posterPath: '',
    firstAirDate: DateTime(2020),
    originalName: '',
    originalLanguage: "",
    originCountry: [],
    voteAverage: 0,
    voteCount: 0,
  );

  final tTvSerie = TvSerie(
    adult: false,
    backdropPath: '/',
    genreIds: [0],
    id: 0,
    name: 'Anu',
    overview: '',
    popularity: 0,
    posterPath: '',
    firstAirDate: DateTime(2020),
    originalName: '',
    originalLanguage: "",
    originCountry: [],
    voteAverage: 0,
    voteCount: 0,
  );

  final tTvSerieModelList = <TvSerieModel>[tTvSerieModel];
  final tTvSerieList = <TvSerie>[tTvSerie];

  group('OnAir TvSeries', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnairTvSeries())
          .thenAnswer((_) async => tTvSerieModelList);
      // act
      final result = await repository.getOnairTvSeries();
      // assert
      verify(mockRemoteDataSource.getOnairTvSeries());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSerieList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnairTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getOnairTvSeries();
      // assert
      verify(mockRemoteDataSource.getOnairTvSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnairTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnairTvSeries();
      // assert
      verify(mockRemoteDataSource.getOnairTvSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TvSeries', () {
    test('should return TvSerie list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => tTvSerieModelList);
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSerieList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TvSeries', () {
    test('should return TvSerie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => tTvSerieModelList);
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSerieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get TvSerie Detail', () {
    final tId = 1;

    final testTvSerieDetail = TvSerieDetailModel(
        adult: false,
        backdropPath: "backdropPath",
        createdBy: [],
        episodeRunTime: [],
        firstAirDate: DateTime(2020),
        genres: [],
        homepage: "",
        id: 0,
        inProduction: false,
        languages: [],
        lastAirDate: DateTime(2020),
        lastEpisodeToAir: null,
        name: "",
        nextEpisodeToAir: null,
        networks: [],
        numberOfEpisodes: 0,
        numberOfSeasons: 0,
        originCountry: [],
        originalLanguage: "",
        originalName: "",
        overview: "",
        popularity: 0,
        posterPath: "",
        productionCompanies: [],
        productionCountries: [],
        seasons: [],
        spokenLanguages: [],
        status: "",
        tagline: "",
        type: "",
        voteAverage: 0,
        voteCount: 0);

    test(
        'should return TvSerie data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSerieDetail(tId))
          .thenAnswer((_) async => testTvSerieDetail);
      // act
      final result = await repository.getTvSerieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVSerieDetail(tId));
      expect(result, equals(Right(testTvSerieDetail.toEntity())));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSerieDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSerieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVSerieDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSerieDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSerieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVSerieDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TvSerie Recommendations', () {
    final tTvSerieList = <TvSerieModel>[];
    final tId = 1;

    test('should return data (TvSerie list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSerieRecommendations(tId))
          .thenAnswer((_) async => tTvSerieList);
      // act
      final result = await repository.getTvSerieRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvSerieRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvSerieList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSerieRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSerieRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvSerieRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSerieRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSerieRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvSerieRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach TvSeries', () {
    final tQuery = 'spiderman';

    test('should return TvSerie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenAnswer((_) async => tTvSerieModelList);
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSerieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });
}
