import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:randomeatmalaysiaedition/screens/randomwhere.dart';
import 'package:randomeatmalaysiaedition/screens/randomenu.dart';
import 'package:randomeatmalaysiaedition/screens/infopage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:randomeatmalaysiaedition/services/slidingAnimation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:firebase_image/firebase_image.dart';

import 'package:firebase_admob/firebase_admob.dart';

//AdmoB: https://medium.com/@akshatapp/how-to-integrate-admob-ads-in-your-flutter-app-using-firebase-admob-package-7de2663286d3

class RandomEatMain extends StatefulWidget {
  @override
  _RandomEatMainState createState() => _RandomEatMainState();
}

class _RandomEatMainState extends State<RandomEatMain> {
  //_RandomEatMainState();
  int clickCount = 0;

  bool _visible = true;
  bool _visible2 = false;
  int randomID = 0;
  int randomID2 = 0;

  InterstitialAd myInterstitial;

  InterstitialAd buildInterstitialAd() {
    return InterstitialAd(
      // adUnitId: 'ca-app-pub-3940256099942544/1033173712', //test
      adUnitId: 'ca-app-pub-8316009436646788/1672128689', //real

      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.failedToLoad) {
          myInterstitial..load();
        } else if (event == MobileAdEvent.closed) {
          myInterstitial = buildInterstitialAd()..load();
        }
        print(event);
      },
    );
  }

  void showInterstitialAd() {
    myInterstitial..show();
  }

  // void showRandomInterstitialAd() {
  //   Random r = new Random();
  //   bool value = r.nextBool();

  //   if (value == true) {
  //     myInterstitial..show();
  //   }
  // }

  //showAdsafter 10 clicks

  // void showInterstitialAdAfterTenClicks(int clickCount) {

  //   if (clickCount == 10) {
  //     print("ClickCount in ShowAds Function");
  //     myInterstitial..show();
  //   }
  // }

  @override
  void initState() {
    super.initState();

    myInterstitial = buildInterstitialAd()..load();
  }

  @override
  void dispose() {
    myInterstitial.dispose();
    super.dispose();
  }
  //admob to here

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
                      "randoMakan",
                      style: GoogleFonts.alata(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                        tag: 'infoHero',
                        child: GestureDetector(
                          child: Icon(Icons.info_outline),
                          //iconSize: 20,
                          onTap: () {
                            print("top right button pressed");
                            Navigator.push(
                                context, SlideTopRoute(page: InfoPage()));
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
                        child: Center(child: _randomLinkEatFirebase(randomID))),
                    GestureDetector(
                      onTap: () {
                        if (_visible2 == true) {
                          launch('https://tiny.cc/randomakan-$randomID2');
                        } else if (_visible2 == false) {
                          launch('https://tiny.cc/randomakan-$randomID');
                        }
                      },
                      child: AnimatedOpacity(
                          opacity: _visible2 ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 300),
                          child:
                              Center(child: _randomLinkEatFirebase(randomID2))),
                    )
                  ],
                ),
                SizedBox(height: 3.0),
                Text(
                  "Random je la.",
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
                        randomID = initialNumber.nextInt(400);
                        randomID2 = initialNumber.nextInt(400);
                        print("randomID : $randomID");
                        print('randomID2 : $randomID2');
                        _visible = !_visible;
                        _visible2 = !_visible2;

                        clickCount = clickCount + 1;

                        if (clickCount == 20) {
                          clickCount = 0;
                          myInterstitial..show();
                          print("ClickCount is reset to zero");
                        } else {
                          print("Current ClickCount: $clickCount");
                        }
                      });
                    },
                    child: FlareActor(
                      'assets/animations/FoodButton.flr',
                      animation: 'FoodButton',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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

  Widget _randomLinkEatFirebase(int someID) {
    var sideLengthofPic = MediaQuery.of(context).size.width - 20.0;

    return Container(
        height: sideLengthofPic,
        width: sideLengthofPic,
        decoration: BoxDecoration(
          //borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        child: FadeInImage(
          placeholder: AssetImage('assets/images/LoadingRE.png'),
          placeholderErrorBuilder:
              (BuildContext context, Object error, StackTrace stackTrace) {
            print("error");
            return Image(image: AssetImage('assets/images/nointernet.png'));
          },
          image: FirebaseImage(
              'gs://random-eat---malaysia-ed-2b94c.appspot.com/randomfood/Slide$someID.jpg'),
          fit: BoxFit.cover,
          imageErrorBuilder:
              (BuildContext context, Object error, StackTrace stackTrace) {
            print("error");
            return Image(image: AssetImage('assets/images/nointernet.png'));
          },
        ));
  }
}
