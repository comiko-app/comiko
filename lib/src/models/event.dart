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
    this.address,
    this.city,
    @required this.start,
    this.end,
    this.image,
    this.price,
  });
}
