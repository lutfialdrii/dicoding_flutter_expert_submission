part of 'tv_serie_detail_bloc.dart';

abstract class TvSerieDetailEvent extends Equatable {
  const TvSerieDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchTvSerieDetail extends TvSerieDetailEvent {
  final int id;

  FetchTvSerieDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class AddTvSerieToWatchlist extends TvSerieDetailEvent {
  final TvSerieDetail tvSerieDetail;

  AddTvSerieToWatchlist(this.tvSerieDetail);

  @override
  List<Object?> get props => [tvSerieDetail];
}

class RemoveTvSerieWatchlist extends TvSerieDetailEvent {
  final TvSerieDetail tvSerieDetail;

  RemoveTvSerieWatchlist(this.tvSerieDetail);

  @override
  List<Object?> get props => [tvSerieDetail];
}

class LoadWatchListStatus extends TvSerieDetailEvent {
  final int id;

  LoadWatchListStatus(this.id);

  @override
  List<Object?> get props => [id];
}
