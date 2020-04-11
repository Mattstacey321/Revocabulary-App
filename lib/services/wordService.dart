import 'package:revocabulary/class/Word.dart';
import 'package:revocabulary/config/Query.dart';
import 'package:revocabulary/util/graphql_util.dart';

class WordService {
  static Future<Words> fetchWord(int limit, String nextPage, String previousPage) async {
    GraphQLQuery query = GraphQLQuery();
    var result = await GraphQLUtil.queryGraphQL(query.fetchWords(limit, nextPage, previousPage));
    var listWord = Words.fromJson(result.data);
    return listWord;
  }
}
