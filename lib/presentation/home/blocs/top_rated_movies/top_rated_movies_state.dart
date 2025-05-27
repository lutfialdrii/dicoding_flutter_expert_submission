part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TopRatedMoviesInitial extends TopRatedMoviesState {
  @override
  List<Object?> get props => [];
}

class TopRatedMoviesLoading extends TopRatedMoviesState {
  @override
  List<Object?> get props => [];
}

class TopRatedMoviesError extends TopRatedMoviesState {
  final String message;

  TopRatedMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}

class TopRatedMoviesLoaded extends TopRatedMoviesState {
  final List<Movie>? data;

  TopRatedMoviesLoaded(this.data);

  @override
  List<Object?> get props => [data];
}
