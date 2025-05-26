import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_serie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:ditonton/presentation/search/bloc/search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTvSeries])
void main() {
  late SearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(
    () {
      mockSearchMovies = MockSearchMovies();
      mockSearchTvSeries = MockSearchTvSeries();
      searchBloc = SearchBloc(mockSearchMovies, mockSearchTvSeries);
    },
  );

  test(
    "Initial state should be initial",
    () {
      expect(searchBloc.state, SearchInitial());
    },
  );

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  final tTvSerieModel = TvSerie(
    adult: false,
    backdropPath: '/anu.jpg',
    genreIds: [0],
    id: 0,
    name: 'Anu',
    overview: '',
    popularity: 0,
    posterPath: '',
    firstAirDate: DateTime.now(),
    originalName: 'Anu',
    voteAverage: 0,
    voteCount: 0,
    originCountry: [],
    originalLanguage: '',
  );
  final tTvSerieList = <TvSerie>[tTvSerieModel];

  final tQuery = 'spiderman';

  blocTest<SearchBloc, SearchState>(
    "Should emit loading, error when get search unsuccessful",
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      return searchBloc;
    },
    act: (bloc) => bloc.add(onQueryMovieChanged(tQuery)),
    expect: () => [
      SearchLoading(),
      SearchError(
        "Server Failure",
      )
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<SearchBloc, SearchState>(
    "Should emit loading, loaded when get search movie successfull",
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(onQueryMovieChanged(tQuery)),
    expect: () => [SearchLoading(), SearchMovieLoaded(tMovieList)],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
  blocTest<SearchBloc, SearchState>(
    "Should emit loading, loaded when get search tvSerie successfull",
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSerieList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(onQueryTvSerieChanged(tQuery)),
    expect: () => [SearchLoading(), SearchTvSerieLoaded(tTvSerieList)],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );
}
