part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchNowPlayingMovies extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class FetchPopularMovies extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class FetchTopRatedMovies extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class FetchOnAirTvSeries extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class FetchPopularTvSeries extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class FetchTopRatedTvSeries extends HomeEvent {
  @override
  List<Object?> get props => [];
}
