import 'package:meta/meta.dart';

class Event {
  @Required()
  final String name;
  final String address;
  final String city;

  @Required()
  final DateTime start;
  final DateTime end;
  final double price;

  final String image;

  const Event({
    this.name,
    this.address,
    this.city,
    this.start,
    this.end,
    this.image,
    this.price,
  });
}
