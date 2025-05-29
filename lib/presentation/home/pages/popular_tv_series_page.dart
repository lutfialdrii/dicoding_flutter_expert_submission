import 'package:ditonton/presentation/home/blocs/popular_tv_series/popular_tv_series_bloc.dart';

import 'package:ditonton/presentation/widgets/tv_serie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';

  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularTvSeriesBloc>().add(FetchPopularTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<PopularTvSeriesBloc, PopularTvSeriesState>(
          builder: (context, state) {
            if (state is PopularTvSeriesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PopularTvSeriesLoaded) {
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
            } else if (state is PopularTvSeriesError) {
              return Center(
                child: Text("Terjadi kesalahan saat mengambil data :("),
              );
            } else {
              return Container();
            }
          },
          listener: (context, state) {
            if (state is PopularTvSeriesError) {
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
