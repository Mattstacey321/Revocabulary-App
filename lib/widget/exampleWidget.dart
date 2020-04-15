import 'package:flutter/material.dart';
import 'package:revocabulary/values/AppColors.dart';

class ExampleWidget extends StatefulWidget {
  final int length;
  final List object;

  const ExampleWidget({this.length, this.object});
  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  var contentStyle = TextStyle(fontSize: 16);
  var index = 0;
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.alternativeColor,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          for (index = 0;
              index < widget.object.length - 1;
              setState(() {
            index++;
          }))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("""- ${widget.object[index].title}""" ?? "Hello", style: contentStyle,textAlign: TextAlign.justify,),
              ],
            ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                for (var item in widget.object[index].content)
                   Column(
                      children: <Widget>[Text("""${String.fromCharCode(0x2022)} $item""")],
                    ),
                  Text("-> Example:",style: TextStyle(fontWeight: FontWeight.bold),),
                for (var item in widget.object[index].example)
                  Container(
                    margin: EdgeInsets.only(left:10),
                    child: Column(
                      children: <Widget>[
                        
                        
                        Text("""$item""")
                      ],
                    ),
                  ),
              ],
            ),
          ),
      ],
    ),
        ));
  }
}
