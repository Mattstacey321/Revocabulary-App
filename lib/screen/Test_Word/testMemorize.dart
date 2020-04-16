import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hive/hive.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:revocabulary/class/Word.dart';
import 'package:revocabulary/screen/Test_Word/testProvider.dart';
import 'package:revocabulary/values/AppColors.dart';
import 'package:revocabulary/values/AppConstraint.dart';
import 'package:revocabulary/widget/circleIcon.dart';
import 'package:revocabulary/widget/faslideAnimation.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class TestYourMemorize extends StatefulWidget {
  @override
  _TestYourMemorizeState createState() => _TestYourMemorizeState();
}

class _TestYourMemorizeState extends State<TestYourMemorize> with TickerProviderStateMixin {
  TestProvider testProvider;
  Box<Word> word;
  CarouselSlider carouselSlider;
  AnimationController animationController;
  Animation<Offset> animation;
  @override
  void initState() {
    super.initState();
    word = Hive.box("word");
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(begin: Offset(1, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  double getPercent(int total, int index) {
    return (100 / total * index) / 100;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = AppConstraint.getScreenSize(context);
    testProvider = Injector.get(context: context);

    return Scaffold(
      body: ContainerResponsive(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsetsResponsive.only(right: 10),
                height: 50,
                width: screenSize.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleIcon(
                      iconSize: 30,
                      icon: FeatherIcons.arrowLeft,
                      iconColor: AppColors.primaryColor,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextResponsive(
                      "Test",
                      style: TextStyle(fontSize: 30, color: AppColors.primaryColor),
                    ),
                    //update value
                    ContainerResponsive(
                      height: 12,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                            backgroundColor: AppColors.secondaryColor,
                            value: getPercent(word.length,
                                testProvider.currentIndex + 1) //(100 / word.length * 3) / 100,
                            ),
                      ),
                    ),
                    //Text("${testProvider.currentIndex}/ ${word.length}",style: TextStyle(fontSize: 25, color: AppColors.primaryColor))
                  ],
                ),
              ),
            ),
            FaSlideAnimation(
              delayed: 500,
              child: carouselSlider = CarouselSlider.builder(
                enableInfiniteScroll: false,
                height: screenSize.height / 2,
                itemCount: word.length,
                enlargeCenterPage: true,
                onPageChanged: (index) {
                  print(index);
                  animationController.reverse();
                  testProvider.setIndex(index);
                },
                itemBuilder: (context, index) => ContainerResponsive(
                  margin: EdgeInsetsResponsive.all(20),
                  width: screenSize.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.alternativeColor, borderRadius: BorderRadius.circular(15)),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        top: screenSize.height * 0.1,
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: TextResponsive(
                              word
                                  .getAt(index)
                                  .word
                                  .replaceRange(0, 1, word.getAt(index).word[0].toUpperCase()),
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor),
                            )),
                      ),
                      Positioned(
                          top: screenSize.height * 0.2,
                          left: screenSize.width / 2 * 0.60,
                          child: Align(
                            alignment: Alignment.center,
                            child: CircleIcon(
                              onTap: () {},
                              iconColor: AppColors.primaryColor,
                              iconSize: 30,
                              icon: FeatherIcons.volume2,
                            ),
                          )),
                      Positioned(
                          bottom: 10,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ContainerResponsive(
                              padding: EdgeInsetsResponsive.symmetric(horizontal: 20),
                              width: screenSize.width / 1.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      CircleIcon(
                                        onTap: () {},
                                        iconColor: AppColors.primaryColor,
                                        iconSize: 30,
                                        icon: FeatherIcons.chevronLeft,
                                      ),
                                      Text("Learn", style: TextStyle(fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      CircleIcon(
                                        iconColor: AppColors.primaryColor,
                                        iconSize: 30,
                                        icon: FeatherIcons.archive,
                                        onTap: () {
                                          animationController.isCompleted
                                              ? animationController.reverse()
                                              : animationController.forward();
                                        },
                                      ),
                                      TextResponsive("Show meaning",
                                          style: TextStyle(fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      CircleIcon(
                                        iconColor: AppColors.primaryColor,
                                        iconSize: 30,
                                        icon: FeatherIcons.chevronRight,
                                        onTap: () {
                                          carouselSlider.animateToPage(index + 1,
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.fastOutSlowIn);
                                        },
                                      ),
                                      TextResponsive(
                                        "I know",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SlideTransition(
                position: animation,
                child: Padding(
                  padding: EdgeInsetsResponsive.all(20.0),
                  child: ContainerResponsive(
                    alignment: Alignment.center,
                    width: screenSize.width,
                    child: ContainerResponsive(
                      alignment: Alignment.center,
                      height: 200,
                      width: screenSize.width / 1.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Color(0xffFFF2CC), Color(0xffFDC17C)])),
                      child: Text(word.getAt(testProvider.currentIndex).meaning[0],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30, color: AppColors.primaryColor)),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
