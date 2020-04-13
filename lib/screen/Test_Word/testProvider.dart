import 'package:states_rebuilder/states_rebuilder.dart';

class TestProvider extends StatesRebuilder{
  int currentIndex=0;
  void setIndex(int index){
    currentIndex = index;
    rebuildStates();
  }
}