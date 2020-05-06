import 'package:flutter/material.dart';
import 'package:places_app/screens/places_details.dart';
import 'package:provider/provider.dart';

import './screens/add_places.dart';
import './providers/places_prov.dart';
import './screens/places_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlacesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlacesScreen.routeName : (ctx) => AddPlacesScreen(),
          PlaceDetails.routeName: (ctx) => PlaceDetails(),
        },
      ),
    );
  }
}
