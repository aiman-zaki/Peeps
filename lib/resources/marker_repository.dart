import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:peeps/models/marker.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:peeps/resources/common_repo.dart';
import 'package:http/http.dart' as http;

class MarkerRepository extends BaseRepository{

  MarkerRepository({
    @required data,
  }):super(data:data,baseUrl:forumUrl);


  readMarkers()async{
    var data = await super.read(namespace: "markers");
    List<MarkerModel> markers = [];
    for(Map<String,dynamic> marker in data){
      var response = await http.get(marker['url']);
      var icon = (response.bodyBytes);
      marker['icon'] = icon;
      markers.add(MarkerModel.fromJson(marker));
    }

    return markers;
  }

  createMarker({@required data}) async {
    await super.create(namespace:"markers",data: data.toJson());
  }
}