class GraphQLQuery{
  String fetchWords(int limit,String nextPage,String previousPage) => """
    query{
      fetchWords(limit:$limit,previous:"$previousPage",next:"$nextPage"){
          docs{
            _id
            word
            meaning
            image_example
          }
          next
          previous
        }
    }
  """;
  String getWord(String wordID) => """
    query{
      getWord(wordID:"$wordID"){
          word
          meaning
          phonetic
          example
          word_type
          audio
          synonym
          image_example
          partOfSpeech{
              word
              example
              type
              phonetic
            }
        }
    }

  """;
  String getTenseTitle() => """
    query{
      getTense{
        type
      }
    }
  """;
  String getTenseDetail(String type) => """
    query{
      getTenseByName(type:"$type"){
        type
        definition
        structure{
          type
          formula
          note
        }
        usage{
          title
          content
          example
        }
        hint{
          title
          content
          example
        }
        rule{
          title
          content
          example
        }
     }
  }
    
  """;
  String getTenseByName(String name) => """
    query{
      
    }

  """;
}