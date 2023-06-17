import 'package:flutter/material.dart';
import 'package:mausam_app/pages/home.dart';
import 'package:mausam_app/pages/loading.dart';
import 'package:mausam_app/pages/location.dart';

void main() {
  runApp(MaterialApp(

    routes: {
      "/" : (context) => LoadingPage(),
      "/home" : (context) => HomePage(),
      "/loading" : (context) => LoadingPage(),
      "/location" : (context) => LocationPage(),

    },
  ));
}

