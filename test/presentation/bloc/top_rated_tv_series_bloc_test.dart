import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/home/blocs/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(
    () {
      mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
      topRatedTvSeriesBloc = TopRatedTvSeriesBloc(mockGetTopRatedTvSeries);
    },
  );

  test(
    "Initial state should be initial",
    () {
      expect(topRatedTvSeriesBloc.state, TopRatedTvSeriesInitial());
    },
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    "Should emit loading, error when fetch movies error",
    build: () {
      when(mockGetTopRatedTvSeries.execute()).thenAnswer(
        (_) async => Left(ServerFailure("Server Failure")),
      );
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
    expect: () =>
        [TopRatedTvSeriesLoading(), TopRatedTvSeriesError("Server Failure")],
    verify: (bloc) => verify(mockGetTopRatedTvSeries.execute()),
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    "Should emit loading, loaded when fetch movies successful",
    build: () {
      when(mockGetTopRatedTvSeries.execute()).thenAnswer(
        (_) async => Right(tTvSerieList),
      );
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
    expect: () =>
        [TopRatedTvSeriesLoading(), TopRatedTvSeriesLoaded(tTvSerieList)],
    verify: (bloc) => verify(mockGetTopRatedTvSeries.execute()),
  );
}
