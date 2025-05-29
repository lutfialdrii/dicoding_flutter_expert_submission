// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchMovieLoaded extends SearchState {
  final List<Movie> result;

  SearchMovieLoaded(this.result);
  @override
  List<Object?> get props => [result];
}

class SearchTvSerieLoaded extends SearchState {
  final List<TvSerie> result;

  SearchTvSerieLoaded(this.result);
  @override
  List<Object?> get props => [result];
}

class SearchError extends SearchState {
  final String message;

  SearchError(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}
