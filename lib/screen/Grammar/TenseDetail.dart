import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:revocabulary/class/Tense.dart';
import 'package:revocabulary/config/Query.dart';
import 'package:revocabulary/config/config.dart';
import 'package:revocabulary/values/AppColors.dart';
import 'package:revocabulary/values/AppConstraint.dart';
import 'package:revocabulary/widget/circleIcon.dart';

class TenseDetail extends StatefulWidget {
  final String type;
  TenseDetail({this.type});
  @override
  _TenseDetailState createState() => _TenseDetailState();
}

class _TenseDetailState extends State<TenseDetail> {
  var query = GraphQLQuery();
  var titleStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.secondaryColor);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: Row(
            children: <Widget>[
              CircleIcon(
                icon: FeatherIcons.arrowLeft,
                iconSize: 30,
                onTap: () {
                  Navigator.pop(context);
                },
                iconColor: AppColors.primaryColor,
              ),
              SizedBox(width: 10),
              Text(
                widget.type,
                style: TextStyle(
                    color: AppColors.primaryColor, fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(40)),
      body: SingleChildScrollView(
        child: Container(
            height: AppConstraint.getScreenSize(context).height,
            child: GraphQLProvider(
              client: customClient(),
              child: CacheProvider(
                  child: Query(
                options: QueryOptions(documentNode: gql(query.getTenseDetail(widget.type))),
                builder: (result, {fetchMore, refetch}) {
                  if (result.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var tense = Tense.fromJson(result.data['getTenseByName']);

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "1./ Define:",
                            style: titleStyle,
                          ),
                          Container(
                            height: 50,
                            child: Text(
                              tense.definition,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "2./ Structure:",
                            style: titleStyle,
                          ),
                          Flexible(
                            child: ListView.builder(
                              itemCount: tense.structure.length,
                              itemBuilder: (context, index) => Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.check_box,
                                        size: 10,
                                      ),
                                      Text(tense.structure[index].type ?? "Hello"),
                                    ],
                                  ),
                                  Text(tense.structure[index].formula)
                                ],
                              ),
                            ),
                          ),
                          Text(
                            "3./ Usage:",
                            style: titleStyle,
                          ),
                          Flexible(
                            child: ListView.builder(
                              itemCount: tense.usage.length,
                              itemBuilder: (context, index) => Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.check_box,
                                        size: 10,
                                      ),
                                      Text(tense.usage[index].title ?? "Hello"),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      for (var item in tense.usage[index].content)
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.check_box,
                                              size: 10,
                                            ),
                                            Text(item)
                                          ],
                                        ),
                                      for (var item in tense.usage[index].example)
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.check_box,
                                              size: 10,
                                            ),
                                            Text(item)
                                          ],
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            "4./ Hint:",
                            style: titleStyle,
                          ),
                          Flexible(
                            child: ListView.builder(
                              itemCount: tense.hint.length,
                              itemBuilder: (context, index) => Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.check_box,
                                        size: 10,
                                      ),
                                      Text(tense.hint[index].title ?? "Hello"),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      for (var item in tense.hint[index].content)
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.check_box,
                                              size: 10,
                                            ),
                                            Text(item)
                                          ],
                                        ),
                                      for (var item in tense.hint[index].example)
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.check_box,
                                              size: 10,
                                            ),
                                            Text(item)
                                          ],
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            "5./ Rule:",
                            style: titleStyle,
                          ),
                          Flexible(
                            child: ListView.builder(
                              itemCount: tense.rule.length,
                              itemBuilder: (context, index) => Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.check_box,
                                        size: 10,
                                      ),
                                      Text(tense.rule[index].title ?? "Hello"),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      for (var item in tense.rule[index].content)
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.check_box,
                                              size: 10,
                                            ),
                                            Text(item)
                                          ],
                                        ),
                                      for (var item in tense.rule[index].example)
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.check_box,
                                              size: 10,
                                            ),
                                            Text(item)
                                          ],
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              )),
            )),
      ),
    );
  }
}
