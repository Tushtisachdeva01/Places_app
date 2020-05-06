import 'package:flutter/material.dart';
import 'package:places_app/providers/places_prov.dart';
import 'package:places_app/screens/map.dart';
import 'package:provider/provider.dart';
import 'package:latlong/latlong.dart';

class PlaceDetails extends StatelessWidget {
  static const routeName = '/place-detail';
  @override
  Widget build(BuildContext context) {
    final idOfPlace = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<PlacesProvider>(context,listen: false).findById(idOfPlace);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            child: Text('View on Map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    initialLoc: LatLng(selectedPlace.location.longitude,
                        selectedPlace.location.latitude),
                    isSelect: false,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
