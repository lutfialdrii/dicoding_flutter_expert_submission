import 'package:ditonton/presentation/home/blocs/popular_movies/popular_movies_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularMoviesBloc>().add(FetchPopularMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<PopularMoviesBloc, PopularMoviesState>(
          builder: (context, state) {
            if (state is PopularMoviesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PopularMoviesLoaded) {
              if (state.data?.isEmpty ?? true) {
                return Center(
                  child: Text("Data tidak tersedia :("),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.data![index];
                  return MovieCard(movie);
                },
                itemCount: state.data!.length,
              );
            } else if (state is PopularMoviesError) {
              return Center(
                child: Text("Terjadi kesalahan saat mengambil data :("),
              );
            } else {
              return Container();
            }
          },
          listener: (context, state) {
            if (state is PopularMoviesError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Terjadi kesalahan saat mengambil data :( ${state.message}")));
            }
          },
        ),
      ),
    );
  }
}
