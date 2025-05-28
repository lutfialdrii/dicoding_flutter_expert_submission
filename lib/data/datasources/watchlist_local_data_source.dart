import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/watchlist_model.dart';

abstract class WatchlistLocalDataSource {
  Future<String> insertWatchlist(WatchlistModel movie);
  Future<String> removeWatchlist(WatchlistModel movie);
  Future<WatchlistModel?> getMovieById(int id);
  Future<List<WatchlistModel>> getWatchlist();
}

class WatchlistLocalDataSourceImpl implements WatchlistLocalDataSource {
  final DatabaseHelper databaseHelper;

  WatchlistLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchlistModel movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return watchlistAddSuccessMessage;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchlistModel movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return watchlistRemoveSuccessMessage;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchlistModel?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return WatchlistModel.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchlistModel>> getWatchlist() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => WatchlistModel.fromMap(data)).toList();
  }
}
