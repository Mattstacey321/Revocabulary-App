import 'dart:convert';
import 'package:hive/hive.dart';
part 'Word.g.dart';

@HiveType(typeId: 0)
class PartOfSpeech extends HiveObject {
  @HiveField(0)
  String word;
  @HiveField(1)
  String type;
  @HiveField(2)
  String phonetic;
  @HiveField(3)
  String example;
  @HiveField(4)
  PartOfSpeech({this.example, this.phonetic, this.type, this.word});

  Map<String, dynamic> toJson() {
    return {"word": word, "type": type, "phonetic": phonetic, "example": example};
  }
}

@HiveType(typeId: 1)
class Word extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String word;
  @HiveField(2)
  List meaning;
  @HiveField(3)
  List example;
  @HiveField(4)
  String phonetic;
  @HiveField(5)
  String wordType;
  @HiveField(6)
  String audio;
  @HiveField(7)
  String imageExample;
  @HiveField(8)
  List synonym;
  @HiveField(9)
  List<PartOfSpeech> partOfSpeech;
  @HiveField(10)
  List<Word> words;
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
      "partOfSpeech": json.encode(partOfSpeech)
    };
  }

  /*@override
  List<Object> get props => [word, meaning, example];*/
  factory Word.fromJson(Map item) {
    var partOfSpeech = <PartOfSpeech>[];
    item['partOfSpeech'] != null ??
        item['partOfSpeech'].forEach((item) {
          partOfSpeech.add(PartOfSpeech(
              example: item['example'],
              phonetic: item['phonetic'],
              type: item['type'],
              word: item['word']));
        });
    try {
      return Word(
          partOfSpeech: partOfSpeech,
          word: item['word'],
          meaning: item['meaning'],
          imageExample: item['image_example'],
          phonetic: item['phonetic'],
          audio: item['audio'],
          example: item['example'],
          wordType: item['word_type'],
          synonym: item['synonym']);
    } catch (e) {
      print(e);
      return Word();
    }
  }
}

@HiveType(typeId: 2)
class Words extends HiveObject {
  @HiveField(0)
  List<Word> words;
  @HiveField(1)
  String next;
  @HiveField(2)
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
          /*imageExample: item['image_example'] == null ? "" : item['image_example'],
            phonetic: item['phonetic'] == null ? "" : item['phonetic'],
            audio: item['audio'] == null ? "" : item['audio'],
            example: item['example'] == null ? [] : item['example'],
            wordType: item['word_type'] == null ? "" : item['word_type'],
            synonym: item['synonym'] == null ? [] : item['synonym']*/
        ));
      }
      return Words(words: words, next: nextPage, previous: previousPage);
    } catch (e) {
      print(e);
      return Words(words: [], next: "", previous: "");
    }
  }
}
