import 'package:flutter/material.dart';
import 'package:mausam_app/pages/home.dart';
import 'package:mausam_app/worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  var city_name = "loading";

  void callAPI(String city_name) async{

    Worker jaspur = Worker(city: city_name);
    await jaspur.getAPIdata();

    print("Name : "+jaspur.name);

    setState(() {
      city_name=jaspur.name;
    });

    print("Description : "+jaspur.desc);
    print("Windspeed : "+jaspur.windspeed);
    print("Temperature : "+jaspur.temp);
    print("Humidity : "+jaspur.humidity);
    print("Icon : "+jaspur.icon);

    Future.delayed(Duration(seconds: 1), (){
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "keyName" : jaspur.name,
        "keyDesc" : jaspur.desc,
        "keyWindspeed" : jaspur.windspeed,
        "keyTemp" : jaspur.temp,
        "keyHumidity" : jaspur.humidity,
        "keyIcon" : jaspur.icon,
      });
    });

  }

  @override
  void initState() {
    super.initState();

    print("init called");

  }

  @override
  Widget build(BuildContext context) {
    final homeMap = ModalRoute.of(context)!.settings.arguments as Map?;

    if (homeMap?.isNotEmpty ?? false){
      city_name = homeMap?['searchData'];
    }
    else{
      city_name = "Jaspur";
    }
    callAPI(city_name);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, "/home");
              },
              child: Text("GOTO HOME"),
            ),
            Text("City : $city_name"),
            SpinKitChasingDots(
              size: 50,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
