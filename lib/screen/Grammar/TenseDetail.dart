import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:revocabulary/class/Tense.dart';
import 'package:revocabulary/config/Query.dart';
import 'package:revocabulary/config/config.dart';
import 'package:revocabulary/values/AppColors.dart';
import 'package:revocabulary/values/AppConstraint.dart';
import 'package:revocabulary/widget/circleIcon.dart';
import 'package:revocabulary/widget/exampleWidget.dart';

class TenseDetail extends StatefulWidget {
  final String type;
  TenseDetail({this.type});
  @override
  _TenseDetailState createState() => _TenseDetailState();
}

class _TenseDetailState extends State<TenseDetail> {
  var query = GraphQLQuery();
  var titleStyle =
      TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: AppColors.secondaryColor);
  var contentStyle = TextStyle(fontSize: 20);

  String fitText(String text) {
    return """${text.replaceRange(0, 1, text[0].toUpperCase())}""";
  }

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
                            "1. Define:",
                            style: titleStyle,
                          ),
                          Text(
                            fitText(tense.definition),
                            style: contentStyle,
                          ),
                          Text(
                            "2. Structure:",
                            style: titleStyle,
                          ),
                          for (var index = 0; index < tense.structure.length - 1; index++)
                            Column(
                             
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(fitText(tense.structure[index].type) ?? "Hello",
                                        style: contentStyle),
                                  ],
                                ),
                                Text(
                                  tense.structure[index].formula,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                )
                              ],
                            ),
                          Text(
                            "3. Usage:",
                            style: titleStyle,
                          ),
                          ExampleWidget(
                            object: tense.usage,
                          ),
                          Text(
                            "4. Hint:",
                            style: titleStyle,
                          ),
                          ExampleWidget(
                            object: tense.hint,
                          ),
                          tense.rule.length > 0
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      "5. Rule:",
                                      style: titleStyle,
                                    ),
                                    ExampleWidget(
                                      object: tense.rule,
                                    )
                                  ],
                                )
                              : Container(),
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
