import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_serie.dart';
import 'package:ditonton/domain/usecases/get_tv_serie_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSerieRecommendations usecase;
  late MockTvSerieRepository _repository;

  setUp(() {
    _repository = MockTvSerieRepository();
    usecase = GetTvSerieRecommendations(_repository);
  });

  final tId = 1;
  final tTvSeries = <TvSerie>[];

  test('should get list of tv serie recommendations from the repository',
      () async {
    // arrange
    when(_repository.getTvSerieRecommendations(tId))
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvSeries));
  });
}
