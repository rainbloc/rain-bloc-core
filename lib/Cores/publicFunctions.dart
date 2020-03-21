
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void navigateTo(BuildContext context, dynamic dyn) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => dyn));
}

String formatDate(String dateF, {String dateFormat = 'yyyy-MM-dd – kk:mm'}) {
  DateTime now = DateTime.parse(dateF);
  String formattedDate = DateFormat(dateFormat).format(now);
  return formattedDate;
}