import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:ditonton/presentation/search/bloc/search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
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
