import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mausam_app/worker/worker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String name = "Jaspur";
  String desc = "description";
  String windspeed = "0.0";
  String temperature = "00.0";
  String humidity = "0.0";
  String icon = "02d";

  var searchCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final fetchedMap = ModalRoute.of(context)!.settings.arguments as Map;
    print(fetchedMap);

    name = fetchedMap['keyName'];
    desc = fetchedMap['keyDesc'];
    humidity = fetchedMap['keyHumidity'];
    icon = fetchedMap['keyIcon'];
    temperature = fetchedMap['keyTemp'];
    windspeed = fetchedMap['keyWindspeed'];

    if (windspeed == "NA" && temperature =="NA"){

    }
    else{
      windspeed = fetchedMap['keyWindspeed'].toString().substring(0,4);
      temperature = fetchedMap['keyTemp'].toString().substring(0,5);
    }



    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFFCD9DF),
                Color(0xFFCFE0F8),
              ]
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.black12,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: InkWell(
                            onTap: (){

                              if (searchCtrl.text.replaceAll(" ", "") != ""){

                                Navigator.pushReplacementNamed(context, '/loading', arguments: {
                                  "searchData" : searchCtrl.text.toString()
                                });
                              }

                            },
                            child: Icon(CupertinoIcons.search)),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchCtrl,
                          decoration: InputDecoration(
                            hintText: "Search any city name....",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Image.network("https://openweathermap.org/img/wn/$icon@2x.png",
                            height: 60,
                            width: 60,),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("$desc"),
                                Text("in $name"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 300,
                        padding: EdgeInsets.all(30),
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.cloud),
                            SizedBox(height: 100,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$temperature"),
                                Text("C"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 180,
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.black12,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.ac_unit_outlined),
                              ],
                            ),
                            SizedBox(height: 40,),
                            Text("$humidity"),
                            Text("%")
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 180,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.black12,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.shutter_speed),
                              ],
                            ),
                            SizedBox(height: 40,),
                            Text("$windspeed"),
                            Text("km/hr")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 80,),
                Text("Made by developer"),
                Text("powered by OpenWeatherAPI"),

              ],
            ),
          ),
        ),
      ),

    );
  }
}
