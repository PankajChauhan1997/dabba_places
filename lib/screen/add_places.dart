import 'dart:io';

import 'package:dabba_favorite_place/model/placeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dabba_favorite_place/providers/user_places.dart';

import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

class FavoritePalce extends ConsumerStatefulWidget {
  const FavoritePalce({Key? key,}) : super(key: key);


  @override
  ConsumerState<FavoritePalce> createState() => _FavoritePalceState();
}

class _FavoritePalceState extends ConsumerState<FavoritePalce> {
  final _titleController=TextEditingController();
  File? selectedImage;
  PlaceLocation? selectedLocation;

  void _saveplace(){
    final enteredTitle=_titleController.text;
    if(enteredTitle.isEmpty||selectedImage==null||selectedLocation==null){
return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(enteredTitle,selectedImage!,selectedLocation!);
    Navigator.of(context).pop();
  }
  @override
  void dispose(){
    _titleController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(title:Text('Add Favorite Place'),
        ),
        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(crossAxisAlignment:CrossAxisAlignment.center,
                children:[
               TextField(
                  maxLength:50,
                            decoration:InputDecoration(
                label:Text("Title")),
                   controller:_titleController,
                 style:TextStyle(color:Theme.of(context).colorScheme.onSurface)
              ),
                  SizedBox(height:20),
                  pickeImageInput(onPickImage: (image) =>
                  selectedImage=image
                  ),
                  SizedBox(height:20),
                  LocationInput(onLocationSelection: (location)=>selectedLocation=location,),
                  SizedBox(height:20),
                  ElevatedButton.icon(onPressed:_saveplace,
                    label: Text("Add Place"),
                    icon: Icon(Icons.add),)
            ]),
          ),
        )
    );
  }
}
