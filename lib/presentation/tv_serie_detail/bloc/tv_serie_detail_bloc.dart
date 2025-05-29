import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_serie.dart';
import 'package:ditonton/domain/entities/tv_serie_detail.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/usecases/get_tv_serie_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_serie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'tv_serie_detail_event.dart';
part 'tv_serie_detail_state.dart';

class TvSerieDetailBloc extends Bloc<TvSerieDetailEvent, TvSerieDetailState> {
  final GetTvSerieDetail getTvSerieDetail;
  final GetTvSerieRecommendations getTvSerieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  TvSerieDetailBloc(this.getTvSerieDetail, this.getTvSerieRecommendations,
      this.getWatchListStatus, this.saveWatchlist, this.removeWatchlist)
      : super(TvSerieDetailState()) {
    on<FetchTvSerieDetail>(
      (event, emit) async {
        emit(state.copyWith(tvSerieState: RequestState.Loading));

        final detailResult = await getTvSerieDetail.execute(event.id);
        final recommendationResult =
            await getTvSerieRecommendations.execute(event.id);

        detailResult.fold(
          (l) {
            emit(state.copyWith(
                tvSerieState: RequestState.Error, message: l.message));
          },
          (r) {
            emit(state.copyWith(
                tvSerieState: RequestState.Loaded,
                tvSerieDetail: r,
                recommendationState: RequestState.Loading));

            recommendationResult.fold(
              (l) {
                emit(state.copyWith(
                    recommendationState: RequestState.Error,
                    message: l.message));
              },
              (r) {
                emit(state.copyWith(
                    recommendationState: RequestState.Loaded,
                    recommendation: r));
              },
            );
          },
        );
      },
    );

    on<AddTvSerieToWatchlist>(
      (event, emit) async {
        final result = await saveWatchlist
            .execute(Watchlist.fromTvSerieDetailEntity(event.tvSerieDetail));
        result.fold(
          (l) {
            emit(state.copyWith(watchlistMessage: l.message));
          },
          (r) {
            emit(state.copyWith(watchlistMessage: r, isAddedToWatchlist: true));
          },
        );
      },
    );

    on<RemoveTvSerieWatchlist>(
      (event, emit) async {
        final result = await removeWatchlist
            .execute(Watchlist.fromTvSerieDetailEntity(event.tvSerieDetail));
        result.fold(
          (l) {
            emit(state.copyWith(watchlistMessage: l.message));
          },
          (r) {
            emit(
                state.copyWith(watchlistMessage: r, isAddedToWatchlist: false));
          },
        );
      },
    );
    on<LoadWatchListStatus>(
      (event, emit) async {
        final result = await getWatchListStatus.execute(event.id);
        emit(TvSerieDetailState().copyWith(isAddedToWatchlist: result));
      },
    );
  }
}
