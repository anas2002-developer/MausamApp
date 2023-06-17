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
      city_name = "Noida";
    }
    // callAPI(city_name);

    return Scaffold(
      body: Stack(
        children: [
          Expanded(
              child: Lottie.network("https://assets5.lottiefiles.com/packages/lf20_HlhzUG.json", height: double.infinity, width: double.infinity, fit: BoxFit.cover),),
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60,),
                  Text("$city_name", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xffe7ebf4), fontFamily: 'Jost'),),
                  SizedBox(height: 260,),
                  SpinKitFoldingCube(size: 50, color: Colors.white38,),
                  SizedBox(height: 240,),
                  Text("Mausam App", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Color(0xffe7ebf4), fontFamily: 'Comforter'),),
                  Text("Discover the world through weather's ever-changing canvas.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xffe7ebf4), fontStyle: FontStyle.italic, fontFamily: 'Jost'), ),


                ],
              ),
            ),
          ),
        ],
      ),
      // body: SingleChildScrollView(
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         ElevatedButton(
      //           onPressed: (){
      //             Navigator.pushNamed(context, "/home");
      //           },
      //           child: Text("GOTO HOME"),
      //         ),
      //         Text("City : $city_name"),
      //         SpinKitChasingDots(
      //           size: 50,
      //           color: Colors.black,
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
