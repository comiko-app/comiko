library comiko.models.artist;

import 'package:meta/meta.dart';

import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@JsonSerializable()
class Artist extends Object with _$ArtistSerializerMixin {
  final String name;
  final String image;
  final String biography;
  final String styles;

  Artist({
    @required this.name,
    this.image,
    this.biography,
    this.styles,
  });
}
