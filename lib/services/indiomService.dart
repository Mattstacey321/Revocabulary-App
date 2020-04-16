import 'package:revocabulary/class/Indiom.dart';
import 'package:revocabulary/config/Query.dart';
import 'package:revocabulary/util/graphql_util.dart';

class IndiomService {
  static Future<Indioms> fetchIndiom(int limit, String nextPage, String previousPage) async {
    GraphQLQuery query = GraphQLQuery();
    var result = await GraphQLUtil.queryGraphQL(query.fetchIndiom(limit, nextPage, previousPage));
    var indioms = Indioms.fromJson(result.data);
    return indioms;
  }
}
