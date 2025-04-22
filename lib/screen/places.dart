import 'package:dabba_favorite_place/widgets/places_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_places.dart';
import 'add_places.dart';

class YourPlaces extends ConsumerStatefulWidget {
  const YourPlaces({super.key,}) ;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _YourPlacesState();
  }


  }
class _YourPlacesState extends ConsumerState<YourPlaces>{
 late Future<void> _placesFuture;
@override
  void initState() {
    super.initState();
    _placesFuture=ref.read(userPlacesProvider.notifier).loadPlaces();
  }
  @override
  Widget build(BuildContext context) {
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
        body:FutureBuilder(future: _placesFuture, builder: (context,snapshot)=>
        snapshot.connectionState == ConnectionState.waiting?Center(child:CircularProgressIndicator()):
        PlacesList(places:userPlace,)
    ));
  }
}
