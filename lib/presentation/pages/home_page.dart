import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_serie.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/home_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

enum HomeType { movie, tvSerie }

class _HomePageState extends State<HomePage> {
  HomeType type = HomeType.movie;

  @override
  void initState() {
    super.initState();

    Future.microtask(() => fetchMovies());
  }

  Future fetchMovies() async {
    return Provider.of<HomeNotifier>(context, listen: false)
      ..fetchNowPlayingMovies()
      ..fetchPopularMovies()
      ..fetchTopRatedMovies();
  }

  Future fetchTVSeries() async {
    return Provider.of<HomeNotifier>(context, listen: false)
      ..fetchOnAirTvSeries()
      ..fetchPopularTvSeries()
      ..fetchTopRatedTvSeries();
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

                if (type != HomeType.movie) {
                  Provider.of<HomeNotifier>(context, listen: false).reset();
                  Future.microtask(() => fetchMovies());
                }
                type = HomeType.movie;
                setState(() {});
              },
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('TV Series'),
              onTap: () {
                Navigator.pop(context);

                if (type != HomeType.tvSerie) {
                  Provider.of<HomeNotifier>(context, listen: false).reset();
                  Future.microtask(() => fetchTVSeries());
                }
                type = HomeType.tvSerie;
                setState(() {});
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
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
        title: Text(type == HomeType.movie ? "Movies" : "TV Series"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: type == HomeType.movie
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
        Consumer<HomeNotifier>(builder: (context, data, child) {
          final state = data.nowPlayingMoviesState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return ContentList(
              type: HomeType.movie,
              movies: data.nowPlayingMovies,
            );
          } else {
            return Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'Popular',
          onTap: () =>
              Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
        ),
        Consumer<HomeNotifier>(builder: (context, data, child) {
          final state = data.popularMoviesState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return ContentList(
              type: HomeType.movie,
              movies: data.popularMovies,
            );
          } else {
            return Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'Top Rated',
          onTap: () =>
              Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
        ),
        Consumer<HomeNotifier>(builder: (context, data, child) {
          final state = data.topRatedMoviesState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return ContentList(
              type: HomeType.movie,
              movies: data.topRatedMovies,
            );
          } else {
            return Text('Failed');
          }
        }),
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
        Consumer<HomeNotifier>(builder: (context, data, child) {
          final state = data.onAirTvSeriesState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return ContentList(
              type: HomeType.tvSerie,
              tvSeries: data.onAirTvSeries,
            );
          } else {
            return Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'Popular',
          onTap: () =>
              // TODO : CHANGE
              Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
        ),
        Consumer<HomeNotifier>(builder: (context, data, child) {
          final state = data.popularTvSeriesState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return ContentList(
              type: HomeType.tvSerie,
              tvSeries: data.popularTvSeries,
            );
          } else {
            return Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'Top Rated',
          onTap: () =>
              // TODO : CHANGE

              Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
        ),
        Consumer<HomeNotifier>(builder: (context, data, child) {
          final state = data.topRatedTvSeriesState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return ContentList(
              type: HomeType.tvSerie,
              tvSeries: data.topRatedTvSeries,
            );
          } else {
            return Text('Failed');
          }
        }),
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
  final HomeType type;
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
      child: type == HomeType.movie ? _buildMoviesList() : _buildTvSeriesList(),
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
                MovieDetailPage.ROUTE_NAME,
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
