import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_onair_tv_series.dart';
import 'package:ditonton/presentation/home/blocs/onair_tv_series/onair_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'onair_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetOnairTvSeries])
void main() {
  late OnairTvSeriesBloc onairTvSeriesBloc;
  late MockGetOnairTvSeries mockGetOnairTvSeries;

  setUp(
    () {
      mockGetOnairTvSeries = MockGetOnairTvSeries();
      onairTvSeriesBloc = OnairTvSeriesBloc(mockGetOnairTvSeries);
    },
  );

  test(
    "if start , should be initial state",
    () {
      expect(onairTvSeriesBloc.state, OnairTvSeriesInitial());
    },
  );

  blocTest<OnairTvSeriesBloc, OnairTvSeriesState>(
    "Should emit [loading, error] when unsuccessful",
    build: () {
      when(mockGetOnairTvSeries.execute()).thenAnswer(
        (_) async => Left(ServerFailure("Server Failure")),
      );
      return onairTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchOnairTvSeries()),
    expect: () =>
        [OnairTvSeriesLoading(), OnairTvSeriesError("Server Failure")],
    verify: (bloc) {
      verify(mockGetOnairTvSeries.execute());
    },
  );

  blocTest<OnairTvSeriesBloc, OnairTvSeriesState>(
    "Should emit loading, loaded when fetch successful",
    build: () {
      when(mockGetOnairTvSeries.execute()).thenAnswer(
        (_) async => Right(tTvSerieList),
      );
      return onairTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchOnairTvSeries()),
    expect: () => [OnairTvSeriesLoading(), OnAirTvSeriesLoaded(tTvSerieList)],
    verify: (bloc) {
      verify(mockGetOnairTvSeries.execute());
    },
  );
}
