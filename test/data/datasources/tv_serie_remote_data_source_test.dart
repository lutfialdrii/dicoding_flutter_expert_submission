import 'dart:convert';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/data/datasources/tv_serie_remote_data_source.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_serie_detail_model.dart';
import 'package:ditonton/data/models/tv_serie_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSerieRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSerieRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing TvSeries', () {
    final tTvSerieList = TvSerieResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series.json')))
        .results;

    test('should return list of TvSerie Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series.json'), 200));
      // act
      final result = await dataSource.getOnairTvSeries();
      // assert
      expect(result, equals(tTvSerieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnairTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TvSeries', () {
    final tTvSerieList = TvSerieResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series.json')))
        .results;

    test('should return list of TvSeries when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series.json'), 200));
      // act
      final result = await dataSource.getPopularTvSeries();
      // assert
      expect(result, tTvSerieList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TvSeries', () {
    final tTvSerieList = TvSerieResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series.json')))
        .results;

    test('should return list of TvSeries when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series.json'), 200));
      // act
      final result = await dataSource.getTopRatedTvSeries();
      // assert
      expect(result, tTvSerieList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get TvSerie detail', () {
    final tId = 1;
    final tTvSerieDetail = TvSerieDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv_serie_detail.json')));

    test('should return TvSerie detail when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_serie_detail.json'), 200));
      // act
      final result = await dataSource.getTVSerieDetail(tId);
      // assert
      expect(result, equals(tTvSerieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVSerieDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get TvSerie recommendations', () {
    final tTvSerieList = TvSerieResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_recommedantions.json')))
        .results;
    final tId = 1;

    test('should return list of TvSerie Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series_recommedantions.json'), 200));
      // act
      final result = await dataSource.getTvSerieRecommendations(tId);
      // assert
      expect(result, equals(tTvSerieList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvSerieRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search TvSeries', () {
    final tSearchResult = TvSerieResponse.fromJson(
            json.decode(readJson('dummy_data/search_anu_tvserie.json')))
        .results;
    final tQuery = 'anu';

    test('should return list of TvSeries when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_anu_tvserie.json'), 200));
      // act
      final result = await dataSource.searchTvSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    // test('should throw ServerException when response code is other than 200',
    //     () async {
    //   // arrange
    //   when(mockHttpClient
    //           .get(Uri.parse('$BASE_URL/search/tv/?$API_KEY&query=$tQuery')))
    //       .thenAnswer((_) async => http.Response('Not Found', 404));
    //   // act
    //   final call = dataSource.searchTvSeries(tQuery);
    //   // assert
    //   expect(() => call, throwsA(isA<ServerException>()));
    // });
  });
}
