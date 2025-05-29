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
    when(_repository.removeWatchlist(tWatchlistMovie))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(tWatchlistMovie);
    // assert
    verify(_repository.removeWatchlist(tWatchlistMovie));
    expect(result, Right('Removed from watchlist'));
  });
}
