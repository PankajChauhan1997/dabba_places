import 'package:dabba_favorite_place/model/placeModel.dart';
import 'package:dabba_favorite_place/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget{
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      lattitude: 37.422,
      longitude: -122.084,
      address: 'Devil house',
    ),
    this.isSelecting = true,
  });


  final PlaceLocation location;
  final bool isSelecting;
  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }

}
class _MapScreenState extends State<MapScreen>{
  LatLng? pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text(widget.isSelecting?"Pick your location":"Your Location"),
        actions: [
        if(widget.isSelecting)
          IconButton(onPressed: (){
            Navigator.of(context).pop(pickedLocation);
          },
              icon: Icon(Icons.save))
    ]),
      body:GoogleMap(
        onTap: !widget.isSelecting?null:(position){
          setState(() {
            pickedLocation=position;
          });
        },
        initialCameraPosition: CameraPosition(
            target: LatLng(
            widget.location.lattitude??0.0,
            widget.location.longitude??0.0 ),zoom:16,),
          markers:(pickedLocation==null && widget.isSelecting)?{}:{
          Marker(markerId: MarkerId('M1'),
              position: pickedLocation??LatLng(widget.location.lattitude??0.0,
              widget.location.longitude??0.0))
          }

      ) ,);
  }
  
}