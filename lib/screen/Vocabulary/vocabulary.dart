import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:revocabulary/class/Word.dart';
import 'package:revocabulary/config/Query.dart';
import 'package:revocabulary/config/config.dart';
import 'package:revocabulary/screen/Saved/SavedWordProvider.dart';
import 'package:revocabulary/screen/Vocabulary/wordProvider.dart';
import 'package:revocabulary/util/skeleton_template.dart';
import 'package:revocabulary/util/word_type.dart';
import 'package:revocabulary/values/AppColors.dart';
import 'package:revocabulary/widget/circleIcon.dart';
import 'package:revocabulary/widget/faslideAnimation.dart';
import 'package:revocabulary/widget/saveButton.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class Vocabulary extends StatefulWidget {
  @override
  _VocabularyState createState() => _VocabularyState();
}

class _VocabularyState extends State<Vocabulary> {
  ScrollController _scrollController;
  WordProvider wordProvider;
  SavedWordProvider savedWordProvider;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        loadMore();
      });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      wordProvider.initLoad();
    });
  }

  void loadMore() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      print(wordProvider.reachedEnd);
      if (wordProvider.reachedEnd) {
        return;
      } else
        wordProvider.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    wordProvider = Injector.get(context: context);
    savedWordProvider = Injector.get(context: context);
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Vocabulary", style: TextStyle(color: AppColors.primaryColor, fontSize: 40)),
                  Spacer(),
                  Material(
                      clipBehavior: Clip.antiAlias,
                      type: MaterialType.circle,
                      color: Colors.transparent,
                      child: IconButton(
                          icon: Icon(
                            FeatherIcons.sliders,
                            color: AppColors.primaryColor,
                            size: 25,
                          ),
                          onPressed: () {}))
                ],
              ),
            ),
            wordProvider.listWords.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : wordProvider.fetchError
                    ? Text("Fetch error")
                    : Expanded(
                        child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: RefreshIndicator(
                          onRefresh: () => wordProvider.refresh(),
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              height: 20,
                            ),
                            itemBuilder: (context, index) {
                              return index >= wordProvider.listWords.length
                                  ? wordProvider.next == ""
                                      ? Text("You reach end")
                                      : buildLoadMore()
                                  : buildWordItem(
                                      context,
                                      wordProvider.listWords[index].id,
                                      wordProvider.listWords[index],
                                      wordProvider.listWords[index].meaning[0],
                                      "",
                                      savedWordProvider);
                            },
                            // add more 1 to make space for loading icon
                            itemCount: wordProvider.next == ""
                                ? wordProvider.listWords.length
                                : wordProvider.listWords.length + 1,
                            controller: _scrollController,
                            addAutomaticKeepAlives: true,
                          ),
                        ),
                      ))
          ],
        ),
      ),
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

