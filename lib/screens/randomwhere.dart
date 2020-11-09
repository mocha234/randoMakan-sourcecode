import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:randomeatmalaysiaedition/screens/infopage.dart';
import 'package:randomeatmalaysiaedition/screens/randomeat.dart';

import 'package:randomeatmalaysiaedition/screens/randomenu.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:randomeatmalaysiaedition/services/slidingAnimation.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'dart:math';

//web_helper.dart
// you ammend something, as it handles error
// source:https://www.digitalocean.com/community/tutorials/flutter-geolocator-plugin

class RandomWhere extends StatefulWidget {
  @override
  _RandomWhereState createState() => _RandomWhereState();
}

class _RandomWhereState extends State<RandomWhere> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;

  final FlareControls controls = FlareControls();

  bool _visible = true;
  bool _visible2 = false;
  int randomID = 0;
  int randomID2 = 0;

  String stateName;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    var sideLengthofPic = MediaQuery.of(context).size.width - 20.0;
    var randomizerPadding = (MediaQuery.of(context).size.height -
            (46.0 //appBar
                +
                6.0 //below appBar
                +
                (sideLengthofPic * 1.1) +
                16.0 //below pic+ word
                +
                100.0 //size of randmizer
                +
                50.0 //bottomsheet
            )) /
        2;
    print(randomizerPadding);

    return MaterialApp(
      title: 'randoMakan',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SafeArea(
              child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      height: 30.0,
                      width: 30.0,
                      image: AssetImage('assets/images/malaysiaflag.png'),
                    ),
                  ),
                  Text(
                    "randoMana(BETA)",
                    style: GoogleFonts.alata(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      //fontStyle: FontStyle.italic,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: 'infoHero',
                      child: GestureDetector(
                        child: Icon(Icons.info_outline),
                        onTap: () {
                          print("top right button pressed");
                          Navigator.push(
                              context,
                              SlideTopRoute(page: InfoPage()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              
              Stack(
                children: <Widget>[
                  AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 300),
                      child:
                          Center(child: _randomLinkWhere(randomID, stateName))),
                  GestureDetector(
                    onTap: () {
                      if (_visible2 == true) {
                        launch('https://tiny.cc/randomana-$stateName-$randomID2');
                      } else if (_visible2 == false) {
                        launch('https://tiny.cc/randomana-$stateName-$randomID');
                      }
                    },
                    child: AnimatedOpacity(
                        opacity: _visible2 ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 300),
                        child: Center(
                            child: _randomLinkWhere(randomID2, stateName))),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Text(
                "Random registered makan place in your state.",
                style: GoogleFonts.alata(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),

              SizedBox(height: randomizerPadding),
              SizedBox(
                height: 100.0,
                width: 100.0,
                child: GestureDetector(
                  onTap: () {
                    print("pressed");
                    setState(() {
                      var initialNumber = new Random();
                      randomID = initialNumber.nextInt(50);
                      randomID2 = initialNumber.nextInt(50);
                      print("randomID : $randomID");
                      print('randomID2 : $randomID2');
                      _visible = !_visible;
                      _visible2 = !_visible2;
                      print('State name is $stateName');
                    });
                  },
                  child: FlareActor(
                    'assets/animations/PlaceButton.flr',
                    animation: 'PlaceButton',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          )),
        ),

        // body: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       if (_currentPosition != null) Text(_currentAddress),
        //       FlatButton(
        //         child: Text("Get location"),
        //         onPressed: () {
        //           _getCurrentLocation();

        //         },
        //       ),
        //     ],
        //   ),
        // ),
        bottomSheet: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(
              color: Colors.grey[300],
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: SizedBox(
                  height: 35.0,
                  width: 35.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, FadeRoute(page: RandomEatMain()));
                    },
                    child: FlareActor(
                      'assets/animations/bottomSheetMakan.flr',
                      animation: 'bottomSheetMakan',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, FadeRoute(page: RandomWhere()));
                    },
                    child: FlareActor(
                      'assets/animations/bottomSheetMana.flr',
                      animation: 'bottomSheetMana',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: SizedBox(
                  height: 35.0,
                  width: 35.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, FadeRoute(page: RandoMenu()));
                    },
                    child: FlareActor(
                      'assets/animations/bottomSheetMenu.flr',
                      animation: 'bottomSheetMenu',
                      fit: BoxFit.cover,
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

  String _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
    return stateName;
  }

  Future<String> _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      stateName = place.administrativeArea.replaceAll(' ', '').toLowerCase();

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        print("${place.locality}, ${place.postalCode}, ${place.country}");
        print(
            "name: ${place.name}, administrative: ${place.administrativeArea}");
        print(
            "subadmin: ${place.subAdministrativeArea},sub-Locality: ${place.subLocality}");
        print(
            "thoroughfare: ${place.thoroughfare}, sub-thoro: ${place.subThoroughfare}");

        print(
            "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}");
        return place.administrativeArea;
      });
    } catch (e) {
      print(e);
    }
    return stateName;
  }

  Widget _randomLinkWhere(int someID, String stateName) {
    var sideLengthofPic = MediaQuery.of(context).size.width - 20.0;

    return Container(
        height: sideLengthofPic,
        width: sideLengthofPic,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: FadeInImage(
          placeholder: AssetImage('assets/images/LoadingRE.png'),
          placeholderErrorBuilder:
              (BuildContext context, Object error, StackTrace stackTrace) {
            print("error");

            return Image(
                image: AssetImage('assets/images/locationservice.png'));
          },
          image: FirebaseImage(
              'gs://random-eat---malaysia-ed-2b94c.appspot.com/randomplace/$stateName/Slide$someID.jpg'),
          fit: BoxFit.cover,
          imageErrorBuilder:
              (BuildContext context, Object error, StackTrace stackTrace) {
            print("error");
            return Image(
                image: AssetImage('assets/images/locationservice.png'));
          },
        ));
  }
}
