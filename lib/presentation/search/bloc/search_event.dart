part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class onQueryMovieChanged extends SearchEvent {
  final String query;

  onQueryMovieChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class onQueryTvSerieChanged extends SearchEvent {
  final String query;

  onQueryTvSerieChanged(this.query);

  @override
  List<Object?> get props => [query];
}
