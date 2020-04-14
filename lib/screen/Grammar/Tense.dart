import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:revocabulary/class/Tense.dart';
import 'package:revocabulary/config/Query.dart';
import 'package:revocabulary/config/config.dart';
import 'package:revocabulary/screen/Grammar/TenseDetail.dart';
import 'package:revocabulary/values/AppColors.dart';
import 'package:revocabulary/values/AppConstraint.dart';
import 'package:revocabulary/widget/circleIcon.dart';

class Tense extends StatefulWidget {
  @override
  _TenseState createState() => _TenseState();
}

class _TenseState extends State<Tense> {
  var query = GraphQLQuery();
  @override
  Widget build(BuildContext context) {
    var screenSize = AppConstraint.getScreenSize(context);
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
                "Tense",
                style: TextStyle(
                    color: AppColors.primaryColor, fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(40)),
      body: Container(
        child: GraphQLProvider(
          client: customClient(),
          child: CacheProvider(
              child: Query(
            options: QueryOptions(documentNode: gql(query.getTenseTitle())),
            builder: (result, {fetchMore, refetch}) {
              if (result.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var tenses = Tenses.fromJson(result.data).tenses;
                return ListView.separated(
                  padding: EdgeInsets.all(20),
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                  itemCount: tenses.length,
                  itemBuilder: (context, index) => Material(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(15),
                    clipBehavior: Clip.antiAlias,
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TenseDetail(type:tenses[index].type),));
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: screenSize.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    tenses[index].type,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                );
              }
            },
          )),
        ),
      ),
    );
  }
}
