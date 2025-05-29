import 'package:ditonton/presentation/home/blocs/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_serie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';

  @override
  _TopRatedTvSeriesPageState createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TopRatedTvSeriesBloc>().add(FetchTopRatedTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
          builder: (context, state) {
            if (state is TopRatedTvSeriesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TopRatedTvSeriesLoaded) {
              if (state.data?.isEmpty ?? true) {
                return Center(
                  child: Text("Data tidak tersedia :("),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSerie = state.data![index];
                  return TvSerieCard(tvSerie);
                },
                itemCount: state.data!.length,
              );
            } else if (state is TopRatedTvSeriesError) {
              return Center(
                child: Text("Terjadi kesalahan saat mengambil data :("),
              );
            } else {
              return Container();
            }
          },
          listener: (context, state) {
            if (state is TopRatedTvSeriesError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Terjadi kesalahan saat mengambil data :( ${state.message}")));
            }
          },
        ),
      ),
    );
  }
}
