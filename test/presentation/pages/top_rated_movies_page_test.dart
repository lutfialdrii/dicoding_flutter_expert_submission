import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/home/blocs/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/home/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedMoviesBloc extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

void main() {
  late MockTopRatedMoviesBloc mockBloc;

  setUp(() {
    mockBloc = MockTopRatedMoviesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<TopRatedMoviesBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  testWidgets('Menampilkan CircularProgressIndicator saat loading', (tester) async {
    when(() => mockBloc.state).thenReturn(TopRatedMoviesLoading());

    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Menampilkan ListView saat data tersedia', (tester) async {
    final movies = [testMovie];
    when(() => mockBloc.state).thenReturn(TopRatedMoviesLoaded(movies));

    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('Menampilkan pesan jika data kosong', (tester) async {
    when(() => mockBloc.state).thenReturn(TopRatedMoviesLoaded([]));

    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

    expect(find.text("Data tidak tersedia :("), findsOneWidget);
  });

  testWidgets('Menampilkan pesan error saat error', (tester) async {
    when(() => mockBloc.state).thenReturn(TopRatedMoviesError('Error'));

    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

    expect(find.text("Terjadi kesalahan saat mengambil data :("), findsOneWidget);
  });
}