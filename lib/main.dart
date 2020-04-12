import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revocabulary/screen/Home/home.dart';
import 'package:revocabulary/screen/Saved/SavedWordProvider.dart';
import 'package:revocabulary/screen/SplashScreen/splashScreen.dart';
import 'package:revocabulary/screen/Vocabulary/bloc/listword_bloc.dart';
import 'package:revocabulary/screen/Vocabulary/vocabulary.dart';
import 'package:revocabulary/screen/Vocabulary/wordProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget defaultHome = SplashScreen();
  SharedPreferences ref = await SharedPreferences.getInstance();
  bool isLogin = ref.getBool('isLogin') != null ?? false;
  if (isLogin) {
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
    return MultiBlocProvider(
        providers: [
          BlocProvider<GetWordBloc>(
            create: (context) => GetWordBloc(),
            child: Vocabulary(),
          )
        ],
        child: Injector(inject: [
          Inject(()=>WordProvider()),
          Inject(()=>SavedWordProvider())

        ], builder: (context) => StateBuilder(
          models:[],
          builder: (context, model) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "GoogleSans-Regular",
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: home),
        ),));
  }
}
