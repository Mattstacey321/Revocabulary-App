import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:revocabulary/screen/Grammar/Grammar.dart';
import 'package:revocabulary/screen/Home/card.dart';
import 'package:revocabulary/screen/Indiom/indiom.dart';
import 'package:revocabulary/screen/PhraseVerb/phraseVerb.dart';
import 'package:revocabulary/screen/Vocabulary/vocabulary.dart';
import 'package:revocabulary/values/AppColors.dart';
import 'package:revocabulary/widget/AnchoredOverlay.dart';
import 'package:revocabulary/widget/faslideAnimation.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  bool show = false;

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ContainerResponsive(
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ContainerResponsive(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/pngs/home.png"),
                          fit: BoxFit.cover,
                          colorFilter:
                              ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop))),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              FaSlideAnimation(
                                child: Text(
                                  "Hey, User",
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                delayed: 200,
                              ),
                              Spacer(),
                              /*Stack(
                                children: <Widget>[
                                  AnchoredOverlay(
                                    showOverlay: show,
                                    overlayBuilder: (context, offset) => CenterAbout(
                                      position: Offset(offset.dx - 50, offset.dy + 80),
                                      child: SlideAnimation(
                                        isShow: show,
                                        begin:Offset(0,  1),
                                        end: Offset.zero,
                                        curve: Curves.fastOutSlowIn,
                                        delayed: 500,
                                        child: Material(
                                          child: Container(
                                            width: 150,
                                            height: 100,
                                            color: Colors.red,
                                            child: Column(
                                              children: <Widget>[Text("sad"), Text("sad")],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: 
                                  )
                                ],
                              ),*/
                              FaSlideAnimation(
                                delayed: 400,
                                child: Material(
                                  clipBehavior: Clip.antiAlias,
                                  borderRadius: BorderRadius.circular(10000),
                                  color: Colors.grey,
                                  child: InkWell(
                                    onTap: () {
                                      print("c");
                                      setState(() {
                                        show = !show;
                                      });
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10000),
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) => Container(
                                          height: 50,
                                          width: 50,
                                        ),
                                        height: 50,
                                        width: 50,
                                        imageUrl: "https://picsum.photos/300",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: ContainerResponsive(
                    padding: EdgeInsetsResponsive.symmetric(horizontal: 20, vertical: 10),
                    width: screenSize.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                            child: TextResponsive(
                          'What you want \nto learn ?',
                          style: TextStyle(
                              fontSize:ScreenUtil().setSp(28) , fontWeight: FontWeight.bold),
                        )),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsetsResponsive.all(0),
                            child: Row(
                              children: <Widget>[
                                FaSlideAnimation(
                                  delayed: 0,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 40),
                                      Hero(
                                        tag: "vocabulary",
                                        child: CardTitle(
                                          color: AppColors.secondaryColor,
                                          text: "Vocabulary",
                                          alignment: Alignment.topCenter,
                                          top: -25,
                                          left: 75,
                                          onPress: (String value) {
                                            Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => Vocabulary(),
                                            ));
                                          },
                                          circleColor: Color(0xffFC7C1D),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Hero(
                                        tag: "phrase",
                                        child: CardTitle(
                                          color: AppColors.blue,
                                          text: "Phrases",
                                          alignment: Alignment.centerLeft,
                                          left: -25,
                                          top: 30,
                                          circleColor: Color(0xff6278E3),
                                          onPress: (String value) {
                                            Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => PhraseVerb(),
                                            ));
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                FaSlideAnimation(
                                  delayed: 250,
                                  child: Column(
                                    children: <Widget>[
                                      Hero(
                                        tag: "grammar",
                                        child: CardTitle(
                                          color: AppColors.blueBold,
                                          text: "Grammar",
                                          alignment: Alignment.topRight,
                                          right: 25,
                                          top: -25,
                                          circleColor: Color(0xff516AE2),
                                          onPress: (String value) {
                                            Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => Grammar(),
                                            ));
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Hero(
                                        tag: "indiom",
                                        child: CardTitle(
                                          color: AppColors.primaryColor,
                                          text: "Idioms",
                                          alignment: Alignment.bottomRight,
                                          bottom: -25,
                                          left: 75,
                                          circleColor: Color(0xffFDC17C),
                                          onPress: (String value) {
                                            Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => Indiom(),
                                            ));
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Your test',
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 2,
                                          offset: Offset(2, 2),
                                          color: Colors.black12.withOpacity(0.5),
                                        )
                                      ],
                                    ),
                                    child: TextResponsive(
                                      "Comming soon",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
