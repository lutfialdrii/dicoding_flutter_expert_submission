// import 'package:dartz/dartz.dart';
// import 'package:ditonton/domain/usecases/get_watchlist.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// import '../../dummy_data/dummy_objects.dart';
// import '../../helpers/test_helper.mocks.dart';

// void main() {
//   late GetWatchlist usecase;
//   late MockMovieRepository mockMovieRepository;

//   setUp(() {
//     mockMovieRepository = MockMovieRepository();
//     usecase = GetWatchlist(mockMovieRepository);
//   });

//   test('should get list of movies from the repository', () async {
//     // arrange
//     when(mockMovieRepository.getWatchlistMovies())
//         .thenAnswer((_) async => Right(testMovieList));
//     // act
//     final result = await usecase.execute();
//     // assert
//     expect(result, Right(testMovieList));
//   });
// }
