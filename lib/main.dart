import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/pages/about/about_page.dart';
import 'package:ditonton/presentation/pages/home/home_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist/watchlist_page.dart';
import 'package:ditonton/presentation/pages/search/search_page.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_series_detail_page.dart';
import 'package:ditonton/presentation/provider/home/home_notifier.dart';
import 'package:ditonton/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/search/search_notifier.dart';
import 'package:ditonton/presentation/provider/tv/popular_tv_notifier.dart';
import 'package:ditonton/presentation/provider/tv/top_rated_tv_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<HomeNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              final type = settings.arguments as String;
              return CupertinoPageRoute(builder: (_) => SearchPage(type : type));
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case PopularTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case TopRatedTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }

  final kTextTheme = TextTheme(
    headline5: kHeading5,
    headline6: kHeading6,
    subtitle1: kSubtitle,
    bodyText2: kBodyText,
  );

}
