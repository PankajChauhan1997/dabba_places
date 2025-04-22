import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart'as syspath;
import 'package:path/path.dart'as path;
import 'package:sqflite/sqflite.dart'as sql;
import 'package:sqflite/sqlite_api.dart';
import '../model/placeModel.dart';

Future<Database>getdatabse()async{
  ///save the image in sqflite local databse file directory...start

  final dbpath=await sql.getDatabasesPath();
  final db= await sql.openDatabase(path.join(dbpath,'dabba_place.db'),
    onCreate:(db,version){
      return db.execute(
          'CREATE TABLE dabba_places(id TEXT PRIMARY KEY,title TEXT, image TEXT, lat REAL,lon REAL, address TEXT)');
    },
    version: 1,
  );

  ///save the image in sqflite local databse file directory...end
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() :super(const []);

  Future<void> loadPlaces()async{
    final db=await getdatabse();
    final data= await db.query('dabba_places');
    final places=data.map((row)=>Place(
      id: row['id'] as String,
        title: row['title'] as String,
        images: File(row['image'] as String),
        location:PlaceLocation(
            lattitude: row['lat'] as double,
            longitude: row['lon'] as double,
            address: row['address']as String
        ))).toList();
    state=places;

  }
  

  void addPlace(String title,File image,PlaceLocation location ) async{
    ///save the image in local file directory...start
    final appDir=await syspath.getApplicationDocumentsDirectory();
    final fileName=path.basename(image.path);
    final copiedPath=await image.copy('${appDir.path}/$fileName');
    ///save the image in local file directory...end

    final newPlace = Place(title: title, images: copiedPath, location: location);
   final db=await  getdatabse();
    db.insert('dabba_places',
        {
          'id':newPlace.id,
          'title':newPlace.title,
          'image':newPlace.images.path,
          'lat':newPlace.location.lattitude,
          'lon':newPlace.location.longitude,
          'address':newPlace.location.address
        });
    state = [newPlace, ...state];

  }
}
  final userPlacesProvider=StateNotifierProvider<UserPlacesNotifier,List<Place>>((ref)=>
      UserPlacesNotifier());
