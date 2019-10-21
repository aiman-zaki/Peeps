

import 'package:flutter/cupertino.dart';
import 'package:peeps/models/member.dart';
import 'package:peeps/models/members.dart';

import 'package:peeps/resources/base_respository.dart';
import 'package:peeps/resources/common_repo.dart';

class UsersRepository extends BaseRepository{
  
  @override
  const UsersRepository(
  ):super(baseUrl:usersUrl);
  
  @override
  create({@required data,namespace}) async{
    super.create(data: data);
  }

  find({@required data}) async {
    var json = await super.update(data: data,namespace: "search");
    List<MemberModel> members = [];
    if(json != null){
      for(Map<String,dynamic> member in json){
        members.add(MemberModel.fromJson(member));
      }
    }
    return members;
  
  }

  @override
  update({@required data,namespace}) async {

  }
  

}