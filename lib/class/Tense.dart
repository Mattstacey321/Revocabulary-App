class Tense {
  String type;
  String definition;
  List<Structure> structure;
  List<Example> usage;
  List<Example> hint;
  List<Example> rule;
  Tense({this.definition, this.type, this.structure, this.usage, this.hint, this.rule});
  factory Tense.fromJson(Map json) {
    var usage = <Example>[];
    var hint = <Example>[];
    var rule = <Example>[];
    var structure = <Structure>[];
    for (var item in json['structure']) {
        structure.add(Structure(type: item['type'],formula: item['formula'],note:item['note'] ?? []));
    }
    for(var item in json['usage']){
      usage.add(Example(title: item['title'],content: item['content'] ?? [], example: item['example'] ?? []));
    }
    for(var item in json['hint']){
      hint.add(Example(title: item['title'],content: item['content'] ?? [],example: item['example'] ?? []));
    }
    for(var item in json['rule']){
      rule.add(Example(title: item['title'],content: item['content'] ?? [],example: item['example'] ?? []));
    }
    
    return Tense(
      definition: json['definition'], 
      type: json['type'],
      structure: structure,
      hint: hint,
      rule: rule,
      usage: usage
    );
  }
}

class Structure {
  String type;
  String formula;
  List note;
  Structure({this.type,this.formula,this.note});
}

class Example {
  String title;
  List content;
  List example;
  Example({this.title,this.content,this.example});
}

class Tenses {
  List<Tense> tenses;
  Tenses({this.tenses});
  factory Tenses.fromJson(Map json) {
    var tenses = <Tense>[];
    try {
      for (var item in json['getTense']) {
        tenses.add(Tense(type: item['type']));
      }
    } catch (e) {
      return Tenses(tenses: []);
    }
    return Tenses(tenses: tenses);
  }
}
