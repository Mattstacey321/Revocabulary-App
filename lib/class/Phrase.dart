class Phrase {
  String phrase;
  String wordType;
  List synonym;
  List meaning;
  String example;
  Phrase({this.phrase, this.wordType, this.meaning, this.example, this.synonym});
}

class Phrases {
  List<Phrase> phrases;
  String next;
  String previous;
  Phrases({this.phrases,this.next,this.previous});
  factory Phrases.fromJson(Map json) {
    var phrases = <Phrase>[];
    var next = json['fetchPhrase']['next'] ?? "";
    var previous = json['fetchPhrase']['previous'] ?? "";
    try {
      
      for (var item in json['fetchPhrase']['docs']){
        phrases.add(Phrase(
            phrase: item['phrase'],
            example: item['example'],
            meaning: item['meaning'],
            wordType: item['word_type'],
            synonym: item['synonym']));
      
      }
    } catch (e) {
      return Phrases(phrases: [],next: "",previous: "");
    }
    return Phrases(phrases: phrases,next: next,previous: previous);
  }
}
