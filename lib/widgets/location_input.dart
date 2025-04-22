import 'dart:convert';

import 'package:dabba_favorite_place/model/placeModel.dart';
import 'package:dabba_favorite_place/screen/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart'as http;

class LocationInput extends StatefulWidget{
  LocationInput({super.key,this.onLocationSelection});


  final void Function(PlaceLocation location) ? onLocationSelection;
  @override
  State<LocationInput>createState(){
    return _LocationInputState();
  }

}
class _LocationInputState extends State<LocationInput>{
  PlaceLocation? pickedLocation;
  var isGettingLocation=false;

  String get locationImage{
    if(pickedLocation==null){
      return '';
    }
    final lat=pickedLocation?.lattitude??0.0;
    final lon=pickedLocation?.longitude??0.0;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lon&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:P%7C$lat,$lon&key=AIzaSyDqVvu56D-1kFckJnigSNTANUZCyj4Bj0U';
  }
  void getCurrentLocation()async{
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isGettingLocation=true;
    });
    locationData = await location.getLocation();
    final lat=locationData.latitude??0.0;
    final lon=locationData.longitude??0.0;

    if(lat==null ||lon==null){
      return;
    }
    savePlace(lat,lon);
    widget.onLocationSelection!(pickedLocation!);
  }
Future<void> savePlace(double lat,double long)async{
  final url=Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyDqVvu56D-1kFckJnigSNTANUZCyj4Bj0U');
  final response=await http.get(url);
  final resData=json.decode(response.body);
  // final address=resData['results'][0]['formatted_address']??"No address found";
  final address="No address found/Dont have api key";

  print("$address");

  setState(() {
    pickedLocation=PlaceLocation(lattitude: lat, longitude: long, address: address);
    isGettingLocation=false;
  });
}
  void selectOnMap()async{
    await Navigator.of(context).push<LatLng>(MaterialPageRoute(builder: (context)=>MapScreen()));
    if(pickedLocation==null){
      return;
    }
    savePlace(pickedLocation?.lattitude??0.0, pickedLocation?.longitude??0.0);
  }
  @override
  Widget build(BuildContext context) {

    Widget previewContent= Text('No Location choosen',
      textAlign: TextAlign.center,
      style:Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.primary),);
    if(pickedLocation!=null){
      previewContent=Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,);
    }
    if(isGettingLocation==true){
      previewContent=CircularProgressIndicator();
    }
   return Column(children: [
     Container(height: 170,width: double.infinity,
       decoration: BoxDecoration(border: Border.all(width:1,
     color: Theme.of(context).colorScheme.primary.withValues())),
       child:Center(
         child: previewContent
       ) ,),
Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
  TextButton.icon(onPressed: getCurrentLocation, icon:Icon(Icons.location_on),
    label: Text('Get current location'), ),
  TextButton.icon(onPressed: (){

  },
    icon:Icon(Icons.map), label: Text('Select on map'), )
],)
   ],);
  }

}