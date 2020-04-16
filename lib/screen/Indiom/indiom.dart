import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:revocabulary/screen/Indiom/indiomProvider.dart';
import 'package:revocabulary/values/AppColors.dart';
import 'package:revocabulary/values/AppConstraint.dart';
import 'package:revocabulary/widget/circleIcon.dart';
import 'package:revocabulary/widget/faslideAnimation.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class Indiom extends StatefulWidget {
  @override
  _IndiomState createState() => _IndiomState();
}

class _IndiomState extends State<Indiom> {
  IndiomProvider indiomProvider;
  ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController() ..addListener(() {loadMore();});
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      indiomProvider.initLoad();
    });
  }
  void loadMore(){
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      indiomProvider.loadMore();
    }
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = AppConstraint.getScreenSize(context);
    indiomProvider = Injector.get(context: context);
    var indioms = indiomProvider.indioms;
    return Hero(
      tag: "indiom",
      child: Scaffold(
          appBar: PreferredSize(
              child: Row(
                children: <Widget>[
                  CircleIcon(
                    icon: FeatherIcons.arrowLeft,
                    iconColor: AppColors.primaryColor,
                    iconSize: 30,
                    onTap: () {
                      indiomProvider.clearResult();
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Indioms",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30, color: AppColors.primaryColor),
                  )
                ],
              ),
              preferredSize: Size.fromHeight(40)),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            width: screenSize.width,
            height: screenSize.height,
            child: RefreshIndicator(
              onRefresh: () => indiomProvider.reload(),
              child: indioms.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      controller: scrollController,
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      itemCount: indiomProvider.next == ""
                                  ? indiomProvider.indioms.length
                                  : indiomProvider.indioms.length + 1,
                      itemBuilder: (context, index) => index >= indioms.length
                          ? indiomProvider.next == "" ? Text("No more result !") :buildLoadMore()
                          : FaSlideAnimation(
                              delayed: 100,
                              child: Container(
                                height: 100,
                                width: screenSize.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.alternativeColor),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                        top: -10,
                                        left: 10,
                                        child: Icon(
                                          Icons.format_quote,
                                          color: AppColors.primaryColor,
                                          size: 35,
                                        )),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              indioms[index].indiom,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenSize.aspectRatio * 35,
                                              ),
                                            ),
                                            Text(indioms[index].meaningInVn,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: screenSize.aspectRatio * 25,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
            ),
          )),
    );
  }
}
Widget buildLoadMore() {
  return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(),
        ),
      ));
}