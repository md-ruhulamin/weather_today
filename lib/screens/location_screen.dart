import 'package:flutter/material.dart';
import 'package:weather_today_completed/screens/loading_screen.dart';
import 'package:weather_today_completed/services/weather.dart';
import 'package:weather_today_completed/utils/constants.dart';
import '../utils/custom_paint.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  int temperature = 0;
  int minTemperature = 0;
  int maxTemperature = 0;
  double windSpeed = 0.0;
  int humidity = 50;

  String cityName = "Dhaka";

  @override
  void initState() {
    super.initState();
    // print(widget.locationWeather);
    updateUI(widget.locationWeather);
  }

  double temp = 0.0;
  void updateUI(dynamic weatherData) {
    setState(() {
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      double minTemp = weatherData['main']['temp_min'];
      minTemperature = minTemp.toInt();

      double maxTemp = weatherData['main']['temp_max'];
      maxTemperature = maxTemp.toInt();

      double ws = weatherData['wind']['speed'].toDouble();
      windSpeed = ws;

      int humid = weatherData['main']['humidity'];
      humidity = humid.toInt();

      String city = weatherData['name'];
      cityName = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.09),
              BlendMode.darken,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.only(
                  top: 24,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${temperature}°',
                        style: kTempTextStyle,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {},
                      child: Image.asset(
                        'images/ic_current_location.png',
                        width: 32.0,
                      ),
                    ),
                    SizedBox(width: 24.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => CityScreen())));
                      },
                      child: Image.asset(
                        'images/ic_search.png',
                        width: 32.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 16.0),
                    Image.asset(
                      'images/ic_location_pin.png',
                      width: 24.0,
                      height: 24.0,
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        cityName,
                        textAlign: TextAlign.center,
                        style: kSmallTextStyle.copyWith(
                          fontSize: 16.0,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 190,
                child: CustomPaint(
                  painter: MyCustomPaint(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24.0,
                          bottom: 24.0,
                        ),
                        child: Text(
                          'Weather Today',
                          style: kConditionTextStyle.copyWith(fontSize: 16.0),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ConditionRow(
                            icon: 'images/ic_temp.png',
                            title: 'Min Temp',
                            value: '${minTemperature}°',
                          ),
                          ConditionRow(
                            icon: 'images/ic_wind_speed.png',
                            title: 'Wind Speed',
                            value: '${windSpeed} Km/h',
                          ),
                          ConditionRow(
                            icon: 'images/ic_temp.png',
                            title: 'Max Temp',
                            value: '$maxTemperature°',
                          ),
                          ConditionRow(
                            icon: 'images/ic_humidity.png',
                            title: 'Humidity',
                            value: '$humidity%',
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ConditionRow extends StatelessWidget {
  final String icon;
  final String title;
  final String value;

  const ConditionRow({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          icon,
          width: 24.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Text(
            title,
            style: kConditionTextStyleSmall,
          ),
        ),
        Text(
          value,
          style: kConditionTextStyle,
        ),
      ],
    );
  }
}
