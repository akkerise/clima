import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/screen/location.dart';
import 'package:clima/service/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/service/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final API_KEY = '900f8c0d7b9b8fc2190c894ee0396aaf';
  final BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  double longitude;
  double latitude;
  LocationService location = new LocationService();
  OpenWeatherMapService owm = new OpenWeatherMapService();

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  void fetchLocation() async {
    await location.currentLocation();
    longitude = location.longitude;
    latitude = location.latitude;
    var weather = await owm.fetch(latitude, longitude);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        weatherByLocation: weather,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
