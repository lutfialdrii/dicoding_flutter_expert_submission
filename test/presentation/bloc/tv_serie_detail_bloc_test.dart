import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_serie_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_serie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/tv_serie_detail/bloc/tv_serie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import 'tv_serie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSerieDetail,
  GetTvSerieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MockGetTvSerieDetail mockGetTvSerieDetail;
  late MockGetTvSerieRecommendations mockGetTvSerieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  late TvSerieDetailBloc tvSerieDetailBloc;

  setUp(
    () {
      mockGetTvSerieDetail = MockGetTvSerieDetail();
      mockGetTvSerieRecommendations = MockGetTvSerieRecommendations();
      mockGetWatchListStatus = MockGetWatchListStatus();
      mockSaveWatchlist = MockSaveWatchlist();
      mockRemoveWatchlist = MockRemoveWatchlist();

      tvSerieDetailBloc = TvSerieDetailBloc(
        mockGetTvSerieDetail,
        mockGetTvSerieRecommendations,
        mockGetWatchListStatus,
        mockSaveWatchlist,
        mockRemoveWatchlist,
      );
    },
  );

  final int tTvSerieID = 0;

  test(
    "if start , should be initial state",
    () {
      expect(tvSerieDetailBloc.state, TvSerieDetailState());
    },
  );

  group(
    "Get Detail TvSerie",
    () {
      blocTest<TvSerieDetailBloc, TvSerieDetailState>(
        "Should emit [loading, loaded] when get detail tvserie & get recommendation successful",
        build: () {
          when(mockGetTvSerieDetail.execute(tTvSerieID)).thenAnswer(
            (_) async => Right(tTvSerieDetail),
          );
          when(mockGetTvSerieRecommendations.execute(tTvSerieID)).thenAnswer(
            (_) async => Right(tTvSerieList),
          );
          return tvSerieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchTvSerieDetail(tTvSerieID)),
        expect: () => [
          TvSerieDetailState().copyWith(
            tvSerieState: RequestState.Loading,
          ),
          TvSerieDetailState().copyWith(
            tvSerieState: RequestState.Loaded,
            tvSerieDetail: tTvSerieDetail,
            recommendationState: RequestState.Loading,
          ),
          TvSerieDetailState().copyWith(
            tvSerieState: RequestState.Loaded,
            tvSerieDetail: tTvSerieDetail,
            recommendation: tTvSerieList,
            recommendationState: RequestState.Loaded,
          )
        ],
        verify: (bloc) {
          verify(mockGetTvSerieDetail.execute(tTvSerieID));
          verify(mockGetTvSerieRecommendations.execute(tTvSerieID));
        },
      );

      blocTest<TvSerieDetailBloc, TvSerieDetailState>(
        "Should emit [TvSerie state loading, TvSerie state loaded, recommendationState loading, recommendationState error] when get detail TvSerie success but get recommendation unsuccess",
        build: () {
          when(mockGetTvSerieDetail.execute(tTvSerieID)).thenAnswer(
            (_) async => Right(tTvSerieDetail),
          );
          when(mockGetTvSerieRecommendations.execute(tTvSerieID)).thenAnswer(
            (_) async => Left(ServerFailure(tMessage)),
          );
          return tvSerieDetailBloc;
        },
        act: (bloc) => tvSerieDetailBloc.add(FetchTvSerieDetail(tTvSerieID)),
        expect: () => [
          TvSerieDetailState().copyWith(
            tvSerieState: RequestState.Loading,
          ),
          TvSerieDetailState().copyWith(
            tvSerieState: RequestState.Loaded,
            tvSerieDetail: tTvSerieDetail,
            recommendationState: RequestState.Loading,
          ),
          TvSerieDetailState().copyWith(
            tvSerieState: RequestState.Loaded,
            tvSerieDetail: tTvSerieDetail,
            message: tMessage,
            recommendationState: RequestState.Error,
          )
        ],
        verify: (bloc) {
          verify(mockGetTvSerieDetail.execute(tTvSerieID));
          verify(mockGetTvSerieRecommendations.execute(tTvSerieID));
        },
      );
      blocTest<TvSerieDetailBloc, TvSerieDetailState>(
        "Should emit [TvSerie state loading, TvSerie state error] when get detail TvSerie unsuccessful",
        build: () {
          when(mockGetTvSerieDetail.execute(tTvSerieID)).thenAnswer(
            (_) async => Left(ServerFailure(tMessage)),
          );
          when(mockGetTvSerieRecommendations.execute(tTvSerieID)).thenAnswer(
            (_) async => Left(ServerFailure(tMessage)),
          );
          return tvSerieDetailBloc;
        },
        act: (bloc) => tvSerieDetailBloc.add(FetchTvSerieDetail(tTvSerieID)),
        expect: () => [
          TvSerieDetailState().copyWith(
            tvSerieState: RequestState.Loading,
          ),
          TvSerieDetailState()
              .copyWith(tvSerieState: RequestState.Error, message: tMessage),
        ],
        verify: (bloc) {
          verify(mockGetTvSerieDetail.execute(tTvSerieID));
        },
      );
    },
  );

  group(
    "Watchlist",
    () {
      blocTest<TvSerieDetailBloc, TvSerieDetailState>(
        "Should emit watchlist message when success save TvSerie",
        build: () {
          when(mockSaveWatchlist.execute(any)).thenAnswer(
            (realInvocation) async => Right(tMessage),
          );
          return tvSerieDetailBloc;
        },
        act: (bloc) =>
            tvSerieDetailBloc.add(AddTvSerieToWatchlist(tTvSerieDetail)),
        expect: () => [
          TvSerieDetailState()
              .copyWith(watchlistMessage: tMessage, isAddedToWatchlist: true),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(any));
        },
      );
      blocTest<TvSerieDetailBloc, TvSerieDetailState>(
        "Should emit watchlist message when failed save TvSerie",
        build: () {
          when(mockSaveWatchlist.execute(any))
              .thenAnswer((_) async => Left(DatabaseFailure(tMessage)));
          return tvSerieDetailBloc;
        },
        act: (bloc) =>
            tvSerieDetailBloc.add(AddTvSerieToWatchlist(tTvSerieDetail)),
        expect: () => [
          TvSerieDetailState().copyWith(watchlistMessage: tMessage),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(any));
        },
      );

      blocTest<TvSerieDetailBloc, TvSerieDetailState>(
        "Should emit watchlist message when success remove TvSerie",
        build: () {
          when(mockRemoveWatchlist.execute(any))
              .thenAnswer((_) async => Right(tMessage));
          return tvSerieDetailBloc;
        },
        act: (bloc) =>
            tvSerieDetailBloc.add(RemoveTvSerieWatchlist(tTvSerieDetail)),
        expect: () => [
          TvSerieDetailState()
              .copyWith(watchlistMessage: tMessage, isAddedToWatchlist: false),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(any));
        },
      );
      blocTest<TvSerieDetailBloc, TvSerieDetailState>(
        "Should emit watchlist message when failed remove TvSerie",
        build: () {
          when(mockRemoveWatchlist.execute(any))
              .thenAnswer((_) async => Left(DatabaseFailure(tMessage)));
          return tvSerieDetailBloc;
        },
        act: (bloc) =>
            tvSerieDetailBloc.add(RemoveTvSerieWatchlist(tTvSerieDetail)),
        expect: () => [
          TvSerieDetailState().copyWith(watchlistMessage: tMessage),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(any));
        },
      );
      blocTest<TvSerieDetailBloc, TvSerieDetailState>(
        "Should emit true when get TvSerie watchlisted",
        build: () {
          when(mockGetWatchListStatus.execute(tTvSerieID))
              .thenAnswer((_) async => true);
          return tvSerieDetailBloc;
        },
        act: (bloc) => tvSerieDetailBloc.add(LoadWatchListStatus(tTvSerieID)),
        expect: () => [
          TvSerieDetailState().copyWith(isAddedToWatchlist: true),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(tTvSerieID));
        },
      );
    },
  );
}
