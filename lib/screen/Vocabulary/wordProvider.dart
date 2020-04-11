import 'package:revocabulary/class/Word.dart';
import 'package:revocabulary/services/wordService.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class WordProvider extends StatesRebuilder {
  List<Word> listWords = [];
  bool fetchError = false;
  String next = "";
  String previous = "";
  bool reachedEnd = false;

  Future<void> initLoad() async {
    try {
      var result = await WordService.fetchWord(10, "", "");
      this.next = result.next;
      this.previous = result.previous;
      listWords.addAll(result.words);
      rebuildStates();
    } catch (e) {
      print(e);
      fetchError =true;
      rebuildStates();
    }
  }

  Future loadMore() async {
    print("next token ${this.next}");
    var result = await WordService.fetchWord(10, this.next, "");
    if (result.next == null) {
      reachedEnd = true;
      return;
    } else {
      this.next = result.next;
      this.previous = result.previous;
      result.words.isEmpty ? listWords.addAll([]) : listWords.addAll(result.words);
      rebuildStates();
    }
  }

  Future<void> refresh() async {
    listWords.clear();
    rebuildStates();
    Future.delayed(Duration(milliseconds: 500), () {
      initLoad();
      rebuildStates();
    });
  }

  void hasReachedEnd() {
    this.reachedEnd = true;
  }
}
