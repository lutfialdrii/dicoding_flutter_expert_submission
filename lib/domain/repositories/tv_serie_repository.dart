import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_serie.dart';

abstract class TvSerieRepository {
  Future<Either<Failure, List<TvSerie>>> getOnairTvSeries();
  Future<Either<Failure, List<TvSerie>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSerie>>> getTopRatedTvSeries();
}
