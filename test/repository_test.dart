import 'package:flutter_test/flutter_test.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/models/inbox.dart';

import 'dart:convert';

import 'package:peeps/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';





void main(){
  test('asdy',() async {
    UserModel user = UserModel(contactNo: null, email: null, fname: null, id: null, lname: null, picture: null, programmeCode: null);

    SharedPreferences preferences = await SharedPreferences.getInstance();

    String json = jsonEncode(user.toJson());

    preferences.setString("user", json);


  });

}