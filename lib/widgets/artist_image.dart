import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

class ArtistImage extends StatelessWidget {
  final String url;
  final double height;

  ArtistImage(this.url, {this.height});

  @override
  Widget build(BuildContext context) => new Image(
        image: new CachedNetworkImageProvider(url),
        fit: BoxFit.cover,
        height: height,
      );
}
