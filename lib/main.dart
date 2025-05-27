import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/home/blocs/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/home/blocs/onair_tv_series/onair_tv_series_bloc.dart';
import 'package:ditonton/presentation/home/blocs/popular_movies/popular_movies_bloc.dart';
import 'package:ditonton/presentation/home/blocs/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/home/blocs/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/home/blocs/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/search/bloc/search_bloc.dart';
import 'package:ditonton/presentation/about/about_page.dart';
import 'package:ditonton/presentation/movie_detail/movie_detail_page.dart';
import 'package:ditonton/presentation/home/home_page.dart';
import 'package:ditonton/presentation/popular_movies/popular_movies_page.dart';
import 'package:ditonton/presentation/popular_tv_series/popular_tv_series_page.dart';
import 'package:ditonton/presentation/search/search_page.dart';
import 'package:ditonton/presentation/top_rated_movies/top_rated_movies_page.dart';
import 'package:ditonton/presentation/top_rated_tv_series/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/tv_serie_detail/tv_serie_detail_page.dart';
import 'package:ditonton/presentation/watchlist/watchlist_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/popular_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv_serie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<OnairTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedTvSeriesBloc>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSerieDetailNotifier>(),
        ),
        BlocProvider(create: (context) => di.locator<SearchBloc>()),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          drawerTheme: kDrawerTheme,
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case PopularTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case TvSerieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => TvSerieDetailPage(id: id),
                  settings: settings);
            case SearchPage.ROUTE_NAME:
              final type = settings.arguments as Category;
              return CupertinoPageRoute(
                  builder: (_) => SearchPage(category: type));
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
