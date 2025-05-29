import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/watchlist/bloc/watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/poster_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WatchlistBloc>().add(FetchWatchlist()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistBloc>().add(FetchWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<WatchlistBloc, WatchlistState>(
              builder: (context, state) {
            if (state is WatchListLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchListLoaded) {
              if (state.data?.isEmpty ?? true) {
                return Center(
                  child: Text("Anda belum menambahkan watchlist!"),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final watchlist = state.data![index];

                  return PosterCard(watchlist);
                },
                itemCount: state.data!.length,
              );
            } else if (state is WatchListError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text("Terjadi Kesalahan :("),
              );
            }
          })),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
