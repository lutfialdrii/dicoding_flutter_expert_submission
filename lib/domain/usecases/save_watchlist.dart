import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/watchlist.dart';
import 'package:ditonton/domain/repositories/watchlist_repository.dart';

class SaveWatchlist {
  final WatchlistRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(Watchlist watchlist) {
    return repository.saveWatchlist(watchlist);
  }
}
