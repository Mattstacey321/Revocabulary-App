part of 'listword_bloc.dart';

abstract class GetWordState extends Equatable {
  const GetWordState();
  @override
  List<Object> get props => [];
}

class GetWordInitial extends GetWordState {}

class GetWordFail extends GetWordState{
  final String error;
  GetWordFail({this.error});
  @override
  String toString() {
    
    return error;
  }
}

class GetWordLoad extends GetWordState{
  final List<Word> words;
  final String nextPage;
  final String previousPage;
  GetWordLoad({this.words,this.nextPage,this.previousPage});
  
  GetWordLoad copyWith({
    List<Word> words,
    String nextPage,
    String previousPage
  }){
    print("next page $nextPage");
    return GetWordLoad(
      words: words ?? this.words,
      nextPage: nextPage ?? this.nextPage,
      previousPage: previousPage ?? this.previousPage
    );
  }

  @override
  List<Object> get props => [words, nextPage];
  @override
  String toString() {
  return "$nextPage $previousPage $words";
   }
}

