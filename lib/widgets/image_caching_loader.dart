import 'dart:async';

import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comiko/widgets/page_view_wrapper.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';

class ImagesCachingLoader extends StatelessWidget {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();
  final PageViewWrapper _pageView;
  final Completer _areImagesCached = Completer();

  ImagesCachingLoader(this._pageView);

  Future<Null> cacheArtistImages(BuildContext context) async {
    final snapshot = await Firestore.instance
        .collection('artists')
        .where("deleted", isEqualTo: false)
        .orderBy('name', descending: false)
        .snapshots
        .first;

    final cachedImages = <Future>[];
    for (var d in snapshot.documents) {
      final artist = Artist.fromJson(d.data);
      if (artist.imageUrl == null) {
        print("${artist.name} has no picture!");
        continue;
      }
      final imageProvider = CachedNetworkImageProvider(artist.imageUrl);
      cachedImages.add(precacheImage(imageProvider, context));
    }

    await Future.wait(cachedImages);

    _areImagesCached.complete();
    _asyncLoaderState.currentState.reloadState();
  }

  @override
  Widget build(BuildContext context) => AsyncLoader(
      key: _asyncLoaderState,
      initState: () => _areImagesCached.future,
      renderLoad: () => Center(child: CircularProgressIndicator()),
      renderError: ([error]) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(
                    Icons.error_outline,
                    size: 72.0,
                  )),
              Text("Une erreur est survenue en chargeant l'application :("),
            ],
          ),
      renderSuccess: ({data}) => _pageView);
}
