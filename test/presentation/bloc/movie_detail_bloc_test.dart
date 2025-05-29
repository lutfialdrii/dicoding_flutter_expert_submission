import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist
])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  late MovieDetailBloc movieDetailBloc;

  setUp(
    () {
      mockGetMovieDetail = MockGetMovieDetail();
      mockGetMovieRecommendations = MockGetMovieRecommendations();
      mockGetWatchListStatus = MockGetWatchListStatus();
      mockSaveWatchlist = MockSaveWatchlist();
      mockRemoveWatchlist = MockRemoveWatchlist();

      movieDetailBloc = MovieDetailBloc(
        mockGetMovieDetail,
        mockGetMovieRecommendations,
        mockGetWatchListStatus,
        mockSaveWatchlist,
        mockRemoveWatchlist,
      );
    },
  );

  final int tMovieId = 0;

  test(
    "if start , should be initial state",
    () {
      expect(movieDetailBloc.state, MovieDetailState());
    },
  );

  group(
    "Get Detail Movie",
    () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        "Should emit [loading, loaded] when get detail movie & get recommendation successful",
        build: () {
          when(mockGetMovieDetail.execute(tMovieId)).thenAnswer(
            (_) async => Right(tMovieDetail),
          );
          when(mockGetMovieRecommendations.execute(tMovieId)).thenAnswer(
            (_) async => Right(tMovieList),
          );
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchMovieDetail(tMovieId)),
        expect: () => [
          MovieDetailState().copyWith(
            movieState: RequestState.Loading,
          ),
          MovieDetailState().copyWith(
            movieState: RequestState.Loaded,
            movieDetail: tMovieDetail,
            recommendationState: RequestState.Loading,
          ),
          MovieDetailState().copyWith(
            movieState: RequestState.Loaded,
            movieDetail: tMovieDetail,
            recommendation: tMovieList,
            recommendationState: RequestState.Loaded,
          )
        ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tMovieId));
          verify(mockGetMovieRecommendations.execute(tMovieId));
        },
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        "Should emit [movie state loading, movie state loaded, recommendationState loading, recommendationState error] when get detail movie success but get recommendation unsuccess",
        build: () {
          when(mockGetMovieDetail.execute(tMovieId)).thenAnswer(
            (_) async => Right(tMovieDetail),
          );
          when(mockGetMovieRecommendations.execute(tMovieId)).thenAnswer(
            (_) async => Left(ServerFailure(tMessage)),
          );
          return movieDetailBloc;
        },
        act: (bloc) => movieDetailBloc.add(FetchMovieDetail(tMovieId)),
        expect: () => [
          MovieDetailState().copyWith(
            movieState: RequestState.Loading,
          ),
          MovieDetailState().copyWith(
            movieState: RequestState.Loaded,
            movieDetail: tMovieDetail,
            recommendationState: RequestState.Loading,
          ),
          MovieDetailState().copyWith(
            movieState: RequestState.Loaded,
            movieDetail: tMovieDetail,
            message: tMessage,
            recommendationState: RequestState.Error,
          )
        ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tMovieId));
          verify(mockGetMovieRecommendations.execute(tMovieId));
        },
      );
      blocTest<MovieDetailBloc, MovieDetailState>(
        "Should emit [movie state loading, movie state error] when get detail movie unsuccessful",
        build: () {
          when(mockGetMovieDetail.execute(tMovieId)).thenAnswer(
            (_) async => Left(ServerFailure(tMessage)),
          );
          when(mockGetMovieRecommendations.execute(tMovieId)).thenAnswer(
            (_) async => Left(ServerFailure(tMessage)),
          );
          return movieDetailBloc;
        },
        act: (bloc) => movieDetailBloc.add(FetchMovieDetail(tMovieId)),
        expect: () => [
          MovieDetailState().copyWith(
            movieState: RequestState.Loading,
          ),
          MovieDetailState()
              .copyWith(movieState: RequestState.Error, message: tMessage),
        ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tMovieId));
        },
      );
    },
  );

  group(
    "Watchlist",
    () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        "Should emit watchlist message when success save movie",
        build: () {
          when(mockSaveWatchlist.execute(tWatchlistMovie))
              .thenAnswer((_) async => Right(tMessage));
          return movieDetailBloc;
        },
        act: (bloc) => movieDetailBloc.add(AddMovieToWatchlist(tMovieDetail)),
        expect: () => [
          MovieDetailState()
              .copyWith(watchlistMessage: tMessage, isAddedToWatchlist: true),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(tWatchlistMovie));
        },
      );
      blocTest<MovieDetailBloc, MovieDetailState>(
        "Should emit watchlist message when failed save movie",
        build: () {
          when(mockSaveWatchlist.execute(tWatchlistMovie))
              .thenAnswer((_) async => Left(DatabaseFailure(tMessage)));
          return movieDetailBloc;
        },
        act: (bloc) => movieDetailBloc.add(AddMovieToWatchlist(tMovieDetail)),
        expect: () => [
          MovieDetailState().copyWith(watchlistMessage: tMessage),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(tWatchlistMovie));
        },
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        "Should emit watchlist message when success remove movie",
        build: () {
          when(mockRemoveWatchlist.execute(tWatchlistMovie))
              .thenAnswer((_) async => Right(tMessage));
          return movieDetailBloc;
        },
        act: (bloc) => movieDetailBloc.add(RemoveMovieWatchlist(tMovieDetail)),
        expect: () => [
          MovieDetailState()
              .copyWith(watchlistMessage: tMessage, isAddedToWatchlist: false),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(tWatchlistMovie));
        },
      );
      blocTest<MovieDetailBloc, MovieDetailState>(
        "Should emit watchlist message when failed remove movie",
        build: () {
          when(mockRemoveWatchlist.execute(tWatchlistMovie))
              .thenAnswer((_) async => Left(DatabaseFailure(tMessage)));
          return movieDetailBloc;
        },
        act: (bloc) => movieDetailBloc.add(RemoveMovieWatchlist(tMovieDetail)),
        expect: () => [
          MovieDetailState().copyWith(watchlistMessage: tMessage),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(tWatchlistMovie));
        },
      );
      blocTest<MovieDetailBloc, MovieDetailState>(
        "Should emit true when get movie watchlisted",
        build: () {
          when(mockGetWatchListStatus.execute(tMovieId))
              .thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => movieDetailBloc.add(LoadWatchListStatus(tMovieId)),
        expect: () => [
          MovieDetailState().copyWith(isAddedToWatchlist: true),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(tMovieId));
        },
      );
    },
  );
}
