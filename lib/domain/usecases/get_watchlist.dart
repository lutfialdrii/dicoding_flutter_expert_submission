import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/watchlist.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/watchlist_repository.dart';

class GetWatchlist {
  final WatchlistRepository _repository;

  GetWatchlist(this._repository);

  Future<Either<Failure, List<Watchlist>>> execute() {
    return _repository.getWatchlist();
  }
}
