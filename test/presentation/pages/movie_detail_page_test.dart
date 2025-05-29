import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/movie_detail/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

void main() {
  late MockMovieDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockMovieDetailBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<MovieDetailBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  testWidgets('Menampilkan CircularProgressIndicator saat loading',
      (tester) async {
    when(() => mockBloc.state).thenReturn(MovieDetailState());

    await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
  testWidgets('Menampilkan DetailContent saat data loaded', (tester) async {
    when(() => mockBloc.state).thenReturn(
      MovieDetailState().copyWith(
        movieState: RequestState.Loaded,
        recommendationState: RequestState.Loaded,
        movieDetail: tMovieDetail,
        recommendation: tMovieList,
        isAddedToWatchlist: false,
      ),
    );

    await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

    // Cek judul film
    expect(find.text(tMovieDetail.title), findsOneWidget);

    // Cek tombol watchlist
    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Menampilkan pesan error saat error', (tester) async {
    when(() => mockBloc.state).thenReturn(
      MovieDetailState().copyWith(
        movieState: RequestState.Error,
        message: 'Error',
      ),
    );

    await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

    expect(
        find.text("Terjadi kesalahan saat mengambil data :("), findsOneWidget);
  });
}
