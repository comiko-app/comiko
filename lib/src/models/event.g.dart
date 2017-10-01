// GENERATED CODE - DO NOT MODIFY BY HAND

part of comiko.models.event;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => new Event(
    name: json['name'] as String,
    start: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    description: json['description'] as String,
    place: json['place'] as String,
    address: json['address'] as String,
    city: json['city'] as String,
    end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
    image: json['image'] as String,
    price: (json['price'] as num)?.toDouble(),
    artist: json['artist'] as String,
    styles: json['styles'] as String,
    distance: json['distance'] as int);

abstract class _$EventSerializerMixin {
  String get name;
  String get description;
  String get address;
  String get city;
  String get place;
  String get artist;
  String get styles;

  int get distance;
  DateTime get start;
  DateTime get end;
  double get price;
  String get image;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'description': description,
        'address': address,
        'city': city,
        'place': place,
        'artist': artist,
        'styles': styles,
    'distance': distance,
        'date': start?.toIso8601String(),
        'end': end?.toIso8601String(),
        'price': price,
        'image': image
      };
}
