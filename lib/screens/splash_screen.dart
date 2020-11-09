import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:randomeatmalaysiaedition/screens/randomeat.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  static int secs = 3500;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: secs), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RandomEatMain(),
          ));
    });
    
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'randoMenu',
      debugShowCheckedModeBanner: false,
        home:  Scaffold(
        backgroundColor: Colors.white,
        
        body: FlareActor(
          "assets/animations/SplashScreen.flr", 
          alignment:Alignment.center, 
          fit:BoxFit.contain, 
          animation:"SplashScreen"
          ),
      ),
    );
  }
}

