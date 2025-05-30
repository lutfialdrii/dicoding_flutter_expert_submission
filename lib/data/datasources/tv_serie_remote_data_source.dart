import 'dart:convert';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/ssl_pinning_client.dart';
import 'package:ditonton/data/models/tv_serie_detail_model.dart';
import 'package:ditonton/data/models/tv_serie_model.dart';
import 'package:ditonton/data/models/tv_serie_response.dart';

abstract class TvSerieRemoteDataSource {
  Future<List<TvSerieModel>> getOnairTvSeries();
  Future<List<TvSerieModel>> getPopularTvSeries();
  Future<List<TvSerieModel>> getTopRatedTvSeries();
  Future<TvSerieDetailModel> getTVSerieDetail(int id);
  Future<List<TvSerieModel>> getTvSerieRecommendations(int id);
  Future<List<TvSerieModel>> searchTvSeries(String query);
}

class TvSerieRemoteDataSourceImpl implements TvSerieRemoteDataSource {
  final SSLPinningClient client;

  TvSerieRemoteDataSourceImpl({
    required this.client,
  });
  @override
  Future<List<TvSerieModel>> getOnairTvSeries() async {
    try {
      final response =
          await client.get(Uri.parse("$BASE_URL/tv/on_the_air?$API_KEY"));

      if (response.statusCode == 200) {
        final rawdata = TvSerieResponse.fromJson(jsonDecode(response.body));
        return rawdata.results;
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TvSerieModel>> getPopularTvSeries() async {
    try {
      final response =
          await client.get(Uri.parse("$BASE_URL/tv/popular?$API_KEY"));

      if (response.statusCode == 200) {
        final rawdata = TvSerieResponse.fromJson(jsonDecode(response.body));
        return rawdata.results;
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TvSerieModel>> getTopRatedTvSeries() async {
    try {
      final response =
          await client.get(Uri.parse("$BASE_URL/tv/top_rated?$API_KEY"));

      if (response.statusCode == 200) {
        final rawdata = TvSerieResponse.fromJson(jsonDecode(response.body));
        return rawdata.results;
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TvSerieDetailModel> getTVSerieDetail(int id) async {
    try {
      final response = await client.get(Uri.parse("$BASE_URL/tv/$id?$API_KEY"));

      if (response.statusCode == 200) {
        final data = TvSerieDetailModel.fromJson(jsonDecode(response.body));
        return data;
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TvSerieModel>> getTvSerieRecommendations(int id) async {
    try {
      final response = await client
          .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

      if (response.statusCode == 200) {
        return TvSerieResponse.fromJson(jsonDecode(response.body)).results;
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TvSerieModel>> searchTvSeries(String query) async {
    try {
      final response = await client
          .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

      if (response.statusCode == 200) {
        final rawdata = TvSerieResponse.fromJson(jsonDecode(response.body));
        return rawdata.results;
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }
}
