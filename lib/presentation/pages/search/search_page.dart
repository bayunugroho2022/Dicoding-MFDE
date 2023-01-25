import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/movie/search/search_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/search/search_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';
  final String type;

  SearchPage({required this.type});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {


  @override
  void initState() {
    if (widget.type == 'movie') {
      context.read<SearchBloc>().add(OnQueryChangedMovie(''));
    } else if (widget.type == 'tv') {
      context.read<SearchTvBloc>().add(OnQueryChangedTv(''));
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search ${widget.type}'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onSubmitted: (query) {
              context.read<SearchBloc>().add(OnQueryChangedMovie(query));
              context.read<SearchTvBloc>().add(OnQueryChangedTv(query));
            },
            decoration: InputDecoration(
              hintText: 'Search ...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
          ),
          SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _movieSearch(context),
                  _space(),
                  _tvSearch(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _movieSearch(BuildContext context) {
    return Visibility(
      visible: widget.type == 'movie',
      child: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
        if (state is SearchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchHasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final movies = state.result;
                  return CardList(
                    dataList: movies[index],
                    isTv: false,
                  );
                },
                itemCount: state.result.length,
              ),
              SizedBox(
                height: 16,
              ),
            ],
          );
        } else if (state is SearchError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Container();
        }
      }),
    );
  }

  Widget _tvSearch(BuildContext context) {
    return Visibility(
      visible: widget.type == 'tv',
      child: BlocBuilder<SearchTvBloc, SearchTvState>(builder: (context, state) {
        if (state is SearchTvLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchTvHasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return CardList(
                    dataList: tv,
                    isTv: true,
                  );
                },
                itemCount: state.result.length,
              ),
            ],
          );
        } else if (state is SearchTvError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Container();
        }
      }),
    );
  }

  Widget _space() {
    return SizedBox(
      height: 16,
    );
  }
}
