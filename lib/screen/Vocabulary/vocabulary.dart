import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:revocabulary/class/Word.dart';
import 'package:revocabulary/config/Query.dart';
import 'package:revocabulary/config/config.dart';
import 'package:revocabulary/screen/Vocabulary/wordProvider.dart';
import 'package:revocabulary/util/skeleton_template.dart';
import 'package:revocabulary/util/word_type.dart';
import 'package:revocabulary/values/AppColors.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class Vocabulary extends StatefulWidget {
  @override
  _VocabularyState createState() => _VocabularyState();
}

class _VocabularyState extends State<Vocabulary> {
  ScrollController _scrollController;

  String nextPage = "";
  WordProvider wordProvider;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;
        if (currentScroll == maxScroll) {
          print(wordProvider.reachedEnd);
          if (wordProvider.reachedEnd) {
            return;
          } else
            wordProvider.loadMore();
        }
      });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      wordProvider.initLoad();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    wordProvider = Injector.get(context: context);
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
                                      wordProvider.listWords[index].word,
                                      wordProvider.listWords[index].meaning[0],
                                      "");
                            },
                            // add more 1 to make space for loading icon
                            itemCount: wordProvider.next == ""
                                ? wordProvider.listWords.length
                                : wordProvider.listWords.length + 1,
                            controller: _scrollController,
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

Widget buildWordItem(BuildContext context, String id, String word, String meaning, String audio) {
  GraphQLQuery query = GraphQLQuery();
  return InkWell(
    onTap: () {
      showMaterialModalBottomSheet(
          useRootNavigator: true,
          expand: false,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
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
                          Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(20),
                                color: Colors.red,
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SkeletonTemplate.text(40, 200, 15, AppColors.alternativeColor),
                                        SizedBox(height: 10),
                                        SkeletonTemplate.text(30, 200, 15, AppColors.alternativeColor),
                                        SizedBox(height: 10),
                                        SkeletonTemplate.text(30, 50, 15, AppColors.alternativeColor),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: <Widget>[
                                        SkeletonTemplate.image(150, 150, 15, Colors.grey)
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
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 150,
                                      child: ListView.separated(
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
                                                    SkeletonTemplate.text(20, 100, 15, AppColors.secondaryColor),
                                                    SizedBox(height:10),
                                                    SkeletonTemplate.text(20, 100, 15, AppColors.secondaryColor)
                                                  ],
                                                ),
                                              ),
                                          separatorBuilder: (context, index) => SizedBox(width: 50),
                                          itemCount: 3))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  if (result.hasException) {
                  } else {
                    var word = Word.fromJson(result.data['getWord']);
                    return Container(
                      height: MediaQuery.of(context).size.height - 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                        color: AppColors.secondaryColor,
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          word.word,
                                          style: TextStyle(fontSize: 40, color: Colors.white),
                                        ),
                                        SizedBox(height: 10),
                                        Text(word.phonetic,
                                            style: TextStyle(fontSize: 20, color: Colors.white)),
                                        SizedBox(height: 10),
                                        Container(
                                          height: 40,
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: AppColors.primaryColor),
                                          child: Text(wordType(word.wordType),
                                              style: TextStyle(fontSize: 20, color: Colors.white)),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: <Widget>[
                                        buildExampleImage(150, 150, word.imageExample)
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
                                  buildPartOfSpeech()
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
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.secondaryColor),
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
                    word,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  width: 200,
                  child: Text(
                    meaning,
                    style:
                        TextStyle(fontStyle: FontStyle.italic, color: Colors.white, fontSize: 20),
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
              Container(
                  margin: EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(color: AppColors.alternativeColor, shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(FeatherIcons.play, color: AppColors.secondaryColor),
                    alignment: Alignment.center,
                    onPressed: () {},
                  ))
            ],
          )
        ],
      ),
    ),
  );
}
Widget buildPartOfSpeech(BuildContext context,ScrollController controller){
  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 150,
                                      child: ListView.separated(
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
                                                    SkeletonTemplate.text(20, 100, 15, AppColors.secondaryColor),
                                                    SizedBox(height:10),
                                                    SkeletonTemplate.text(20, 100, 15, AppColors.secondaryColor)
                                                  ],
                                                ),
                                              ),
                                          separatorBuilder: (context, index) => SizedBox(width: 50),
                                          itemCount: 3));
}
Widget buildExampleImage(double height, double width, String url) {
  return CachedNetworkImage(
    fit: BoxFit.cover,
    imageBuilder: (context, imageProvider) => Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), image: DecorationImage(image: imageProvider)),
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
