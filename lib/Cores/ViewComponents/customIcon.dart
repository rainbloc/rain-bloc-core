import 'package:flutter/material.dart';

import 'CustomFontIcon.dart';

Widget customIcon(IconData iconData, {String text="hello", Color color = Colors.white, double size = 30, double fontSize = 13}){

  return Column(
    children: <Widget>[
      Icon(iconData, color: Colors.white, size: size),
      SizedBox(height:5),
      Text(text, style:TextStyle(color:Colors.white, fontSize: fontSize),textAlign: TextAlign.center)
    ]
  );
}
