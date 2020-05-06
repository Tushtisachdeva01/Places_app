import 'package:http/http.dart' as http;
import 'dart:convert';

const API_KEY = '[token]';

class LocationHelper {
  static String generateLocationImage({double latitude, double longitude}) {
    return 'https://www.mapquestapi.com/staticmap/v4/getmap?key=$API_KEY&size=600,400&pois=red_1,$latitude,$longitude';
  }

  static Future<String> getPlace(double lat, double lng) async {
    final url =
        "https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?access_token=[key]";
    final response = await http.get(url);
    final locData = jsonDecode(response.body);
    print(response.body);
    final String address = locData['features'][1]['place_name'];
    return address;
  }
}
