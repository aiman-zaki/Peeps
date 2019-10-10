import 'package:peeps/resources/common_repo.dart';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:peeps/resources/common_repo.dart';
import 'package:http/http.dart' as http;

abstract class BaseRepositry{
  final baseUrl;
  final data;
  final data2;
  final namespace;
  BaseRepositry(
    {
      @required this.baseUrl,
      this.namespace,
      @required this.data,
      this.data2,
    }
  );

   url(){
    var url = "$domain$baseUrl";
    if(data != null)
      url = "$url/$data";
    if(data2 != null)
      url = "$url/$data2";
    if(namespace != null)
      url = "$url/$namespace";
    return url;
  }
  

  create(dynamic data) async {
    var headers = await fetchHeaders();
    var response = await http.post(url(),
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

  read() async {
    var headers = await fetchHeaders();
    var response = await http.get(url(),headers: headers);
    var jsonDecoded = jsonDecode(response.body);
    if(response.statusCode == 200){
      return jsonDecoded;
    } else {
      throw jsonDecode;
    }
  }
  update(data) async {
    var headers = await fetchHeaders();
    var response = await http.put(url(),
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
  delete();


}