import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockWatchlistRepository _repository;

  setUp(() {
    _repository = MockWatchlistRepository();
    usecase = RemoveWatchlist(_repository);
  });

  test('should remove watchlist from repository', () async {
    // arrange
    when(_repository.removeWatchlist(testWatchlistMovie))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testWatchlistMovie);
    // assert
    verify(_repository.removeWatchlist(testWatchlistMovie));
    expect(result, Right('Removed from watchlist'));
  });
}
