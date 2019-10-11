

import 'package:flutter/cupertino.dart';

import 'package:peeps/resources/base_respository.dart';

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