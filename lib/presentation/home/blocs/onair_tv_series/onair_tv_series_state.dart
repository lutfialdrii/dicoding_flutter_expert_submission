part of 'onair_tv_series_bloc.dart';

abstract class OnairTvSeriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnairTvSeriesInitial extends OnairTvSeriesState {
  @override
  List<Object?> get props => [];
}

class OnairTvSeriesLoading extends OnairTvSeriesState {
  @override
  List<Object?> get props => [];
}

class OnairTvSeriesError extends OnairTvSeriesState {
  final String message;

  OnairTvSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class OnAirTvSeriesLoaded extends OnairTvSeriesState {
  final List<TvSerie>? data;

  OnAirTvSeriesLoaded(this.data);

  @override
  List<Object?> get props => [data];
}
