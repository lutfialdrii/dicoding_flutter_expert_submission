part of 'top_rated_tv_series_bloc.dart';

abstract class TopRatedTvSeriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TopRatedTvSeriesInitial extends TopRatedTvSeriesState {
  @override
  List<Object?> get props => [];
}

class TopRatedTvSeriesLoading extends TopRatedTvSeriesState {
  @override
  List<Object?> get props => [];
}

class TopRatedTvSeriesError extends TopRatedTvSeriesState {
  final String message;

  TopRatedTvSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class TopRatedTvSeriesLoaded extends TopRatedTvSeriesState {
  final List<TvSerie>? data;

  TopRatedTvSeriesLoaded(this.data);

  @override
  List<Object?> get props => [data];
}
