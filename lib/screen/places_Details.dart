import 'package:dabba_favorite_place/screen/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/placeModel.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key,required this.place});

  final Place place;
  String get locationImage{
    final lat=place.location.lattitude??0.0;
    final lon=place.location.longitude??0.0;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lon&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:P%7C$lat,$lon&key=AIzaSyDqVvu56D-1kFckJnigSNTANUZCyj4Bj0U';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(title:Text(place.title)),
        body:
    Stack(
      children: [
        Image.file(place.images,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,

        ),
        Positioned(bottom:0,left:0,child:Column(children: [
InkWell(onTap:(){
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MapScreen(
    location: place.location,
    isSelecting: false,)));
},
    child: CircleAvatar(radius: 70,backgroundImage: NetworkImage(locationImage),)),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
            decoration: BoxDecoration(gradient: LinearGradient(
                colors: [Colors.transparent,Colors.black54],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
            child: Text(place.location.address,textAlign: TextAlign.center,
            style:Theme.of(context).textTheme.titleLarge!.copyWith(
              color:Theme.of(context).colorScheme.onSurface)),),
        ],) )
      ],

    ),);
  }
}
