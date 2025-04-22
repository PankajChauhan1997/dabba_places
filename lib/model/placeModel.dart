import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid=Uuid();

class PlaceLocation{
  const PlaceLocation({
    required this.lattitude,
    required this.longitude,
    required this.address
});

  final double lattitude;
  final double longitude;
  final String address;
}


class Place{
  Place({
    required this.title,
    required this.images,
    required this.location,


  }):id = uuid.v4();
  final String id;
  final String title;
  final File images;
  final PlaceLocation location;
}