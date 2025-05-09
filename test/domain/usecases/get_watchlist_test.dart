import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlist usecase;
  late MockWatchlistRepository _repository;

  setUp(() {
    _repository = MockWatchlistRepository();
    usecase = GetWatchlist(_repository);
  });

  test('should get list of watchlist from the repository', () async {
    // arrange
    when(_repository.getWatchlist())
        .thenAnswer((_) async => Right(testWatchList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testWatchList));
  });
}
