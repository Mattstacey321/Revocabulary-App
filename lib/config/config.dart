
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLClient get mainAPI {
  HttpLink httpLink = HttpLink(
      uri: "https://revocabulary.glitch.me/graphql");
 
  return GraphQLClient(
      cache: NormalizedInMemoryCache(dataIdFromObject: typenameDataIdFromObject),
      link: httpLink,
    );
  
}
ValueNotifier<GraphQLClient> customClient(String token){
Link httpLink = HttpLink(uri: "https://revocabulary.glitch.me/graphql");
 var client = ValueNotifier(GraphQLClient(
      cache: NormalizedInMemoryCache(dataIdFromObject: typenameDataIdFromObject), link: httpLink));
return client;
}
