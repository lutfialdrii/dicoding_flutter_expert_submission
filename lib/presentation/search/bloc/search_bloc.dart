import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_serie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;
  final SearchTvSeries searchTvSeries;

  SearchBloc(this.searchMovies, this.searchTvSeries) : super(SearchInitial()) {
    on<onQueryMovieChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await searchMovies.execute(query);

      result.fold(
        (l) {
          emit(SearchError(l.message));
        },
        (r) {
          emit(SearchMovieLoaded(r));
        },
      );
    }, transformer: debounce(Duration(milliseconds: 500)));

    on<onQueryTvSerieChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await searchTvSeries.execute(query);

      result.fold(
        (l) {
          emit(SearchError(l.message));
        },
        (r) {
          emit(SearchTvSerieLoaded(r));
        },
      );
    }, transformer: debounce(Duration(milliseconds: 500)));
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
