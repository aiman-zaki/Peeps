import 'package:peeps/resources/common_repo.dart';
import 'dart:convert';

import 'package:meta/meta.dart';

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

  String url(namespace) => _url(namespace);

  requestHandler({response}){
    var jsonDecoded = jsonDecode(response.body);
    if(response.statusCode == 200){
      return jsonDecoded;
    } else {
      if(jsonDecoded['message'] != null)
        throw jsonDecoded['message'];
      throw "Something went Wrong";
    }
  }

  create({@required data,namespace}) async {
    var headers = await fetchHeaders();
    var response = await http.post(_url(namespace),
      body: jsonEncode(data),
      headers: headers,
    );
    return requestHandler(response: response);
    
       
    

  } 

  read({namespace}) async {
    var headers = await fetchHeaders();
    var response = await http.get(_url(namespace),headers: headers);
    return requestHandler(response: response);
  }

  update({@required data,namespace}) async {
    var headers = await fetchHeaders();
    var response = await http.put(_url(namespace),
      headers: headers,
      body: jsonEncode(data)
    );
    return requestHandler(response: response);
  }

  delete({namespace}) async{
    var headers = await fetchHeaders();
    var response = await http.delete(_url(namespace),
      headers: headers,
    );
    return requestHandler(response: response);
  }
}