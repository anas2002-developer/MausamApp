import 'dart:convert';

import 'package:http/http.dart' as http;

class Worker{

  late String city;

  Worker({required this.city}){
    city = this.city;
  }

  late String name;
  late String desc;
  late String temp;
  late String windspeed;
  late String humidity;
  late String icon;

  Future<void> getAPIdata() async{

    try{
      var url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&appid=12f628abde50380237ef513cf540079f");
      http.Response response = await http.get(url);
      Map jsonData = jsonDecode(response.body);

      String getName = jsonData['name'];

      List weather = jsonData["weather"];
      Map weather_dict = weather[0];
      String weather_desc = weather_dict["description"];

      Map main = jsonData['main'];
      String getTemp = ((main['temp'] - 32)*(5/9)).toString();

      Map wind = jsonData['wind'];
      String getWindspeed = (wind['speed'] * 3.6).toString();

      String getHumidity = main['humidity'].toString();

      String getIcon = weather_dict["icon"].toString();

      name = getName;
      desc = weather_desc;
      temp = getTemp;
      windspeed = getWindspeed;
      humidity = getHumidity;
      icon = getIcon;

    }
    catch(e){
      name = "Invalid City";
      desc = "NA";
      temp = "NA";
      windspeed = "NA";
      humidity = "NA";
      icon = "02d";
    }




  }

}