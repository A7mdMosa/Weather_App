import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/widgets/icon_button.dart';

class LocationScreen extends StatefulWidget {
  final jsonData;
  LocationScreen({this.jsonData});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var now = DateTime.now();
  Weather weather = Weather();

  late String weatherDescription;
  late String cityName;
  late int temp;
  late int condition;
  late String weatherString;
  late String weatherTemp;
  late int tempMin;
  late int tempMax;
  late String country;

  void updateUI(dynamic jsonData) {
    setState(() {
      if (jsonData == null) {
        weatherDescription = '';
        cityName = ' ';
        temp = 0;
        tempMin = 24;
        tempMax = 30;
        condition = 400;
        country = ' ';

        weatherString = 'http://openweathermap.org/img/wn/01d@2x.png';
        weatherTemp = 'Unable to get weather data';
        return;
      }
      weatherDescription = jsonData['weather'][0]['description'];
      cityName = jsonData['name'];
      double temperature = jsonData['main']['temp'];
      temp = temperature.toInt();
      condition = jsonData['weather'][0]['id'];
      weatherString = weather.getWeatherIcon(condition);
      weatherTemp = weather.getMessage(temp);
      double tempMinAsDouble = jsonData['main']['temp_min'];
      double tempMaxAsDouble = jsonData['main']['temp_max'];
      tempMin = tempMinAsDouble.toInt();
      tempMax = tempMaxAsDouble.toInt();
      country = jsonData['sys']['country'];
    });
  }

  @override
  void initState() {
    super.initState();
    var jsonData = widget.jsonData;
    updateUI(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: weather.getWeatherColor(condition),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 1]),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButtonWidget(
                    onPress: () async {
                      var jsonData = await weather.getLocationData();
                      updateUI(jsonData);
                    },
                    iconData: Icons.location_on_rounded,
                  ),
                  Column(
                    children: [
                      Text(
                        '$country',
                        style: kCountryStyle,
                      ),
                      Text(
                        '${DateFormat.yMMMEd().format(DateTime.now())}',
                        style: kCountryStyle,
                      ),
                    ],
                  ),
                  IconButtonWidget(
                    onPress: () async {
                      var inputCityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      if (inputCityName != null) {
                        var cityJsonData =
                            await weather.getCityWeather(inputCityName);
                        updateUI(cityJsonData);
                        print(cityJsonData);
                      } else {
                        print('wrong url');
                      }
                    },
                    iconData: Icons.location_city_rounded,
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                      'assets/images/${weather.getWeatherImage(condition)}.png'),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      '$cityName'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: kCityStyle,
                    ),
                  ),
                  Text(
                    '$weatherDescription',
                    style: kWeatherDesStyle,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Image.network(
                    weatherString,
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    ' $temp°',
                    style: kTempStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'min',
                            style: kMinTempStyle,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            '$tempMin°',
                            style: kMinTempStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        children: [
                          Text(
                            'max',
                            style: kMinTempStyle,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            '$tempMax°',
                            style: kMinTempStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                '$weatherTemp',
                textAlign: TextAlign.center,
                style: kButtomTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
