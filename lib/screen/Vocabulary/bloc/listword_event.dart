part of 'listword_bloc.dart';

abstract class GetWordEvent extends Equatable {
  @override
  
  List<Object> get props => [];
}
class Fetch extends GetWordEvent{}
class FetchMoreWord extends GetWordEvent{
  final String nextPage;
  FetchMoreWord({this.nextPage});
}
