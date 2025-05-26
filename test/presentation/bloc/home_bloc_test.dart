import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_onair_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'home_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetPopularTvSeries,
  GetTopRatedTvSeries,
  GetOnairTvSeries
])
void main() {
  late HomeBloc homeBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetOnairTvSeries mockGetOnairTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(
    () {
      mockGetNowPlayingMovies = MockGetNowPlayingMovies();
      mockGetPopularMovies = MockGetPopularMovies();
      mockGetTopRatedMovies = MockGetTopRatedMovies();
      mockGetOnairTvSeries = MockGetOnairTvSeries();
      mockGetPopularTvSeries = MockGetPopularTvSeries();
      mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();

      homeBloc = HomeBloc(
        mockGetNowPlayingMovies,
        mockGetPopularMovies,
        mockGetTopRatedMovies,
        mockGetOnairTvSeries,
        mockGetPopularTvSeries,
        mockGetTopRatedTvSeries,
      );
    },
  );

  test(
    "should be initial state",
    () {
      expect(homeBloc.state, HomeInitial());
    },
  );
}
