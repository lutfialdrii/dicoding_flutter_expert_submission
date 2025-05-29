part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WatchListInitial extends WatchlistState {
  @override
  List<Object?> get props => [];
}

class WatchListLoading extends WatchlistState {
  @override
  List<Object?> get props => [];
}

class WatchListError extends WatchlistState {
  final String message;

  WatchListError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchListLoaded extends WatchlistState {
  final List<Watchlist>? data;

  WatchListLoaded(this.data);

  @override
  List<Object?> get props => [data];
}
