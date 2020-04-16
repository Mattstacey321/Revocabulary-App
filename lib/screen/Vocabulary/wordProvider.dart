import 'package:revocabulary/class/Word.dart';
import 'package:revocabulary/services/wordService.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class WordProvider extends StatesRebuilder {
  List<Word> listWords = [];
  bool fetchError = false;
  String next = "";
  String previous = "";
  bool isLoading = false;

  Future<void> initLoad() async {
    setLoading(true);
    try {
      var result = await WordService.fetchWord(10, "", "");
      this.next = result.next;
      this.previous = result.previous;
      listWords.addAll(result.words);
      setLoading(false);
      rebuildStates();
    } catch (e) {
      print(e);
      fetchError = true;
      setLoading(false);
      rebuildStates();
    }
  }

  Future loadMore() async {
    if (this.next != "") {
      var result = await WordService.fetchWord(10, this.next, "");
      this.next = result.next ?? "";
      if (result.next == "") {
        setLoading(false);
        return;
      }

      listWords.addAll(result.words);
      rebuildStates();
    } else {
      return;
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

  Future clear() async{
    listWords.clear();
  }

  void setLoading(bool setLoading) {
    isLoading = setLoading;
    rebuildStates();
  }
}
