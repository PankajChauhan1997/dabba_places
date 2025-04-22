import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid=Uuid();

class PlaceLocation{
  const PlaceLocation({
     this.lattitude,
     this.longitude,
     this.address,

});

  final double? lattitude;
  final double? longitude;
  final String? address;
}


class Place{
  Place({
    required this.title,
    required this.images,
    required this.location,
    String ? id
  }):id = id??uuid.v4();
  final String id;
  final String title;
  final File images;
  final PlaceLocation location;
}