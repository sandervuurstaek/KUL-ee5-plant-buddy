import 'dart:convert';

import 'package:location/location.dart';
import 'package:plantbuddy/models/rest_request.dart';

/// Class with static methods for handling location
class LocationHandler {
  /// Get current location
  ///
  /// Permissions are handled by the function.
  /// If some permissions aren't granted null is returned, on success [LocationData] is returend.
  static Future<LocationData?> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return location.getLocation();
  }

  static Future<String?> getCityFromCoordinates(double lat, double lon) =>
      RestRequest(baseUrl: "api.bigdatacloud.net").httpGet(
        "/data/reverse-geocode-client",
        queryParameters: {
          "latitude": lat.toString(),
          "longitude": lon.toString(),
          "localityLanguage": "en"
        },
      ).then((response) => response.statusCode == 200
          ? jsonDecode(response.body)["locality"]
          : null);
}
