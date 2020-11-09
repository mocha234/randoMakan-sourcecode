import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_admob/firebase_admob.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {


  BannerAd _myBanner2;

  BannerAd _buildBannerAd() {
    return BannerAd(

        adUnitId: "ca-app-pub-8316009436646788/6410062421", 
        // adUnitId: BannerAd.testAdUnitId, 
        
        size: AdSize.banner,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            _myBanner2..show();
          }
        });
  }

  

  @override
  void initState() {
    super.initState();

    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-8316009436646788~1560448047"); 
    // FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId); 

    _myBanner2 = _buildBannerAd()..load();

  }

  @override
  void dispose() {

    _myBanner2?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'randoMakan',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(1.0, 8.0, 1.0, 0.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0),
                          bottomRight: const Radius.circular(20.0),
                          bottomLeft: const Radius.circular(20.0),
                        )),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.cancel),
                              iconSize: 20,
                              onPressed: () {
                                print("top right button pressed");
                                Navigator.pop(context);
                              },
                            ),
                            Hero(
                              tag: 'infoHero',
                              child: Icon(
                                Icons.info_outline,
                                color: Colors.black,
                                size: 20.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image(
                                height: 30.0,
                                width: 30.0,
                                image: AssetImage(
                                    'assets/images/malaysiaflag.png'),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Container(
                            height: 200.0,
                            width: 200.0,
                            child: FadeInImage(
                              placeholder:
                                  AssetImage('assets/images/LoadingRE.png'),
                              image: AssetImage(
                                  'assets/images/RandomEatwithTagline.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 2.0, 1.0, 0.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '"Food, bringing us together."',
                              style: GoogleFonts.alata(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(24.0, 8.0, 16.0, 2.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Get your food pics featured in this app, by simply mentioning us(@randomakan_app) at Instagram or Twitter & caption it with #randoMakan & #MalaysianFood. ",
                              style: GoogleFonts.alata(
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(24.0, 8.0, 16.0, 2.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "For more info on how to contribute your pics, please checkout our Instagram!",
                              style: GoogleFonts.alata(
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 10.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "For Collaborations, ads, sponsorship or feedback, feel free to reach out to us via any platform below:",
                              style: GoogleFonts.alata(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  launch(
                                      'https://instagram.com/randomakan_app');
                                },
                                child: Image(
                                  height: 20.0,
                                  width: 20.0,
                                  image:
                                      AssetImage('assets/images/instagram.png'),
                                ),
                              ),
                              Text(
                                "   @randomakan_app",
                                style: GoogleFonts.alata(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  launch('https://twitter.com/randomakan_app');
                                },
                                child: Image(
                                  height: 20.0,
                                  width: 20.0,
                                  image:
                                      AssetImage('assets/images/twitter.png'),
                                ),
                              ),
                              Text(
                                "   @randomakan_app",
                                style: GoogleFonts.alata(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                height: 20.0,
                                width: 20.0,
                                image: AssetImage('assets/images/mail.png'),
                              ),
                              Text(
                                "   randomeat.malaysia@gmail.com",
                                style: GoogleFonts.alata(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        SizedBox(
                          width: 150,
                          height: 30,
                          child: RaisedButton(
                            color: Colors.grey[100],
                            child: Text(
                              "Rate this app",
                              style: GoogleFonts.alata(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                                side: BorderSide(color: Colors.black)),
                            onPressed: () {
                              launch(
                                  'https://play.google.com/store/apps/details?id=com.quanfiniti.randomeatmalaysiaedition');
                            },
                          ),
                        
                        ),

                        SizedBox(
                          height: 6.0,
                        ),

                        SizedBox(
                          width: 150,
                          height: 30,
                          child: RaisedButton(
                            color: Colors.grey[100],
                            child: Text(
                              "Feedback to us",
                              style: GoogleFonts.alata(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                                side: BorderSide(color: Colors.black)),
                            onPressed: () {
                              launch(
                                  'https://instagram.com/randomakan_app');
                            },
                          ),
                        ),

                        SizedBox(
                          height: (MediaQuery.of(context).size.height)/5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
