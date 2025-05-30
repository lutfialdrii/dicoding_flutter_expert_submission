part of 'tv_serie_detail_bloc.dart';

class TvSerieDetailState extends Equatable {
  final TvSerieDetail? tvSerieDetail;
  final RequestState tvSerieState;
  final List<TvSerie> recommendation;
  final RequestState recommendationState;
  final String message;
  final bool isAddedToWatchlist;
  final String watchlistMessage;

  TvSerieDetailState({
    this.tvSerieDetail,
    this.tvSerieState = RequestState.Empty,
    this.recommendation = const [],
    this.recommendationState = RequestState.Empty,
    this.message = "",
    this.isAddedToWatchlist = false,
    this.watchlistMessage = "",
  });

  TvSerieDetailState copyWith({
    TvSerieDetail? tvSerieDetail,
    RequestState? tvSerieState,
    List<TvSerie>? recommendation,
    RequestState? recommendationState,
    String? message,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
  }) {
    return TvSerieDetailState(
      tvSerieDetail: tvSerieDetail ?? this.tvSerieDetail,
      tvSerieState: tvSerieState ?? this.tvSerieState,
      recommendation: recommendation ?? this.recommendation,
      recommendationState: recommendationState ?? this.recommendationState,
      message: message ?? this.message,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object?> get props => [
        tvSerieDetail,
        tvSerieState,
        recommendation,
        recommendationState,
        message,
        isAddedToWatchlist,
        watchlistMessage,
      ];
}
