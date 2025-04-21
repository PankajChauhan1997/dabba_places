import 'package:dabba_favorite_place/screen/places_Details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/placeModel.dart';


class PlacesList extends StatelessWidget {
   PlacesList({super.key,required this.places});

  final List<Place>places;

  @override
  Widget build(BuildContext context) {
    if(places.isEmpty){
      return  Center(
          child:Text('No places added yet',
          style:
          Theme.of(context).textTheme.titleMedium!.copyWith(
          color:Theme.of(context).colorScheme.onSurface)));
    }
    return ListView.builder(itemCount:places.length,
    itemBuilder: ( context,  index)=>ListTile(
      title:Text(places[index].title,
          style:Theme.of(context).textTheme.titleMedium!.copyWith(
        color:Theme.of(context).colorScheme.onSurface
      )),onTap:(){
        Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context)=>
            PlaceDetails(place: places[index],)));
    }
    ),);
  }
}
