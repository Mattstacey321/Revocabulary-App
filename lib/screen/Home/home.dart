import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:revocabulary/screen/Home/card.dart';
import 'package:revocabulary/screen/Saved/saved.dart';
import 'package:revocabulary/screen/Vocabulary/vocabulary.dart';
import 'package:revocabulary/values/AppColors.dart';
import 'package:revocabulary/values/AppConstraint.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[Home(), Saved()];
  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = AppConstraint.getScreenSize(context);
    return Scaffold(
            bottomNavigationBar: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))]),
              child: SafeArea(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Stack(
                        children: <Widget>[
                          GNav(
                            gap: 0,
                            activeColor: AppColors.primaryColor,
                            iconSize: 24,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            duration: Duration(milliseconds: 800),
                            tabs: [
                              GButton(icon: FeatherIcons.home, text: ""),
                              GButton(icon: FeatherIcons.heart, text: ""),
                            ],
                            selectedIndex: _selectedIndex,
                            onTabChange: (index) {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Material(
                                color: Colors.transparent,
                                clipBehavior: Clip.antiAlias,
                                type: MaterialType.circle,
                                child: IconButton(
                                  icon: Icon(FeatherIcons.plusSquare),
                                  onPressed: () {},
                                )),
                          ),
                        ],
                      ))),
            ),
            body: Container(
                height: screenSize.height,
                width: screenSize.width,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/pngs/home.png"),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.white.withOpacity(0.5), BlendMode.dstATop))),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Hey, User",
                                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10000),
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) => Container(
                                          height: 50,
                                          width: 50,
                                          color: Colors.grey,
                                        ),
                                        height: 50,
                                        width: 50,
                                        imageUrl: "https://picsum.photos/300",
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: screenSize.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                  child: Text(
                                'What you want \nto learn ?',
                                maxLines: 2,
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                              )),
                              Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      SizedBox(height: 40),
                                      CardTitle(
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
                                      SizedBox(height: 20),
                                      CardTitle(
                                        color: AppColors.blue,
                                        text: "Phrases",
                                        alignment: Alignment.centerLeft,
                                        left: -25,
                                        top: 30,
                                        circleColor: Color(0xff6278E3),
                                        onPress: (String value) {
                                          Fluttertoast.showToast(
                                              msg: "WIP", gravity: ToastGravity.BOTTOM);
                                        },
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: <Widget>[
                                      CardTitle(
                                        color: AppColors.blueBold,
                                        text: "Grammar",
                                        alignment: Alignment.topRight,
                                        right: 25,
                                        top: -25,
                                        circleColor: Color(0xff516AE2),
                                        onPress: (String value) {
                                          Fluttertoast.showToast(
                                              msg: "WIP", gravity: ToastGravity.BOTTOM);
                                        },
                                      ),
                                      SizedBox(height: 20),
                                      CardTitle(
                                        color: AppColors.primaryColor,
                                        text: "Idioms",
                                        alignment: Alignment.bottomRight,
                                        bottom: -25,
                                        left: 75,
                                        circleColor: Color(0xffFDC17C),
                                        onPress: (String value) {
                                          Fluttertoast.showToast(
                                              msg: "WIP", gravity: ToastGravity.BOTTOM);
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
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
                                child: Text(
                                  "Comming soon",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ))
                            ],
                          ),
                        ))
                  ],
                )));
  }
}
