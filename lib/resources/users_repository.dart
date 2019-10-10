import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/models/inbox.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/models/user_tasks.dart';
import 'package:peeps/resources/base_respository.dart';
import 'common_repo.dart';
import 'package:async/async.dart';
class UsersRepository extends BaseRepository{
  
  @override
  const UsersRepository(
  ):super(baseUrl:"/users");
  
  @override
  create({@required data,namespace}) async{
    super.create(data: data);
  }

  @override
  update({@required data,namespace}) async {

  }
  

}