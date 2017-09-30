import 'package:meta/meta.dart';

class Event {
  final String name;
  final String address;
  final String city;
  final DateTime start;
  final DateTime end;
  final double price;
  final String image;

  const Event({
    @required this.name,
    @required this.start,
    this.address,
    this.city,
    this.end,
    this.image,
    this.price,
  });
}
