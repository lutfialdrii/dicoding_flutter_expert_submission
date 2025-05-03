import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_serie.dart';
import 'package:ditonton/domain/repositories/tv_serie_repository.dart';

import '../../common/failure.dart';

class GetPopularTvSeries {
  final TvSerieRepository repository;

  GetPopularTvSeries(this.repository);

  Future<Either<Failure, List<TvSerie>>> execute() {
    return repository.getPopularTvSeries();
  }
}
