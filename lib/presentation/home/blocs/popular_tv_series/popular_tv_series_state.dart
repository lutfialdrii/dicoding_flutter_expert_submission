part of 'popular_tv_series_bloc.dart';

abstract class PopularTvSeriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PopularTvSeriesInitial extends PopularTvSeriesState {
  @override
  List<Object?> get props => [];
}

class PopularTvSeriesLoading extends PopularTvSeriesState {
  @override
  List<Object?> get props => [];
}

class PopularTvSeriesError extends PopularTvSeriesState {
  final String message;

  PopularTvSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class PopularTvSeriesLoaded extends PopularTvSeriesState {
  final List<TvSerie>? data;

  PopularTvSeriesLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

