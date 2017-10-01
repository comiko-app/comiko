library comiko.models.event;

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'event.g.dart';

@JsonSerializable()
class Event extends Object with _$EventSerializerMixin {
  final String name;
  final String description;
  final String address;
  final String city;
  final String place;
  final String artist;
  final String styles;

  @JsonKey(name: 'date')
  final DateTime start;
  final DateTime end;

  final double price;
  final String image;

  Event({
    @required this.name,
    @required this.start,
    this.description,
    this.place,
    this.address,
    this.city,
    this.end,
    this.image,
    this.price,
    this.artist,
    this.styles,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  String get imageUri => 'lib/assets/$image';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Event &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              start == other.start;

  @override
  int get hashCode => name.hashCode ^ start.hashCode;
}
