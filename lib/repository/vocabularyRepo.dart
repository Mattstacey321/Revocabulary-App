import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:revocabulary/config/config.dart';

class VocabularyRepo{
  static Future<QueryResult> queryGraphQL(String token ,String query){
    GraphQLClient client = mainAPI;
    var result = client.query(QueryOptions(
      documentNode: gql(query)
    ));
    return result;
  }
}