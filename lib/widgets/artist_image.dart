import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class ArtistImage extends StatelessWidget {
  final String url;
  final double height;

  const ArtistImage({
    @required this.url,
    this.height,
  });

  @override
  Widget build(BuildContext context) => Image(
        image: CachedNetworkImageProvider(url),
        fit: BoxFit.cover,
        height: height,
      );
}
