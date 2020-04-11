import 'package:equatable/equatable.dart';

class Word extends Equatable {
  final String id;
  final String word;
  final List meaning;
  final List example;
  final String phonetic;
  final String wordType;
  final String audio;
  final String imageExample;
  final List synonym;
  final List partOfSpeech;
  Word(
      {this.id,
      this.audio,
      this.example,
      this.imageExample,
      this.meaning,
      this.partOfSpeech,
      this.phonetic,
      this.synonym,
      this.word,
      this.wordType});
  Map<String, dynamic> toJson() {
    return {
      "word": word,
      "audio": audio,
      "meaning": meaning,
      "example": example,
      "phonetic": phonetic,
      "wordType": wordType,
      "imageExample": imageExample,
      "synonym": synonym,
      "partOfSpeech": partOfSpeech
    };
  }

  @override
  List<Object> get props => [word, meaning, example];
  factory Word.fromJson(Map item) {
    try {
      return Word(
        word: item['word'],
        meaning: item['meaning'] as List,
        imageExample: item['image_example'] ,
        phonetic: item['phonetic'],
        audio: item['audio'] ,
        example: item['example'] ,
        wordType: item['word_type'] ,
        synonym: item['synonym']);
    } catch (e) {
      return Word();
    }
  }
}

class Words {
  List<Word> words;
  String next;
  String previous;
  Words({this.words, this.next, this.previous});
  factory Words.fromJson(Map json) {
    try {
      var getWord = json['fetchWords'];
      var nextPage = getWord['next'];
      var previousPage = getWord['previous'];
      var words = <Word>[];
      for (var item in getWord['docs']) {
        words.add(Word(
            id: item['_id'],
            word: item['word'],
            meaning: item['meaning'] as List,
            imageExample: item['image_example'] == null ? "" : item['image_example'],
            phonetic: item['phonetic'] == null ? "" : item['phonetic'],
            audio: item['audio'] == null ? "" : item['audio'],
            example: item['example'] == null ? [] : item['example'],
            wordType: item['word_type'] == null ? "" : item['word_type'],
            synonym: item['synonym'] == null ? [] : item['synonym']));
      }
      return Words(words: words, next: nextPage, previous: previousPage);
    } catch (e) {
      print(e);
      return Words(words: [], next: "", previous: "");
    }
  }
}
