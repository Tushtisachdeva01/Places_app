import 'dart:io';
import 'package:flutter/material.dart';
import '../models/place.dart';
import '../helper/db_helper.dart';
import '../helper/location_helper.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id){
    return _items.firstWhere((place)=> place.id == id);
  }

  void removePlace(String id) {
    _items.removeWhere((item)=>item.id==id);
    notifyListeners();
    DBHelper.deleteData('user_places', id);
  }

  Future<void> addPlace(String title, File image, PlaceLocation picked) async {
    final addressFetched =
        await LocationHelper.getPlace(picked.latitude, picked.longitude);
    final updatedLoc = PlaceLocation(
      latitude: picked.latitude,
      longitude: picked.longitude,
      address: addressFetched,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: updatedLoc,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              longitude: item['loc_lat'],
              latitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
