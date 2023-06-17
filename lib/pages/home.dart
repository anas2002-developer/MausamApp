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
      temperature = fetchedMap['keyTemp'].toString().substring(0,4);
    }



    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Color(0xff424d5d),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Color(0xffc3c8cb),
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
                  SizedBox(height: 40,),
                  Text("$name", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Jost', color: Color(0xffc3c8cb), fontSize: 24)),
                  Text("TODAY", style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Jost', color: Color(0xffc3c8cb), fontSize: 12)),
                  SizedBox(height: 40,),
                  Image.network("https://openweathermap.org/img/wn/$icon@2x.png",
                    height: 100,
                    width: 100,),
                  Text("$desc",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Jost', color: Color(0xffc3c8cb), fontSize: 15)),

                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 90,
                        child: Text("$temperature", style: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.bold, color: Color(0xffc3c8cb), fontSize: 80),),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        padding: EdgeInsets.only(top: 10,),
                        height: 90,
                        child: Column(
                          children: [
                            Text("o", style: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.bold, color: Color(0xffc3c8cb), fontSize: 25),),
                            Text("   C", style: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.bold, color: Color(0xffc3c8cb), fontSize: 30),),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 80,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          height: 180,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white12,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.water_drop_rounded, color: Color(0xffc3c8cb), size: 35,),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text("$humidity", style: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.bold, color: Color(0xffc3c8cb), fontSize: 40),),
                              Text("%", style: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.normal, color: Color(0xffc3c8cb), fontSize: 16),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 180,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.black12,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.waves, color: Color(0xffc3c8cb), size: 35,),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text("$windspeed", style: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.bold, color: Color(0xffc3c8cb), fontSize: 40),),
                              Text("km/hr", style: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.normal, color: Color(0xffc3c8cb), fontSize: 16),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Text("powered by OpenWeatherAPI", style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Color(
                      0xffb1b5b7)),),

                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xff313945),

    );
  }
}
