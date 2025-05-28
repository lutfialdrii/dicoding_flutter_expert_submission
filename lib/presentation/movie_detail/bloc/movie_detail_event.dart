part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchMovieDetail extends MovieDetailEvent {
  final int id;

  FetchMovieDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class AddMovieToWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  AddMovieToWatchlist(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class RemoveMovieWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  RemoveMovieWatchlist(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class LoadWatchListStatus extends MovieDetailEvent {
  final int id;

  LoadWatchListStatus(this.id);

  @override
  List<Object?> get props => [id];
}
