
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

navigateTo(BuildContext context, dynamic dyn) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => dyn));
}


String formatDate(String dateF) {
  DateTime now = DateTime.parse(dateF);
  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
  return formattedDate;
}