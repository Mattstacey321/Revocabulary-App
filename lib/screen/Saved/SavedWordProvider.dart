import 'dart:convert';

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

  Future<void> readFromLocal() async {
    SharedPreferences ref = await SharedPreferences.getInstance();
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
    print(words);
    rebuildStates();
  }

  void addToSaved(Word word) async {
    //words.clear();
    print(word.word);
    SharedPreferences ref = await SharedPreferences.getInstance();
    if (ref.containsKey("savedList")) {
      var words = ref.getStringList("savedList");

      words.add(json.encode(word));
      ref.setStringList("savedList", words);
    } else
      ref.setStringList("savedList", [json.encode(word)]);
    rebuildStates();
  }
}
