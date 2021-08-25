import 'package:clima/screen/city.dart';
import 'package:clima/service/location.dart';
import 'package:clima/service/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/enum/global.dart';
import 'package:clima/service/location.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherByLocation});

  final weatherByLocation;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  int condition;
  String city;

  OpenWeatherMapService owmService = new OpenWeatherMapService();

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherByLocation);
  }

  void updateUI(dynamic data) {
    if(data == null){

    }
    var temp = data['main']['temp'];
    temperature = temp.toInt();
    condition = data['weather'][0]['id'];
    city = data['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var city = await Navigator.push(context, MaterialPageRoute(builder: (context) => CityScreen()));
                      print(city);
                      if(city != null){
                        var weather = await owmService.fetchWeatherByCity(city);
                        updateUI(weather);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "It's 🍦 time in $city!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
