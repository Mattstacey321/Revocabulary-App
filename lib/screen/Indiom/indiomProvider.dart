import 'package:revocabulary/class/Indiom.dart';
import 'package:revocabulary/services/indiomService.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class IndiomProvider extends StatesRebuilder {
  var indioms = <Indiom>[];
  bool isLoading = false;
  String next;
  String previous;
  Future initLoad() async {
    setLoading(true);
    try {
      var result = await IndiomService.fetchIndiom(10, "", "");
      indioms.addAll(result.indioms);
      this.next = result.next;
      this.previous = result.previous;
      setLoading(false);
      rebuildStates();
    } catch (e) {}
  }

  Future reload() async {
    indioms.clear();
    rebuildStates();
    initLoad();
  }

  Future<void> loadMore() async {
    print(this.next);
    if (this.next != "") {
      
      var result = await IndiomService.fetchIndiom(10, this.next, "");
      this.next = result.next ?? "";
      if (result.next == "") {
        setLoading(false);
        return;
      }
      
      indioms.addAll(result.indioms);
      rebuildStates();
    } else {
      return;
    }
  }

  void clearResult() {
    indioms.clear();
    rebuildStates();
  }

  void setLoading(bool setLoading) {
    isLoading = setLoading;
    rebuildStates();
  }
}
