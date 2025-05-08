import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_serie.dart';
import 'package:ditonton/domain/entities/tv_serie_detail.dart';

abstract class TvSerieRepository {
  Future<Either<Failure, List<TvSerie>>> getOnairTvSeries();
  Future<Either<Failure, List<TvSerie>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSerie>>> getTopRatedTvSeries();
  Future<Either<Failure, TvSerieDetail>> getTvSerieDetail(int id);
  Future<Either<Failure, List<TvSerie>>> getTvSerieRecommendations(int id);
  Future<Either<Failure, List<TvSerie>>> searchTvSeries(String query);
}
