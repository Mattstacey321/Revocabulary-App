import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:revocabulary/class/Word.dart';
import 'package:revocabulary/screen/Dashboard/dashboard.dart';
import 'package:revocabulary/screen/Saved/saved.dart';
import 'package:revocabulary/values/AppColors.dart';
import 'package:revocabulary/values/AppConstraint.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController;
  int _currentIndex = 0;
  List<Widget> _widgetOptions = <Widget>[Dashboard(), Saved()];
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    openHive();
  }
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();

  }
  Future openHive()async{
    await Hive.openBox<Word>('word');
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = AppConstraint.getScreenSize(context);
    ResponsiveWidgets.init(
      context,
      height: screenSize.height,
      width: screenSize.width,
      allowFontScaling: true,
    );
    return ResponsiveWidgets.builder(
      height: screenSize.height,
      width: screenSize.width,
      allowFontScaling: true, 
          child: Scaffold(
          bottomNavigationBar: ContainerResponsive(
            heightResponsive: true,
            widthResponsive: true,
            height: 60,
            width: screenSize.width,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))]),
            child: SafeArea(
                child: Padding(
                    padding: EdgeInsetsResponsive.symmetric(horizontal: 15, vertical: 8),
                    child: Stack(
                      children: <Widget>[
                        GNav(
                          gap: 0,
                          activeColor: AppColors.primaryColor,
                          iconSize: 24,
                          padding:EdgeInsetsResponsive.symmetric(horizontal: 20, vertical: 5),
                          duration: Duration(milliseconds: 800),
                          tabs: [
                            GButton(icon: FeatherIcons.home, text: ""),
                            GButton(icon: FeatherIcons.heart, text: ""),
                          ],
                          selectedIndex: _currentIndex,
                          onTabChange: (index) {
                            setState(() {
                              _currentIndex = index;
                              pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve:  Curves.easeInToLinear);
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
          body: PageView(
            children: _widgetOptions,
            controller: pageController,
            onPageChanged: (index) {
              _currentIndex = index;
            },
          )),
    );
  }
}
