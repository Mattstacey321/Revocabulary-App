import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:revocabulary/screen/Home/home.dart';
import 'package:revocabulary/screen/SplashScreen/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget defaultHome  =  SplashScreen();
  SharedPreferences ref = await SharedPreferences.getInstance();
  bool isLogin = ref.getBool('isLogin') != null ?? false;
  if(isLogin){
    defaultHome = Home();
  }
  runApp(MyApp(home: defaultHome));
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  final Widget home;
  MyApp({this.home});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily:"GoogleSans-Regular",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: home,
    );
  }
}
