import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/widgets/icon_button.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: kCityScreenColor,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 1]),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButtonWidget(
                  onPress: () {
                    Navigator.pop(context);
                  },
                  iconData: Icons.arrow_back_ios_rounded),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  style: kTextFieldStyle,
                  onChanged: (value) {
                    cityName = value;
                    print(cityName);
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_city_rounded,
                        size: 40.0, color: Colors.black),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    hintText: 'Enter city name ',
                    hintStyle: kHintStyle,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.black54),
                  ),
                  onPressed: () {
                    Navigator.pop(context, cityName);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Get The weather',
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
