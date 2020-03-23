import 'package:flutter/material.dart';

import './SharedPrefStorageMaster.dart';

class SPMember extends SharedPrefStorageMaster{
  String prefix = 'member';
  
  @override
  Map<String,String> sharedKey = {
    "api_key": "api_key",
    "gender": "gender"
  };


}