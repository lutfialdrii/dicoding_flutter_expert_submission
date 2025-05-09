// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ditonton/domain/entities/tv_serie.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_serie_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_serie_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_serie_recommendations.dart';

class TvSerieDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSerieDetail getTvSerieDetail;
  final GetTvSerieRecommendations getTvSerieRecommendations;
  final SaveWatchlist saveWatchlist;
  final GetWatchListStatus getWatchListStatus;
  final RemoveWatchlist removeWatchlist;

  TvSerieDetailNotifier({
    required this.getTvSerieDetail,
    required this.getTvSerieRecommendations,
    required this.saveWatchlist,
    required this.getWatchListStatus,
    required this.removeWatchlist,
  });

  late TvSerieDetail _tvSerie;
  TvSerieDetail get tvSerie => _tvSerie;

  RequestState _tvSerieState = RequestState.Empty;
  RequestState get tvSerieState => _tvSerieState;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  List<TvSerie> _tvRecommendations = [];
  List<TvSerie> get tvRecommendations => _tvRecommendations;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchDetail(int id) async {
    _tvSerieState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSerieDetail.execute(id);
    final recommendationResult = await getTvSerieRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvSerieState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSerie) {
        _recommendationState = RequestState.Loading;
        _tvSerie = tvSerie;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (data) {
            _recommendationState = RequestState.Loaded;
            _tvRecommendations = data;
          },
        );
        _tvSerieState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvSerieDetail data) async {
    final result =
        await saveWatchlist.execute(Watchlist.fromTvSerieDetailEntity(data));

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSerie.id!);
  }

  Future<void> removeFromWatchlist(TvSerieDetail data) async {
    final result =
        await removeWatchlist.execute(Watchlist.fromTvSerieDetailEntity(data));

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(data.id!);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
