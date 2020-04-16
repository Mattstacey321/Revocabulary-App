class Indiom{
  String indiom;
  String meaningInVn;
  String meaningInEn;
  Indiom({this.indiom,this.meaningInEn,this.meaningInVn});

}
class Indioms{
  List<Indiom> indioms;
  String next;
  String previous;
  Indioms({this.indioms,this.next,this.previous});
  factory Indioms.fromJson(Map json){
    var indioms = <Indiom>[];
    var next = json['fetchIndiom']['next'] ?? "";
    var previous = json['fetchIndiom']['previous'] ?? "";
    try {
      
      for (var item in json['fetchIndiom']['docs']){
        indioms.add(Indiom(
            indiom: item['indiom'],
            meaningInEn: item['meaning_in_en'],
            meaningInVn: item['meaning_in_vi']
            ));
      
      }
    } catch (e) {
      return Indioms(indioms: [],next: "",previous: "");
    }
    return Indioms(indioms: indioms,next: next,previous: previous);
  }
}