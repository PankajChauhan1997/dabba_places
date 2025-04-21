import 'package:dabba_favorite_place/widgets/places_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_places.dart';
import 'add_places.dart';

class YourPlaces extends ConsumerWidget {
  const YourPlaces({super.key,}) ;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userPlace=ref.watch(userPlacesProvider);
        return Scaffold(
        appBar:AppBar(title:Text('Your Places'),
            actions:[
              IconButton(onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder:
                        (BuildContext context)=>FavoritePalce()));
              }, icon: Icon(Icons.add),),

            ]),
        body:PlacesList(places:userPlace,)
    );
  }
}
