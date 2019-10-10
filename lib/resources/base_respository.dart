import 'package:peeps/resources/common_repo.dart';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:peeps/resources/common_repo.dart';
import 'package:http/http.dart' as http;

abstract class BaseRepository{
  final baseUrl;
  final data;
  final data2;
  
  const BaseRepository(
    {
      @required this.baseUrl,
      this.data,
      this.data2,
    }
  );

   _url(namespace){
    var url = "$domain$baseUrl";
    if(data != null)
      url = "$url/$data";
    if(data2 != null)
      url = "$url/$data2";
    if(namespace != null)
      url = "$url/$namespace";
    return url;
  }

  get url => _url(String);
  

  create({@required data,namespace}) async {
    var headers = await fetchHeaders();
    var response = await http.post(_url(namespace),
      body: jsonEncode(data),
      headers: headers,
    );
    var jsonDecoded = jsonDecode(response.body);
    if(response.statusCode == 200){
      return jsonDecoded;
    } else {
      throw jsonDecode;
    }

  } 

  read({namespace}) async {
    var headers = await fetchHeaders();
    var response = await http.get(_url(namespace),headers: headers);
    var jsonDecoded = jsonDecode(response.body);
    if(response.statusCode == 200){
      return jsonDecoded;
    } else {
      throw jsonDecode;
    }
  }
  update({@required data,namespace}) async {
    var headers = await fetchHeaders();
    var response = await http.put(_url(namespace),
      headers: headers,
      body: jsonEncode(data)
    );
    var jsonDecoded = jsonDecode(response.body);
    if(response.statusCode == 200){
      return jsonDecoded;
    } else {
      throw jsonDecoded;
    }
  }
  delete(){

  }


}