import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:revocabulary/class/Word.dart';
import 'package:revocabulary/config/Query.dart';
import 'package:revocabulary/util/graphql_util.dart';
import 'package:rxdart/rxdart.dart';
part 'listword_event.dart';
part 'listword_state.dart';

class GetWordBloc extends Bloc<GetWordEvent, GetWordState> {
  @override
  GetWordInitial get initialState => GetWordInitial();

  @override
  Stream<Transition<GetWordEvent, GetWordState>> transformEvents(
    Stream<GetWordEvent> events,
    TransitionFunction<GetWordEvent, GetWordState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<GetWordState> mapEventToState(
    GetWordEvent event,
  ) async* {
    final currentState = state;


    print("${event is Fetch && !_hasReachedMax(currentState)}");
    try {
      if (event is Fetch && !_hasReachedMax(currentState)) {
        print("$currentState");
        if (currentState is GetWordInitial) {
          final words = await _fetchWord(10, "", "");
          yield GetWordLoad(
              words: words.words,
              nextPage: words.next == null ? "" : words.next,
              previousPage: words.previous == null ? "" : words.previous);
          return;
        }
        if (currentState is GetWordLoad) {
          print("load new ${currentState.nextPage}");
          final words = await _fetchWord(10, currentState.nextPage, "");
          print(words);
          yield words.words.isEmpty
              ? currentState.copyWith(nextPage: "",previousPage: words.previous)
              : GetWordLoad(words: currentState.words + words.words, nextPage: words.next,previousPage: words.previous);
          print(currentState.words );
        }
      }
    } catch (e) {
      print("Error $e");
      yield GetWordFail();
    }

    /*if (event is Fetch && !_hasReachedMax(currentState)) {

      try {
        if (currentState is GetWordInitial) {
          print("init bloc");
          var words = await _fetchWord(10, "", "");
          nextPage = words.next;
          yield GetWordLoad(words: words.words, nextPage: words.next);
          return;
        }
        if (currentState is GetWordLoad) {
          print("load new ${currentState.nextPage}");
          var words = await _fetchWord(10, currentState.nextPage, "");
          print(words.words[2].word);
          yield words.words.isEmpty
              ? currentState.copyWith(nextPage: "")
              : GetWordLoad(words: currentState.words + words.words, nextPage: words.next);
          
        }
      } catch (e) {
        print("Error $e");
        yield GetWordFail();
      }*/
  }
}

bool _hasReachedMax(GetWordState state) =>
    state is GetWordLoad && (state.nextPage == null || state.nextPage == "");

Future<Words> _fetchWord(int limit, String nextPage, String previousPage) async {
  GraphQLQuery query = GraphQLQuery();
  var result = await GraphQLUtil.queryGraphQL(query.fetchWords(limit, nextPage, previousPage));
  var listWord = Words.fromJson(result.data);
  return listWord;
}
