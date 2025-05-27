part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NowPlayingMoviesInitial extends NowPlayingMoviesState {
  @override
  List<Object?> get props => [];
}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {
  @override
  List<Object?> get props => [];
}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;

  NowPlayingMoviesError(this.message);
  @override
  List<Object?> get props => [message];
}

class NowPlayingMoviesLoaded extends NowPlayingMoviesState {
  final List<Movie>? data;

  NowPlayingMoviesLoaded(this.data);

  @override
  List<Object?> get props => [data];
}
