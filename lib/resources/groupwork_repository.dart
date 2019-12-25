import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/models/member.dart';
import 'package:peeps/models/members.dart';
import 'package:peeps/models/request.dart';
import 'package:peeps/resources/base_respository.dart';
import 'dart:convert';
import 'common_repo.dart';
import 'package:async/async.dart';
import 'package:meta/meta.dart';

class GroupworkRepository extends BaseRepository{

  const GroupworkRepository({
    @required data,
  }):super(baseUrl:groupworksUrl,data:data);

  readMembers() async {
    var data = await super.read(namespace: "members");
    List<MemberModel> members = [];

    for(Map<String,dynamic> member in data){
      members.add(MemberModel.fromJson(member));
    }

    return members;
  }

  createMembers({@required data}) async {
    await super.create(data: data,namespace: "members");
  }

  updateMembers({@required data}) async {
    await super.update(data: data,namespace: "members");
  }

  updateGroupwork({@required data})async {
    await super.update(data: data,);
  }

  updateRoles({@required data}) async {
    await super.update(data: data,namespace: "roles");
  }

  updateTemplate() async {
    await super.create(data: null,namespace: "template/update");
  }

  readRequests() async{
    var data = await super.read(namespace: "requests");
  }

  uploadProfileImage(File image,String groupId) async {
    var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    final Uri uri = Uri.parse(super.url("picture"));
    var token = await accessToken();

    var request = new http.MultipartRequest("POST",
      uri);
    request.fields['group_id'] = groupId;

    var multipartFile = new http.MultipartFile('image', stream, length,filename: (image.path));
    request.files.add(multipartFile);

    var response = await request.send();
    print(response.statusCode);
  }

  createComplaint({@required data}) async {
    return await super.create(data:data,namespace: 'complaints');
  }


}