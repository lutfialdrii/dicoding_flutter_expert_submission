import 'package:ditonton/common/ssl_pinning_client.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/tv_serie_remote_data_source.dart';
import 'package:ditonton/data/datasources/watchlist_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_serie_repository.dart';
import 'package:ditonton/domain/repositories/watchlist_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  TvSerieRepository,
  TvSerieRemoteDataSource,
  WatchlistRepository,
  WatchlistLocalDataSource,
  DatabaseHelper,
  SSLPinningClient
])
void main() {}
