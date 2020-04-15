import 'package:revocabulary/class/Phrase.dart';
import 'package:revocabulary/config/Query.dart';
import 'package:revocabulary/util/graphql_util.dart';

class PhraseService {
  static Future<Phrases> fetchPhrase(int limit, String nextPage, String previousPage) async {
    GraphQLQuery query = GraphQLQuery();
    var result = await GraphQLUtil.queryGraphQL(query.fetchPhrase(limit, nextPage, previousPage));
    var phrases = Phrases.fromJson(result.data);
    return phrases;
  }
}
