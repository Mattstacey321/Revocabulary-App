import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:revocabulary/values/AppColors.dart';

class ExampleWidget extends StatefulWidget {
  final int length;
  final List object;
  final int flex;
  const ExampleWidget({this.length, this.object,this.flex = 1});
  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  var contentStyle = TextStyle(fontSize: 16);
  var index = 0;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      
      flex: widget.flex,
        child: ContainerResponsive(
      padding: EdgeInsetsResponsive.all(10),
      decoration:
          BoxDecoration(color: AppColors.alternativeColor, borderRadius: BorderRadius.circular(15)),
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextResponsive(
                  """- ${widget.object[index].title}""" ?? "Hello",
                  style: contentStyle,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ContainerResponsive(
            margin: EdgeInsetsResponsive.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (var item in widget.object[index].content)
                  Column(
                    children: <Widget>[Text("""${String.fromCharCode(0x2022)} $item""")],
                  ),
                TextResponsive(
                  "-> Example:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                for (var item in widget.object[index].example)
                  ContainerResponsive(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[TextResponsive("""$item""")],
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
