import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/home/blocs/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(
    () {
      mockGetTopRatedMovies = MockGetTopRatedMovies();
      topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
    },
  );

  test(
    "Initial state should be initial",
    () {
      expect(topRatedMoviesBloc.state, TopRatedMoviesInitial());
    },
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    "Should emit loading, error when fetch movies error",
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer(
        (_) async => Left(ServerFailure("Server Failure")),
      );
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    expect: () =>
        [TopRatedMoviesLoading(), TopRatedMoviesError("Server Failure")],
    verify: (bloc) => verify(mockGetTopRatedMovies.execute()),
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    "Should emit loading, loaded when fetch movies successful",
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    expect: () => [TopRatedMoviesLoading(), TopRatedMoviesLoaded(tMovieList)],
    verify: (bloc) => verify(mockGetTopRatedMovies.execute()),
  );
}
