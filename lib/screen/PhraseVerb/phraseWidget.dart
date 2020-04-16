import 'package:flutter/material.dart';
import 'package:revocabulary/class/Phrase.dart';
import 'package:revocabulary/values/AppColors.dart';

class PhraseWidget extends StatefulWidget {
  final List<Phrase> phrases;
  final int index;
  PhraseWidget({this.phrases,this.index});
  @override
  _PhraseWidgetState createState() => _PhraseWidgetState();
}

class _PhraseWidgetState extends State<PhraseWidget> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      alignment: Alignment.center,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.secondaryColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.phrases[widget.index].phrase,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          widget.phrases[widget.index].wordType == ""
              ? Text(
                  "${widget.phrases[widget.index].wordType} (v)",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                )
              : Text(
                  "(${widget.phrases[widget.index].wordType})",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                ),
          Text(
            widget.phrases[widget.index].meaning[0],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  @override

  bool get wantKeepAlive => true;
}
