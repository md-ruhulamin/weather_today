import 'package:weather_today_completed/services/network.dart';

class Weather {
  void getLocationData(String cityname) async {
    var weatherData = await getCityWeather(cityname);
    print(weatherData);
  }

  //method to get Dhaka weather
  Future<dynamic> getCityWeather(String cityName) async {
    final String weatherUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName &appid=5a18fc6e52dc7342ee016a20e95a106c&units=metric";
    // "https://api.openweathermap.org/data/2.5/weather?lat=88&lon=88&appid=5a18fc6e52dc7342ee016a20e95a106c&units=metric";
    NetworkHelper networkHelper = NetworkHelper('$weatherUrl');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }
}
