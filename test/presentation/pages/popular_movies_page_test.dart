import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/home/blocs/popular_movies/popular_movies_bloc.dart';
import 'package:ditonton/presentation/home/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularMoviesBloc extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

void main() {
  late MockPopularMoviesBloc mockBloc;

  setUp(() {
    mockBloc = MockPopularMoviesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<PopularMoviesBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  testWidgets('Menampilkan CircularProgressIndicator saat loading', (tester) async {
    when(() => mockBloc.state).thenReturn(PopularMoviesLoading());

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Menampilkan ListView saat data tersedia', (tester) async {
    final movies = [testMovie];
    when(() => mockBloc.state).thenReturn(PopularMoviesLoaded(movies));

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('Menampilkan pesan jika data kosong', (tester) async {
    when(() => mockBloc.state).thenReturn(PopularMoviesLoaded([]));

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(find.text("Data tidak tersedia :("), findsOneWidget);
  });

  testWidgets('Menampilkan pesan error saat error', (tester) async {
    when(() => mockBloc.state).thenReturn(PopularMoviesError('Error'));

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(find.text("Terjadi kesalahan saat mengambil data :("), findsOneWidget);
  });
}