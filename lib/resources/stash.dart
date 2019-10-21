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
    List<ReferenceModel> references = [];
    if (data != null)
      for (Map<String, dynamic> reference in data) {
        references.add(ReferenceModel.fromJson(reference));
      }
    return references;
  }

  createReference({data}) async {
    await super.create(data: data, namespace: "references");
  }
}
