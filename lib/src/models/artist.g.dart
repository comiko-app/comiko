// GENERATED CODE - DO NOT MODIFY BY HAND

part of comiko.models.artist;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Artist _$ArtistFromJson(Map<String, dynamic> json) => new Artist(
    name: json['name'] as String,
    image: json['image'] as String,
    biography: json['biography'] as String,
    styles: json['styles'] as String);

abstract class _$ArtistSerializerMixin {
  String get name;
  String get image;
  String get biography;
  String get styles;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'image': image,
        'biography': biography,
        'styles': styles
      };
}
