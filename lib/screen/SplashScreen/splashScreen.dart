import 'package:flutter/material.dart';
import 'package:revocabulary/screen/Home/home.dart';
import 'package:revocabulary/screen/SplashScreen/logo.dart';
import 'package:revocabulary/values/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController slideAnimation;
  Animation<Offset> animation;
  @override
  void initState() {
    super.initState();
    slideAnimation = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween<Offset>(begin: Offset(10, 20), end: Offset(15, 25))
        .animate(CurvedAnimation(parent: slideAnimation, curve: Curves.fastOutSlowIn));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration:
            BoxDecoration(image: DecorationImage(image: AssetImage("assets/pngs/splashscreen.png"))),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 1,),
            Logo(animation: animation, slideAnimation: slideAnimation),
            Spacer(flex: 1,),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  height: 50,
                  width: 200,
                  child: InkWell(
                        onTap: () async{
                          SharedPreferences ref=  await SharedPreferences.getInstance();
                          ref.setBool("isLogin", true);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(),));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            alignment: Alignment.center,
                            color: AppColors.primaryColor,
                            child: Text("Get Started",style:TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
