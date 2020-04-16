import 'package:revocabulary/class/Phrase.dart';
import 'package:revocabulary/services/phraseService.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class PhraseProvider extends StatesRebuilder {
  var phrases = <Phrase>[];
  bool hasNext = true;
  bool isLoading = false;
  bool fetchError = false;
  String nextPage = "";
  String previousPage = "";

  Future<void> initLoad() async {
    try {
      var result = await PhraseService.fetchPhrase(10, "", "");
      nextPage = result.next;
      previousPage = result.previous;
      if (previousPage != null) {
        hasNext = false;
      }
      phrases.addAll(result.phrases);
    } catch (e) {
      fetchError = true;
      rebuildStates();
    }
    rebuildStates();
  }

  Future<void> loadMore() async {
    if (nextPage != null) {
      print(this.nextPage);
      setLoading(true);
      print(isLoading);
      var result = await PhraseService.fetchPhrase(10, this.nextPage, "");
      print(result.phrases.length);
      if (result.next == "") {
        setLoading(false);
        return;
      }
      nextPage = result.next;
      phrases.addAll(result.phrases);
      rebuildStates();
    } else {
      return;
    }
  }

  Future<void> reload() async {
    phrases.clear();
    rebuildStates();

    Future.delayed(Duration(milliseconds: 500), () {
      initLoad();
      rebuildStates();
    });
  }

  Future clear() async {
    phrases.clear();
    rebuildStates();
  }

  void setLoading(bool setLoading) {
    this.isLoading = setLoading;
    rebuildStates();
  }
}
