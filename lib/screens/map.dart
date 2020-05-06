import 'package:flutter/material.dart';
// import 'package:places_app/models/place.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapScreen extends StatefulWidget {
  final LatLng initialLoc;
  final bool isSelect;
  MapScreen({this.initialLoc, this.isSelect});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLoc;
  // void _selectedLoc(LatLng position) {
  //   setState(() {
  //     _pickedLoc = position;
  //   });
  // }
  @override
  void initState() {
    _pickedLoc = widget.initialLoc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Location',
        ),
        actions: <Widget>[
          if (widget.isSelect)
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.check),
              onPressed: _pickedLoc == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLoc);
                    },
            ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          minZoom: 5,
          maxZoom: 18,
          center: _pickedLoc,
          onTap: widget.isSelect
              ? (newPlace) {
                  setState(
                    () {
                      _pickedLoc = newPlace;
                    },
                  );
                }
              : null,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/tushti/ck9r41d7m6ig71ipdovaltml8/tiles/256/{z}/{x}/{y}@2x?access_token=[key]",
            additionalOptions: {
              'accessToken':
                  '[key]',
              'id': 'mapbox.mapbox-streets-v8'
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                point: _pickedLoc,
                builder: (ctx) => IconButton(
                  icon: Icon(Icons.location_on),
                  onPressed: () {
                    print('HI');
                  },
                  color: Colors.red,
                  iconSize: 45,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
