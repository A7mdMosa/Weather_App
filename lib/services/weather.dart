import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/services/network.dart';
import '../services/location.dart';

const apiKey = 'd1a2cb8eaf2653a159e7d4276dccb563';
const weatherUrl = 'http://api.openweathermap.org/data/2.5/weather';

class Weather {
  Future<dynamic> getCityWeather(String cityName) async {
    Network network =
        Network('$weatherUrl?q=$cityName&appid=$apiKey&units=metric');
    var jsonData = await network.getData();
    return jsonData;
  }

  Future<dynamic> getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    Network network = Network(
        '$weatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var jsonData = await network.getData();

    return jsonData;
  }

  String getWeatherIcon(int condition) {
    if (condition == 804 || condition == 803) {
      return 'http://openweathermap.org/img/wn/04d@2x.png'; //cloud
    } else if (condition == 802) {
      return 'http://openweathermap.org/img/wn/03d@2x.png'; //singleCloud
    } else if (condition == 801) {
      return 'http://openweathermap.org/img/wn/02d@2x.png'; //cloudsSun
    } else if (condition == 800) {
      return 'http://openweathermap.org/img/wn/01d@2x.png'; //sun
    } else if (condition > 800) {
      return 'http://openweathermap.org/img/wn/50d@2x.png'; //dust
    } else if (condition > 600) {
      return 'http://openweathermap.org/img/wn/13d@2x.png'; //snow
    } else if (condition >= 520) {
      return 'http://openweathermap.org/img/wn/09d@2x.png'; //rain
    } else if (condition == 511) {
      return 'http://openweathermap.org/img/wn/13d@2x.png'; //snow
    } else if (condition >= 500) {
      return 'http://openweathermap.org/img/wn/10d@2x.png'; //sunRain
    } else if (condition >= 300) {
      return 'http://openweathermap.org/img/wn/09d@2x.png'; //rain
    } else if (condition >= 200) {
      return 'http://openweathermap.org/img/wn/11d@2x.png'; //lighting
    } else {
      return ' ';
    }
  }

  String getWeatherImage(int condition) {
    if (condition == 804 || condition == 803) {
      return 'cloudy'; //cloud
    } else if (condition == 802) {
      return 'cloudy'; //singleCloud
    } else if (condition == 801) {
      return 'cloudsSun'; //cloudsSun
    } else if (condition == 800) {
      return 'sun'; //sun
    } else if (condition > 800) {
      return 'sun'; //dust
    } else if (condition > 600) {
      return 'snow'; //snow
    } else if (condition >= 520) {
      return 'rain'; //rain
    } else if (condition == 511) {
      return 'snow'; //snow
    } else if (condition >= 500) {
      return 'rain'; //sunRain
    } else if (condition >= 300) {
      return 'rain'; //rain
    } else if (condition >= 200) {
      return 'light'; //lighting
    } else {
      return 'sun';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'Get some vitamin D';
    } else if (temp > 20) {
      return 'Go for a walk';
    } else if (temp < 10) {
      return 'Drink some coffee';
    } else {
      return 'Make some memories';
    }
  }

  List<Color> getWeatherColor(int condition) {
    if (condition == 804 || condition == 803) {
      return kCloudyColor; //cloud
    } else if (condition == 802) {
      return kCloudyColor; //singleCloud
    } else if (condition == 801) {
      return kCloudSunColor; //cloudsSun
    } else if (condition == 800) {
      return kSunColors; //sun
    } else if (condition > 800) {
      return kSunColors; //dust
    } else if (condition > 600) {
      return kSnowColor; //snow
    } else if (condition >= 520) {
      return kRainColor; //rain
    } else if (condition == 511) {
      return kSnowColor; //snow
    } else if (condition >= 500) {
      return kSunColors; //sunRain
    } else if (condition >= 300) {
      return kRainColor; //rain
    } else if (condition >= 200) {
      return kLightColor; //lighting
    } else {
      return kSunColors;
    }
  }
}
