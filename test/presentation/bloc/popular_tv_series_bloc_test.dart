import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/home/blocs/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(
    () {
      mockGetPopularTvSeries = MockGetPopularTvSeries();
      popularTvSeriesBloc = PopularTvSeriesBloc(mockGetPopularTvSeries);
    },
  );

  test(
    "if start , should be initial state",
    () {
      expect(popularTvSeriesBloc.state, PopularTvSeriesInitial());
    },
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    "Should emit [loading, error] when unsuccessful",
    build: () {
      when(mockGetPopularTvSeries.execute()).thenAnswer(
        (_) async => Left(ServerFailure("Server Failure")),
      );
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    expect: () =>
        [PopularTvSeriesLoading(), PopularTvSeriesError("Server Failure")],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    "Should emit loading, loaded when fetch successful",
    build: () {
      when(mockGetPopularTvSeries.execute()).thenAnswer(
        (_) async => Right(tTvSerieList),
      );
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    expect: () =>
        [PopularTvSeriesLoading(), PopularTvSeriesLoaded(tTvSerieList)],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );
}
