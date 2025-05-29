import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_serie.dart';
import 'package:ditonton/domain/usecases/get_onair_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'onair_tv_series_event.dart';
part 'onair_tv_series_state.dart';

class OnairTvSeriesBloc extends Bloc<OnairTvSeriesEvent, OnairTvSeriesState> {
  final GetOnairTvSeries getOnairTvSeries;

  OnairTvSeriesBloc(this.getOnairTvSeries) : super(OnairTvSeriesInitial()) {
    on<FetchOnairTvSeries>(
      (event, emit) async {
        emit(OnairTvSeriesLoading());
        final result = await getOnairTvSeries.execute();
        result.fold(
          (l) {
            emit(OnairTvSeriesError(l.message));
          },
          (r) {
            emit(OnAirTvSeriesLoaded(r));
          },
        );
      },
    );
  }
}
