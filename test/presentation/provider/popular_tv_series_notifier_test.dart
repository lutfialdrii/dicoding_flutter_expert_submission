// import 'package:dartz/dartz.dart';
// import 'package:ditonton/common/failure.dart';
// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/domain/entities/tv_serie.dart';
// import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
// import 'package:ditonton/presentation/provider/popular_tv_series_notifier.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'popular_tv_series_notifier_test.mocks.dart';

// @GenerateMocks([GetPopularTvSeries])
// void main() {
//   late MockGetPopularTvSeries mockGetPopularTvSeries;
//   late PopularTvSeriesNotifier notifier;
//   late int listenerCallCount;

//   setUp(() {
//     listenerCallCount = 0;
//     mockGetPopularTvSeries = MockGetPopularTvSeries();
//     notifier = PopularTvSeriesNotifier(mockGetPopularTvSeries)
//       ..addListener(() {
//         listenerCallCount++;
//       });
//   });


//   test('should change state to loading when usecase is called', () async {
//     // arrange
//     when(mockGetPopularTvSeries.execute())
//         .thenAnswer((_) async => Right(tTvSerieList));
//     // act
//     notifier.fetchPopularTvSeries();
//     // assert
//     expect(notifier.state, RequestState.Loading);
//     expect(listenerCallCount, 1);
//   });

//   test('should change TvSeries data when data is gotten successfully',
//       () async {
//     // arrange
//     when(mockGetPopularTvSeries.execute())
//         .thenAnswer((_) async => Right(tTvSerieList));
//     // act
//     await notifier.fetchPopularTvSeries();
//     // assert
//     expect(notifier.state, RequestState.Loaded);
//     expect(notifier.tvSeries, tTvSerieList);
//     expect(listenerCallCount, 2);
//   });

//   test('should return error when data is unsuccessful', () async {
//     // arrange
//     when(mockGetPopularTvSeries.execute())
//         .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
//     // act
//     await notifier.fetchPopularTvSeries();
//     // assert
//     expect(notifier.state, RequestState.Error);
//     expect(notifier.message, 'Server Failure');
//     expect(listenerCallCount, 2);
//   });
// }
