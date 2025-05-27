import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_serie.dart';
import 'package:ditonton/presentation/about/about_page.dart';
import 'package:ditonton/presentation/home/blocs/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/home/blocs/onair_tv_series/onair_tv_series_bloc.dart';
import 'package:ditonton/presentation/home/blocs/popular_movies/popular_movies_bloc.dart';
import 'package:ditonton/presentation/home/blocs/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/home/blocs/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/home/blocs/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/movie_detail/movie_detail_page.dart';
import 'package:ditonton/presentation/popular_movies/popular_movies_page.dart';
import 'package:ditonton/presentation/popular_tv_series/popular_tv_series_page.dart';
import 'package:ditonton/presentation/search/search_page.dart';
import 'package:ditonton/presentation/top_rated_movies/top_rated_movies_page.dart';
import 'package:ditonton/presentation/top_rated_tv_series/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/tv_serie_detail/tv_serie_detail_page.dart';
import 'package:ditonton/presentation/watchlist/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Category category = Category.movie;

  @override
  void initState() {
    super.initState();

    Future.microtask(() => fetchMovies());
  }

  Future fetchMovies() async {
    context.read<NowPlayingMoviesBloc>().add(FetchNowPlayingMovies());
    context.read<PopularMoviesBloc>().add(FetchPopularMovies());
    context.read<TopRatedMoviesBloc>().add(FetchTopRatedMovies());
  }

  Future fetchTVSeries() async {
    context.read<OnairTvSeriesBloc>().add(FetchOnairTvSeries());
    context.read<PopularTvSeriesBloc>().add(FetchPopularTvSeries());
    context.read<TopRatedTvSeriesBloc>().add(FetchTopRatedTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
                backgroundColor: Colors.grey.shade900,
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);

                if (category != Category.movie) {
                  Future.microtask(() => fetchMovies());
                }
                category = Category.movie;
                setState(() {});
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV Series'),
              onTap: () {
                Navigator.pop(context);

                if (category != Category.tvSerie) {
                  Future.microtask(() => fetchTVSeries());
                }
                category = Category.tvSerie;
                setState(() {});
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(category == Category.movie ? "Movies" : "TV Series"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME,
                  arguments: category);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: category == Category.movie
                ? _buildMoviesContent(context)
                : _buildTvSeriesContent(context)),
      ),
    );
  }

  Column _buildMoviesContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Now Playing',
          style: kHeading6,
        ),
        BlocConsumer<NowPlayingMoviesBloc, NowPlayingMoviesState>(
          builder: (context, state) {
            if (state is NowPlayingMoviesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NowPlayingMoviesLoaded) {
              return ContentList(
                type: Category.movie,
                movies: state.data,
              );
            } else if (state is NowPlayingMoviesError) {
              return Center(
                child: Text("Terjadi kesalahan saat mengambil data :("),
              );
            } else {
              return Container();
            }
          },
          listener: (context, state) {
            if (state is NowPlayingMoviesError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Terjadi kesalahan saat mengambil data :( ${state.message}")));
            }
          },
        ),
        _buildSubHeading(
          title: 'Popular',
          onTap: () =>
              Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
        ),
        BlocConsumer<PopularMoviesBloc, PopularMoviesState>(
          builder: (context, state) {
            if (state is PopularMoviesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PopularMoviesLoaded) {
              return ContentList(
                type: Category.movie,
                movies: state.data,
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
        _buildSubHeading(
          title: 'Top Rated',
          onTap: () =>
              Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
        ),
        BlocConsumer<TopRatedMoviesBloc, TopRatedMoviesState>(
          builder: (context, state) {
            if (state is TopRatedMoviesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TopRatedMoviesLoaded) {
              return ContentList(
                type: Category.movie,
                movies: state.data,
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
      ],
    );
  }

  Column _buildTvSeriesContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'On Air',
          style: kHeading6,
        ),
        BlocConsumer<OnairTvSeriesBloc, OnairTvSeriesState>(
          builder: (context, state) {
            if (state is OnairTvSeriesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is OnAirTvSeriesLoaded) {
              return ContentList(
                type: Category.tvSerie,
                tvSeries: state.data,
              );
            } else if (state is OnairTvSeriesError) {
              return Center(
                child: Text("Terjadi kesalahan saat mengambil data :("),
              );
            } else {
              return Container();
            }
          },
          listener: (context, state) {
            if (state is OnairTvSeriesError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Terjadi kesalahan saat mengambil data :( ${state.message}")));
            }
          },
        ),
        _buildSubHeading(
          title: 'Popular',
          onTap: () =>
              Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME),
        ),
        BlocConsumer<PopularTvSeriesBloc, PopularTvSeriesState>(
          builder: (context, state) {
            if (state is PopularTvSeriesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PopularTvSeriesLoaded) {
              return ContentList(
                type: Category.tvSerie,
                tvSeries: state.data,
              );
            } else if (state is PopularTvSeriesError) {
              return Center(
                child: Text("Terjadi kesalahan saat mengambil data :("),
              );
            } else {
              return Container();
            }
          },
          listener: (context, state) {
            if (state is PopularTvSeriesError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Terjadi kesalahan saat mengambil data :( ${state.message}")));
            }
          },
        ),
        _buildSubHeading(
          title: 'Top Rated',
          onTap: () =>
              Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME),
        ),
        BlocConsumer<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
          builder: (context, state) {
            if (state is TopRatedTvSeriesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TopRatedTvSeriesLoaded) {
              return ContentList(
                type: Category.tvSerie,
                tvSeries: state.data,
              );
            } else if (state is TopRatedTvSeriesError) {
              return Center(
                child: Text("Terjadi kesalahan saat mengambil data :("),
              );
            } else {
              return Container();
            }
          },
          listener: (context, state) {
            if (state is TopRatedTvSeriesError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Terjadi kesalahan saat mengambil data :( ${state.message}")));
            }
          },
        ),
      ],
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class ContentList extends StatelessWidget {
  final Category type;
  final List<Movie>? movies;
  final List<TvSerie>? tvSeries;

  ContentList({
    Key? key,
    required this.type,
    this.movies,
    this.tvSeries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: type == Category.movie ? _buildMoviesList() : _buildTvSeriesList(),
    );
  }

  ListView _buildMoviesList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final movie = movies![index];
        return Container(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                MovieDetailPage.ROUTE_NAME,
                arguments: movie.id,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        );
      },
      itemCount: movies!.length,
    );
  }

  ListView _buildTvSeriesList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final tvSerie = tvSeries![index];
        return Container(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                TvSerieDetailPage.ROUTE_NAME,
                arguments: tvSerie.id,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: '$BASE_IMAGE_URL${tvSerie.posterPath}',
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        );
      },
      itemCount: tvSeries!.length,
    );
  }
}
