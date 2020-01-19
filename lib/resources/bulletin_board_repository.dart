import 'package:meta/meta.dart';
import 'package:peeps/models/bulletin.dart';
import 'package:peeps/resources/base_respository.dart';

import 'common_repo.dart';

class BulletinBoardRepository extends BaseRepository{

  BulletinBoardRepository():super(baseUrl:bulletinBoardUrl);

  readBulletinBoard() async {
    var data = await super.read(namespace: 'bulletin');
    return data.map((bulletin) => BulletinModel.fromJson(bulletin))
      .toList().cast<BulletinModel>();
  }

  createBulletin({@required data}) async {
    var message = await super.create(namespace: 'bulletin',data: data);
    return message;
  }

  deleteBulletin({@required data}) async {
    var message = await super.update(namespace: 'bulletin',data:data);
    return message;
  }
}