Widget buildWordItem(BuildContext context, String id, Word word, String meaning, String audio,
    SavedWordProvider savedWordProvider) {
  GraphQLQuery query = GraphQLQuery();
  var screenSize = MediaQuery.of(context).size;
  bool save = false;
  return FaSlideAnimation(
    delayed: 200,
    child: Material(
      color: AppColors.secondaryColor,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          showMaterialModalBottomSheet(
              enableDrag: false,
              useRootNavigator: true,
              expand: false,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15), topRight: Radius.circular(15))),
              backgroundColor: AppColors.secondaryColor,
              context: context,
              builder: (context, controller) {
                return GraphQLProvider(
                  client: customClient(),
                  child: CacheProvider(
                      child: Query(
                    options: QueryOptions(documentNode: gql(query.getWord(id))),
                    builder: (result, {fetchMore, refetch}) {
                      if (result.loading) {
                        return Container(
                          height: MediaQuery.of(context).size.height - 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                          ),
                          child: Column(
                            children: <Widget>[
                              //image with height
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            SkeletonTemplate.text(
                                                40, 200, 15, AppColors.alternativeColor),
                                            SizedBox(height: 10),
                                            SkeletonTemplate.text(
                                                30, 200, 15, AppColors.alternativeColor),
                                            SizedBox(height: 10),
                                            SkeletonTemplate.text(
                                                30, 100, 15, AppColors.alternativeColor),
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          children: <Widget>[
                                            SkeletonTemplate.image(
                                                120, 120, 15, AppColors.alternativeColor)
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                flex: 6,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    children: <Widget>[
                                      // partof speech
                                      Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 150,
                                          child: ListView.separated(
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              controller: controller,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) => Container(
                                                    alignment: Alignment.center,
                                                    height: 150,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15),
                                                        color: AppColors.alternativeColor),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        SkeletonTemplate.text(
                                                            20, 80, 15, AppColors.secondaryColor),
                                                        SizedBox(height: 10),
                                                        SkeletonTemplate.text(
                                                            20, 100, 15, AppColors.secondaryColor)
                                                      ],
                                                    ),
                                                  ),
                                              separatorBuilder: (context, index) =>
                                                  SizedBox(width: 50),
                                              itemCount: 3)),
                                      // synonym and example
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        child: Container(
                                          width: screenSize.width,
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: AppColors.alternativeColor),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              // example
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    SkeletonTemplate.text(
                                                        30, 200, 15, AppColors.secondaryColor),
                                                    SizedBox(height: 20),
                                                    SkeletonTemplate.text(30, screenSize.width, 15,
                                                        AppColors.secondaryColor),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              // synonym
                                              Expanded(
                                                  flex: 5,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      SkeletonTemplate.text(
                                                          30, 200, 15, AppColors.secondaryColor),
                                                      SizedBox(height: 20),
                                                      SkeletonTemplate.text(
                                                          30, 200, 15, AppColors.secondaryColor),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      if (result.hasException) {
                        print(result.exception);
                        return Container();
                      } else {
                        var word = Word.fromJson(result.data['getWord']);
                        return Container(
                          height: MediaQuery.of(context).size.height - 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                          ),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                    child: Row(
                                      children: <Widget>[
                                        buildWordAndImage(word),
                                        Spacer(),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            buildExampleImage(120, 120, word.imageExample)
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                flex: 6,
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      buildPartOfSpeech(context, controller, word),
                                      buildExampleAndSynonym(screenSize.width, word)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    },
                  )),
                );
              });
        },
        child: Container(
          padding: EdgeInsets.all(10),
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  offset: Offset(1, 2),
                  color: AppColors.secondaryColor.withOpacity(0.2))
            ],
          ),
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        word.word,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Container(
                      width: 200,
                      child: Text(
                        meaning,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white, fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                      ),
                    ),
                  )
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SaveButton(
                    darkColor: AppColors.primaryColor,
                    lightColor: AppColors.alternativeColor,
                    iconSize: 35,
                    wordID: word.id,
                    saved: false,
                    onSaved: (value) async {
                      !value ? savedWordProvider.addToSaved(word) : null;
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildWordAndImage(Word word) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        word.word,
        style: TextStyle(fontSize: 40, color: Colors.white),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(word.phonetic,
              style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: "Roboto")),
          CircleIcon(
            icon: FeatherIcons.volume2,
            iconSize: 20,
            onTap: () async {
              AudioPlayer player = AudioPlayer();
              await player.play(word.audio);
            },
          )
        ],
      ),
      SizedBox(height: 10),
      Container(
        height: 40,
        width: 100,
        alignment: Alignment.center,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.primaryColor),
        child: Text(wordType(word.wordType), style: TextStyle(fontSize: 20, color: Colors.white)),
      )
    ],
  );
}

Widget buildExampleAndSynonym(double width, Word word) {
  return Expanded(
      child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Container(
      width: width,
      padding: EdgeInsets.all(20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.alternativeColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Example:",
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.secondaryColor),
                ),
                SizedBox(height: 10),
                // item with dot
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 7,
                      height: 7,
                      decoration:
                          BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      width: width - 80,
                      child: Text(
                        word.example[0],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontStyle: FontStyle.italic,
                            fontSize: 25),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Spacer(),
          Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Synonym:",
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.secondaryColor),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      spacing: 20,
                      runSpacing: 20,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        for (var item in word.synonym)
                          Container(
                            alignment: Alignment.center,
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.secondaryColor),
                            child: Text(item,
                                style: TextStyle(
                                    fontSize: 25,
                                    color: AppColors.primaryColor,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold)),
                          )
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    ),
  ));
}

Widget buildPartOfSpeech(BuildContext context, ScrollController controller, Word word) {
  return word.partOfSpeech[0].word == null
      ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: BoxDecoration(
                color: AppColors.alternativeColor, borderRadius: BorderRadius.circular(15)),
            child: Text("No word match !",
                style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold, color: AppColors.secondaryColor)),
          ),
        )
      : Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10),
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                    alignment: Alignment.center,
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15), color: AppColors.alternativeColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(word.partOfSpeech[index].word,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor)),
                        SizedBox(height: 10),
                        Text(
                          "${word.partOfSpeech[index].type}.",
                          style: TextStyle(fontSize: 20, color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
              separatorBuilder: (context, index) => SizedBox(width: 50),
              itemCount: word.partOfSpeech.length));
}

Widget buildExampleImage(double height, double width, String url) {
  return CachedNetworkImage(
    fit: BoxFit.cover,
    imageBuilder: (context, imageProvider) => Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
    ),
    placeholder: (context, url) => Container(
      height: height,
      width: width,
      decoration:
          BoxDecoration(color: AppColors.alternativeColor, borderRadius: BorderRadius.circular(15)),
    ),
    imageUrl: url,
  );
}
