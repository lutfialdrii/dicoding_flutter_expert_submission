import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/usecases/get_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlist getWatchlist;

  WatchlistBloc(this.getWatchlist) : super(WatchListInitial()) {
    on<FetchWatchlist>(
      (event, emit) async {
        emit(WatchListLoading());
        final result = await getWatchlist.execute();

        result.fold(
          (l) {
            emit(WatchListError(l.message));
          },
          (r) {
            emit(WatchListLoaded(r));
          },
        );
      },
    );
  }
}
