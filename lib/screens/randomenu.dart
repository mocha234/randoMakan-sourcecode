import 'package:flutter/material.dart';
import 'package:randomeatmalaysiaedition/screens/infopage.dart';
import 'package:randomeatmalaysiaedition/screens/randomwhere.dart';
import 'package:randomeatmalaysiaedition/screens/randomeat.dart';
import 'package:randomeatmalaysiaedition/services/slidingAnimation.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_admob/firebase_admob.dart';

class RandoMenu extends StatefulWidget {
  @override
  _RandoMenuState createState() => _RandoMenuState();
}

class _RandoMenuState extends State<RandoMenu> {
  //_RandoMenuState();

  BannerAd _myBanner;

  BannerAd buildLargeBannerAd() {
    return BannerAd(
      
        adUnitId: "ca-app-pub-8316009436646788/6410062421", 
        // adUnitId: BannerAd.testAdUnitId, 
        
        size: AdSize.largeBanner,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            _myBanner
              ..show(
                  anchorType: AnchorType.top,
                  anchorOffset: MediaQuery.of(context).size.height * 0.15);
          }
        });
  }

  @override
  void initState() {
    super.initState();

    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-8316009436646788~1560448047");
    // FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _myBanner = buildLargeBannerAd()..load();

  }

  @override
  void dispose() {
    print("wwwwwwwwwwwwwwwwwww");
    _myBanner?.dispose();
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'randoMenu',
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
                      "randoMenu",
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
                            _myBanner.dispose();
                            Navigator.push(
                                context,
                                SlideTopRoute(page: InfoPage()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 
                  MediaQuery.of(context).size.height/2 - 100),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                        "An upcoming feature for you to randomize/browse menu in a makan place!",
                        style: GoogleFonts.alata(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
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
                          _myBanner.dispose();
                          Navigator.push(
                              context,
                              FadeRoute(page: RandomEatMain()));
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
                          _myBanner.dispose();
                          Navigator.push(
                              context,
                              FadeRoute(page: RandomWhere()));
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
                          _myBanner.dispose();
                          Navigator.push(
                              context,
                              FadeRoute(page: RandoMenu()));
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
}
