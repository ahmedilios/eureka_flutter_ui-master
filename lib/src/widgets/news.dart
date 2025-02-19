import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_html/flutter_html.dart';

class NewsPage extends StatelessWidget {
  final String picture;
  final String title;
  final String author;
  final String timestamp;
  final String content;

  NewsPage({
    this.picture,
    @required this.title,
    @required this.author,
    @required this.timestamp,
    @required this.content,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (picture != null)
              ClipRect(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: CachedNetworkImage(
                          imageUrl: picture,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 12.0,
                            sigmaY: 12.0,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: picture,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Tooltip(
                    message: title,
                    child: Text(
                      title,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    height: 6.0,
                    color: Colors.grey,
                  ),
                  Tooltip(
                    message: '$author em $timestamp',
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '$author em $timestamp',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
  //                Html(
  //                  data: content,
  //                ),
                ],
              ),
            ),
          ],
        ),
      );
}
