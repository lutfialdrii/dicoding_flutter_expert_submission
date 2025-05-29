import 'package:ditonton/presentation/home/blocs/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TopRatedMoviesBloc>().add(FetchTopRatedMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<TopRatedMoviesBloc, TopRatedMoviesState>(
          builder: (context, state) {
            if (state is TopRatedMoviesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TopRatedMoviesLoaded) {
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
            } else if (state is TopRatedMoviesError) {
              return Center(
                child: Text("Terjadi kesalahan saat mengambil data :("),
              );
            } else {
              return Container();
            }
          },
          listener: (context, state) {
            if (state is TopRatedMoviesError) {
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
