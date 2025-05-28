// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final MovieDetail? movieDetail;
  final RequestState movieState;
  final List<Movie> recommendation;
  final RequestState recommendationState;
  final String message;
  final bool isAddedToWatchlist;
  final String watchlistMessage;

  MovieDetailState({
    this.movieDetail,
    this.movieState = RequestState.Empty,
    this.recommendation = const [],
    this.recommendationState = RequestState.Empty,
    this.message = "",
    this.isAddedToWatchlist = false,
    this.watchlistMessage = "",
  });

  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    RequestState? movieState,
    List<Movie>? recommendation,
    RequestState? recommendationState,
    String? message,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieState: movieState ?? this.movieState,
      recommendation: recommendation ?? this.recommendation,
      recommendationState: recommendationState ?? this.recommendationState,
      message: message ?? this.message,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object?> get props => [
        movieDetail,
        movieState,
        recommendation,
        recommendationState,
        message,
        isAddedToWatchlist,
        watchlistMessage,
      ];
}
