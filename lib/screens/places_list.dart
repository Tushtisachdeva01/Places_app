import 'package:flutter/material.dart';
import 'package:places_app/screens/places_details.dart';
import 'package:provider/provider.dart';

import '../providers/places_prov.dart';
import '../screens/add_places.dart';

class PlacesListScreen extends StatefulWidget {
  @override
  _PlacesListScreenState createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  @override
  Widget build(BuildContext context) {
    // String id = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Places',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlacesScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false)
            .fetchSetPlaces(),
        builder: (ctx, snapShot) => snapShot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<PlacesProvider>(
                child: Center(
                  child: const Text('No places yet'),
                ),
                builder: (ctx, places, ch) => places.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: places.items.length,
                        itemBuilder: (ctx, i) {
                      final folder = places.items[i];
                         return Dismissible(
                          key: ValueKey(places.items.elementAt(i)),
                          confirmDismiss: (direction) {
                            return showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('Are you sure?'),
                                content: Text(
                                  'Sure???',
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop(false);
                                    },
                                    child: Text('NO'),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop(true);
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              ),
                            );
                          },
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              places.removePlace(folder.id);
                            });
                          },
                          background: Container(
                            color: Theme.of(context).errorColor,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 40,
                            ),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                            margin: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 4,
                            ),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(places.items[i].image),
                            ),
                            title: Text(places.items[i].title),
                            subtitle: Text(places.items[i].location.address),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  PlaceDetails.routeName,
                                  arguments: places.items[i].id);
                            },
                          ),
                        );
                        }
                      ),
              ),
      ),
    );
  }
}
