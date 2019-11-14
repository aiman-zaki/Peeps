import 'package:meta/meta.dart';
import 'package:peeps/models/stash.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:peeps/resources/common_repo.dart';

class StashRepository extends BaseRepository {
  StashRepository({
    String data,
  }) : super(baseUrl: groupworksUrl, data: data);
  readReferences() async {
    var data = await super.read(namespace: "references");
    if (data != null)
      return data.map((value){
        return ReferenceModel.fromJson(value);
      }).toList().cast<ReferenceModel>();
    return [];
  }

  readPublicReferences() async {
    var data = await super.read(namespace: "references/public");
    if(data != null){
      return data.map((value){
        return ReferenceModel.fromJson(value);
      }).toList().cast<ReferenceModel>();
    }
    return [];
  }

  createReference({data}) async {
    await super.create(data: data, namespace: "references");
  }
}
