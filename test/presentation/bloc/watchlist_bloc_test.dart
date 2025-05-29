import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist.dart';
import 'package:ditonton/presentation/watchlist/bloc/watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlist])
void main() {
  late MockGetWatchlist mockGetWatchlist;
  late WatchlistBloc watchlistBloc;

  setUp(
    () {
      mockGetWatchlist = MockGetWatchlist();
      watchlistBloc = WatchlistBloc(mockGetWatchlist);
    },
  );


  test(
    "if start , should be initial state",
    () {
      expect(watchlistBloc.state, WatchListInitial());
    },
  );

  blocTest<WatchlistBloc, WatchlistState>(
    "Should emit [loading, error] when unsuccessful",
    build: () {
      when(mockGetWatchlist.execute()).thenAnswer(
        (_) async => Left(DatabaseFailure(tMessage)),
      );
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlist()),
    expect: () =>
        [WatchListLoading(),WatchListError(tMessage)],
    verify: (bloc) {
      verify(mockGetWatchlist.execute());
    },
  );

  blocTest<WatchlistBloc, WatchlistState>(
    "Should emit loading, loaded when fetch successful",
    build: () {
      when(mockGetWatchlist.execute()).thenAnswer(
        (_) async => Right(testWatchList),
      );
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlist()),
    expect: () => [WatchListLoading(), WatchListLoaded(testWatchList)],
    verify: (bloc) {
      verify(mockGetWatchlist.execute());
    },
  );
}
