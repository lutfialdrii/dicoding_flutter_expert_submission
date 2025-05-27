import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc(this.getTopRatedMovies) : super(TopRatedMoviesInitial()) {
    on<FetchTopRatedMovies>(
      (event, emit) async {
        emit(TopRatedMoviesLoading());

        final result = await getTopRatedMovies.execute();
        result.fold(
          (l) {
            emit(TopRatedMoviesError(l.message));
          },
          (r) {
            emit(TopRatedMoviesLoaded(r));
          },
        );
      },
    );
  }
}
