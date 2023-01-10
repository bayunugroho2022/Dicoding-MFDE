import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_series_detail_page.dart';
import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  final dataList;
  final bool isTv;

  CardList({this.dataList, this.isTv = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            isTv
                ? TvDetailPage.ROUTE_NAME
                : MovieDetailPage.ROUTE_NAME,
            arguments: dataList.id,
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isTv ? dataList.name : dataList.title ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      dataList.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${dataList.posterPath}',
                  width: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/no_image.png',
                    fit: BoxFit.cover,
                  ),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
