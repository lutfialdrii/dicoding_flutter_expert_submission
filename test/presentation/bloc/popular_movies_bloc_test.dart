import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/home/blocs/popular_movies/popular_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(
    () {
      mockGetPopularMovies = MockGetPopularMovies();
      popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
    },
  );

  test(
    "if start , should be initial state",
    () {
      expect(popularMoviesBloc.state, PopularMoviesInitial());
    },
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    "Should emit [loading, error] when unsuccessful",
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer(
        (_) async => Left(ServerFailure("Server Failure")),
      );
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () =>
        [PopularMoviesLoading(), PopularMoviesError("Server Failure")],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    "Should emit loading, loaded when fetch successful",
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [PopularMoviesLoading(), PopularMoviesLoaded(tMovieList)],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
