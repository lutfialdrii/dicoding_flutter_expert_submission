import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/watchlist.dart';

abstract class WatchlistLocalDataSource {
  Future<String> insertWatchlist(Watchlist movie);
  Future<String> removeWatchlist(Watchlist movie);
  Future<Watchlist?> getMovieById(int id);
  Future<List<Watchlist>> getWatchlist();
}

class WatchlistLocalDataSourceImpl implements WatchlistLocalDataSource {
  final DatabaseHelper databaseHelper;

  WatchlistLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(Watchlist movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(Watchlist movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<Watchlist?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return Watchlist.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<Watchlist>> getWatchlist() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => Watchlist.fromMap(data)).toList();
  }
}
