import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_serie.dart';
import 'package:ditonton/domain/usecases/get_onair_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnairTvSeries usecase;
  late MockTvSerieRepository _repository;

  setUp(() {
    _repository = MockTvSerieRepository();
    usecase = GetOnairTvSeries(_repository);
  });

  final tTvSeries = <TvSerie>[];

  test('should get list of tvSeries from the repository', () async {
    // arrange
    when(_repository.getOnairTvSeries())
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvSeries));
  });
}
