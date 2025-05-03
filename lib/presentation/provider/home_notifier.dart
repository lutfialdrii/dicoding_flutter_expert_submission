import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_serie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_onair_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  // MOVIES
  var _nowPlayingMovies = <Movie>[];
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RequestState _nowPlayingMoviesState = RequestState.Empty;
  RequestState get nowPlayingMoviesState => _nowPlayingMoviesState;

  var _popularMovies = <Movie>[];
  List<Movie> get popularMovies => _popularMovies;

  RequestState _popularMoviesState = RequestState.Empty;
  RequestState get popularMoviesState => _popularMoviesState;

  var _topRatedMovies = <Movie>[];
  List<Movie> get topRatedMovies => _topRatedMovies;

  RequestState _topRatedMoviesState = RequestState.Empty;
  RequestState get topRatedMoviesState => _topRatedMoviesState;

  // TV SERIES
  var _onAirTvSeries = <TvSerie>[];
  List<TvSerie> get onAirTvSeries => _onAirTvSeries;

  RequestState _onAirTvSeriesState = RequestState.Empty;
  RequestState get onAirTvSeriesState => _onAirTvSeriesState;

  var _popularTvSeries = <TvSerie>[];
  List<TvSerie> get popularTvSeries => _popularTvSeries;

  RequestState _popularTvSeriesState = RequestState.Empty;
  RequestState get popularTvSeriesState => _popularTvSeriesState;

  var _topRatedTvSeries = <TvSerie>[];
  List<TvSerie> get topRatedTvSeries => _topRatedTvSeries;

  RequestState _topRatedTvSeriesState = RequestState.Empty;
  RequestState get topRatedTvSeriesState => _topRatedTvSeriesState;

// COMMONS
  String _message = '';
  String get message => _message;

  HomeNotifier({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
    required this.getOnairTvSeries,
  });

  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;
  final GetOnairTvSeries getOnairTvSeries;

// RESET STATES
  void reset() {
    _message = '';

    _nowPlayingMovies.clear();
    _nowPlayingMoviesState = RequestState.Empty;
    _popularMovies.clear();
    _popularMoviesState = RequestState.Empty;
    _topRatedMovies.clear();
    _topRatedMoviesState = RequestState.Empty;

    _onAirTvSeries.clear();
    _onAirTvSeriesState = RequestState.Empty;
    _popularTvSeries.clear();
    _popularTvSeriesState = RequestState.Empty;
    _topRatedTvSeries.clear();
    _topRatedTvSeriesState = RequestState.Empty;
  }

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        _nowPlayingMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _nowPlayingMoviesState = RequestState.Loaded;
        _nowPlayingMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    _popularMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        _popularMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularMoviesState = RequestState.Loaded;
        _popularMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    _topRatedMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        _topRatedMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedMoviesState = RequestState.Loaded;
        _topRatedMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchOnAirTvSeries() async {
    _onAirTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getOnairTvSeries.execute();
    result.fold(
      (failure) {
        _onAirTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _onAirTvSeriesState = RequestState.Loaded;
        _onAirTvSeries = data;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvSeries() async {
    _popularTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) {
        _popularTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _popularTvSeriesState = RequestState.Loaded;
        _popularTvSeries = data;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) {
        _topRatedTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _topRatedTvSeriesState = RequestState.Loaded;
        _topRatedTvSeries = data;
        notifyListeners();
      },
    );
  }
}
