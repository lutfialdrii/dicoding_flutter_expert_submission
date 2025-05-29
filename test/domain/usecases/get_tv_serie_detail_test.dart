import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_serie_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSerieDetail usecase;
  late MockTvSerieRepository _repository;

  setUp(() {
    _repository = MockTvSerieRepository();
    usecase = GetTvSerieDetail(_repository);
  });

  final tId = 1;

  test('should get Tv Serie detail from the repository', () async {
    // arrange
    when(_repository.getTvSerieDetail(tId))
        .thenAnswer((_) async => Right(tTvSerieDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvSerieDetail));
  });
}
