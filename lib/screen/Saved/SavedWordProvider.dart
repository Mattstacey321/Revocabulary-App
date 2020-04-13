import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:revocabulary/class/Word.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class SavedWordProvider extends StatesRebuilder {
  var words = <Word>[];
  bool checkExist(String word) {
    for (var e in words) {
      if (e.word == word) {
        return true;
      }
    }
    return false;
  }

  Future<Box<Word>> readFromLocal() async {
    /*SharedPreferences ref = await SharedPreferences.getInstance();
    for (var item in ref.getStringList("savedList")) {
      var word = Word.fromJson(json.decode(item));
      if(words.isEmpty){
        words.add(word) ;
      }
      else{
        print(checkExist(word.word));
        checkExist(word.word) ? null : words.add(word);
      }
  
    }
    print(words);*/
    var wordBox = await Hive.openBox<Word>('word');

    return wordBox;
  }

  void addToSaved(Word word) async {
    //words.clear();
    print(word.word);
    /* SharedPreferences ref = await SharedPreferences.getInstance();
    if (ref.containsKey("savedList")) {
      var words = ref.getStringList("savedList");

      words.add(json.encode(word));
      ref.setStringList("savedList", words);
    } else
      ref.setStringList("savedList", [json.encode(word)]);*/
    try {
      var wordBox = await Hive.openBox<Word>('word');
      // wordBox.clear();
      wordBox.add(word);
    } catch (e) {}
    // var wordBox = Hive.box('word');

    rebuildStates();
  }

  void removeWord(int index) async {
    var wordBox = await Hive.openBox<Word>('word');
    print(wordBox.getAt(index).word);
    await Hive.openBox<Word>('word')
      ..deleteAt(index);
  }
}
