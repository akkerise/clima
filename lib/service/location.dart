import 'dart:convert';

import 'package:clima/service/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class LocationService {
  double latitude;
  double longitude;

  LocationService({this.latitude, this.longitude});

  Future currentLocation() async {
    try {
      Position position = await Geolocator().getCurrentPosition(
        locationPermissionLevel: GeolocationPermission.locationWhenInUse,
        desiredAccuracy: LocationAccuracy.low,
      );
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
