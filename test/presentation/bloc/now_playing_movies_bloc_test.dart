import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/home/blocs/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import 'now_playing_movies_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(
    () {
      mockGetNowPlayingMovies = MockGetNowPlayingMovies();
      nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
    },
  );

  test(
    "if start , should be initial state",
    () {
      expect(nowPlayingMoviesBloc.state, NowPlayingMoviesInitial());
    },
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    "Should emit [loading, error] when unsuccessful",
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
        (_) async => Left(ServerFailure("Server Failure")),
      );
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    expect: () =>
        [NowPlayingMoviesLoading(), NowPlayingMoviesError("Server Failure")],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    "Should emit loading, loaded when fetch successful",
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    expect: () =>
        [NowPlayingMoviesLoading(), NowPlayingMoviesLoaded(tMovieList)],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
