
import 'package:flutter/material.dart';

navigateTo(BuildContext context, dynamic dyn) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => dyn));
}
