// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

class MoviesLoaded extends HomeState {
  final List<Movie>? nowPlayingMovies;
  final List<Movie>? popularMovies;
  final List<Movie>? topRatedMovies;

  MoviesLoaded(this.nowPlayingMovies, this.popularMovies, this.topRatedMovies);

  MoviesLoaded copyWith({
    List<Movie>? nowPlayingMovies,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
  }) {
    return MoviesLoaded(
      nowPlayingMovies ?? this.nowPlayingMovies,
      popularMovies ?? this.popularMovies,
      topRatedMovies ?? this.topRatedMovies,
    );
  }

  @override
  List<Object?> get props => [nowPlayingMovies, popularMovies, topRatedMovies];
}

class TvSeriesLoaded extends HomeState {
  final List<TvSerie>? onAirTvSeries;
  final List<TvSerie>? popularTvSeries;
  final List<TvSerie>? topRatedTvSeries;

  TvSeriesLoaded(
      this.onAirTvSeries, this.popularTvSeries, this.topRatedTvSeries);

  TvSeriesLoaded copyWith({
    List<TvSerie>? onAirTvSeries,
    List<TvSerie>? popularTvSeries,
    List<TvSerie>? topRatedTvSeries,
  }) {
    return TvSeriesLoaded(
      onAirTvSeries ?? this.onAirTvSeries,
      popularTvSeries ?? this.popularTvSeries,
      topRatedTvSeries ?? this.topRatedTvSeries,
    );
  }

  @override
  List<Object?> get props => [onAirTvSeries, popularTvSeries, topRatedTvSeries];
}
