import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/card_list.dart';
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
    Future.microtask(() => {
      context.read<WatchlistMovieBloc>().add(LoadAllWatchlistMovie()),
      context.read<WatchlistTvBloc>().add(LoadAllWatchlistTv())
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(LoadAllWatchlistMovie());
    context.read<WatchlistTvBloc>().add(LoadAllWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
                  builder: (context, state) {
                    if (state is WatchlistMovieLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is WatchlistMovieLoaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final movie = state.result[index];
                          return CardList(
                            dataList: movie,
                          );
                        },
                        itemCount: state.result.length,
                      );
                    } else {
                      return Center(
                        child: Column(
                          children: [
                            Text('Data Movie Watchlist Kosong'),
                            SizedBox(height: 16),
                          ],
                        ),
                      );
                    }
                  },
                ),

                BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
                  builder: (context, state) {
                    if (state is WatchlistTvLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is WatchlistTvLoaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = state.result[index];
                          return CardList(
                            dataList: data,
                            isTv: true,
                          );
                        },
                        itemCount: state.result.length,
                      );
                    } else {
                      return Center(
                        child: Text('Data TV Watchlist Kosong'),
                      );
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
