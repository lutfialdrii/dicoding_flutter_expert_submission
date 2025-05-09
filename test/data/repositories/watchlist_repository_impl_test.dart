import 'package:dartz/dartz.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/data/repositories/watchlist_repository_impl.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistRepositoryImpl _repository;
  late MockWatchlistLocalDataSource mockWatchlistLocalDataSource;

  setUp(() {
    mockWatchlistLocalDataSource = MockWatchlistLocalDataSource();
    _repository = WatchlistRepositoryImpl(
      localDataSource: mockWatchlistLocalDataSource,
    );
  });

  final tWatchlist = Watchlist(
    id: 1,
    title: 'Spider-Man',
    overview: 'Overview',
    posterPath: 'poster.jpg',
    category: Category.movie,
  );

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockWatchlistLocalDataSource.insertWatchlist(tWatchlist))
          .thenAnswer((_) async => 'Added to Watchlist');

      // act
      final result = await _repository.saveWatchlist(tWatchlist);

      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockWatchlistLocalDataSource.insertWatchlist(tWatchlist))
          .thenThrow(DatabaseException('Failed to add watchlist'));

      // act
      final result = await _repository.saveWatchlist(tWatchlist);

      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when removing successful', () async {
      // arrange
      when(mockWatchlistLocalDataSource.removeWatchlist(tWatchlist))
          .thenAnswer((_) async => 'Removed from Watchlist');

      // act
      final result = await _repository.removeWatchlist(tWatchlist);

      // assert
      expect(result, Right('Removed from Watchlist'));
    });

    test('should return DatabaseFailure when removing unsuccessful', () async {
      // arrange
      when(mockWatchlistLocalDataSource.removeWatchlist(tWatchlist))
          .thenThrow(DatabaseException('Failed to remove watchlist'));

      // act
      final result = await _repository.removeWatchlist(tWatchlist);

      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('is added to watchlist', () {
    test('should return true when data is found', () async {
      // arrange
      when(mockWatchlistLocalDataSource.getMovieById(1))
          .thenAnswer((_) async => tWatchlist);

      // act
      final result = await _repository.isAddedToWatchlist(1);

      // assert
      expect(result, true);
    });

    test('should return false when data is not found', () async {
      // arrange
      when(mockWatchlistLocalDataSource.getMovieById(1))
          .thenAnswer((_) async => null);

      // act
      final result = await _repository.isAddedToWatchlist(1);

      // assert
      expect(result, false);
    });
  });

  group('get watchlist', () {
    test('should return list of watchlist', () async {
      // arrange
      when(mockWatchlistLocalDataSource.getWatchlist())
          .thenAnswer((_) async => [tWatchlist]);

      // act
      final result = await _repository.getWatchlist();

      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [tWatchlist]);
    });
  });
}
