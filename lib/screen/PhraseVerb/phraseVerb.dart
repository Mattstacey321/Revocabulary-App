import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:revocabulary/config/Query.dart';
import 'package:revocabulary/screen/PhraseVerb/phraseProvider.dart';
import 'package:revocabulary/values/AppColors.dart';
import 'package:revocabulary/values/AppConstraint.dart';
import 'package:revocabulary/widget/circleIcon.dart';
import 'package:revocabulary/widget/faslideAnimation.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class PhraseVerb extends StatefulWidget {
  @override
  PhraseVerbState createState() => PhraseVerbState();
}

class PhraseVerbState extends State<PhraseVerb> {
  var query = GraphQLQuery();
  PhraseProvider phraseProvider;
  ScrollController scrollController;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        loadMore();
      });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      phraseProvider.initLoad();
    });
  }

  void loadMore() {
    /*if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (!phraseProvider.fetchError) {
        phraseProvider.load(phraseProvider.nextPage, "");
      }
    }*/
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      phraseProvider.loadMore();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    phraseProvider = Injector.get(context: context);
    var screenSize = AppConstraint.getScreenSize(context);
    var phrases = phraseProvider.phrases;
    final double itemHeight = (screenSize.height - kToolbarHeight - 24) / 2;
    final double itemWidth = screenSize.width / 2;
    return Hero(
      tag: "phrase",
      child: Scaffold(
          appBar: PreferredSize(
              child: Row(
                children: <Widget>[
                  CircleIcon(
                    icon: FeatherIcons.arrowLeft,
                    iconSize: 30,
                    onTap: () {
                      phraseProvider.clear();
                      Navigator.pop(context);
                    },
                    iconColor: AppColors.primaryColor,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Phrase Vebs",
                    style: TextStyle(
                        color: AppColors.primaryColor, fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              preferredSize: Size.fromHeight(40)),
          body: NotificationListener(
            onNotification: (ScrollNotification sn) {
              if (sn is ScrollUpdateNotification &&
                  sn.metrics.pixels == sn.metrics.maxScrollExtent) {
                phraseProvider.loadMore();
              }
              return true;
            },
            child: phraseProvider.phrases.isEmpty
                ? buildLoadMore()
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: RefreshIndicator(
                      onRefresh: () => phraseProvider.reload(),
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => FaSlideAnimation(
                                delayed: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.secondaryColor),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            phrases[index].phrase,
                                            style: TextStyle(
                                                fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      phrases[index].wordType == "" ? Text(
                                        "${phrases[index].wordType} (v)",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ) : Text(
                                        "(${phrases[index].wordType})",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Text(
                                        phrases[index].meaning[0],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              childCount: phraseProvider.phrases.length,
                              addAutomaticKeepAlives: true,
                              addRepaintBoundaries: true,
                              addSemanticIndexes: true,
                            ),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 30,
                                crossAxisSpacing: 20,
                                crossAxisCount: 2,
                                childAspectRatio: itemHeight / itemWidth),
                          ),
                          if (phraseProvider.isLoading)
                            SliverToBoxAdapter(
                              child: buildLoadMore(),
                            ),
                        ],
                      ),
                    ),
                  ),
          )

          /* Container(
              height: screenSize.height,
              width: screenSize.width,
              padding: EdgeInsets.all(10),
              child: phraseProvider.phrases.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () => phraseProvider.reload(),
                      child: GridView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.all(20),
                        itemCount: phraseProvider.hasNext
                            ? phraseProvider.phrases.length
                            : phraseProvider.phrases.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            crossAxisCount: 2,
                            childAspectRatio: itemHeight / itemWidth),
                        itemBuilder: (context, index) => FaSlideAnimation(
                              delayed: 200,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.secondaryColor),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        phrases[index].phrase,
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ))*/

          ),
    );
  }
}

Widget buildLoadMore() {
  return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(),
        ),
      ));
}
