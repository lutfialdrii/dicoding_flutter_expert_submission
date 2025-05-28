import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlist usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = SaveWatchlist(mockWatchlistRepository);
  });

  test('should save movie/tv serie to the repository', () async {
    // arrange
    when(mockWatchlistRepository.saveWatchlist(tWatchlistMovie))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(tWatchlistMovie);
    // assert
    verify(mockWatchlistRepository.saveWatchlist(tWatchlistMovie));
    expect(result, Right('Added to Watchlist'));
  });
}
