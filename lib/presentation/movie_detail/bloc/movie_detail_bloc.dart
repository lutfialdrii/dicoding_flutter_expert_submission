import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc(
    this.getMovieDetail,
    this.getMovieRecommendations,
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
  ) : super(MovieDetailState()) {
    on<FetchMovieDetail>(
      (event, emit) async {
        emit(state.copyWith(movieState: RequestState.Loading));

        final detailResult = await getMovieDetail.execute(event.id);
        final recommendationResult =
            await getMovieRecommendations.execute(event.id);

        detailResult.fold(
          (l) {
            emit(state.copyWith(
                movieState: RequestState.Error, message: l.message));
          },
          (r) {
            emit(state.copyWith(
                movieState: RequestState.Loaded,
                movieDetail: r,
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

    on<AddMovieToWatchlist>(
      (event, emit) async {
        final result = await saveWatchlist
            .execute(Watchlist.fromMovieDetailEntity(event.movieDetail));
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

    on<RemoveMovieWatchlist>(
      (event, emit) async {
        final result = await removeWatchlist
            .execute(Watchlist.fromMovieDetailEntity(event.movieDetail));
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
        emit(MovieDetailState().copyWith(isAddedToWatchlist: result));
      },
    );
  }
}
