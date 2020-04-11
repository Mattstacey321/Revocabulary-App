import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:revocabulary/config/config.dart';
class GraphQLUtil{
  static Future<QueryResult> queryGraphQL(String query){
    GraphQLClient client = mainAPI;
    var result = client.query(QueryOptions(
      documentNode: gql(query)
    ));
    return result;
  }
  static Future<QueryResult> mutateGraphQL(String mutation){
    GraphQLClient client = mainAPI;
    var result = client.mutate(MutationOptions(
      documentNode: gql(mutation)
    ));
    return result;
  }
}