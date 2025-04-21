import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/placeModel.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key,required this.place});

  final Place place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(title:Text(place.title)),
        body:Center(child: Text(place.title,style:TextStyle(color:Theme.of(context).colorScheme.onSurface))));
  }
}
