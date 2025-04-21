import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class pickeImageInput extends StatefulWidget {
  const pickeImageInput({Key? key}) : super(key: key);

  @override
  State<pickeImageInput> createState() => _pickeImageInputState();

}

class _pickeImageInputState extends State<pickeImageInput> {
  File ? selectedImage;
  void _takeImages()async{

    final imagePicker=ImagePicker();

    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if(pickedImage==null){
      return;
    }
    setState((){
      selectedImage=File(pickedImage.path);
    });

  }
  @override
  Widget build(BuildContext context) {
    Widget content=TextButton.icon(
        label:Text("Take Picture"),
        onPressed:_takeImages,
        icon: Icon(Icons.camera));
    if(selectedImage!=null){
      content=GestureDetector(
          onTap:_takeImages,
          child: Image.file(
              selectedImage!,fit:BoxFit.cover
          ));
    }

    return Container(
      decoration:BoxDecoration(border:Border.all(
          width:1,
          color:Theme.of(context).colorScheme.primary.withValues())),
      height:250,
      width:double.infinity,
      alignment:Alignment.center,
      child:content
      
    );
  }
}

