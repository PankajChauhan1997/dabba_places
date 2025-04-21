import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/placeModel.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() :super(const []);

  void addPlace(String title) {
    final newPlace = Place(title: title);
    state = [newPlace, ...state];
  }
}
  final userPlacesProvider=StateNotifierProvider<UserPlacesNotifier,List<Place>>((ref)=>
      UserPlacesNotifier());
