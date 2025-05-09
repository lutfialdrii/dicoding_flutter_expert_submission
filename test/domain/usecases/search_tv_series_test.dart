import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_serie.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSerieRepository _repository;

  setUp(() {
    _repository = MockTvSerieRepository();
    usecase = SearchTvSeries(_repository);
  });

  final tTvSeries = <TvSerie>[];
  final tQuery = 'Anu';

  test('should get list of tv series from the repository', () async {
    // arrange
    when(_repository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvSeries));
  });
}
