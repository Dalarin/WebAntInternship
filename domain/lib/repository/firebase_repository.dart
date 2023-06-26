import 'package:domain/domain.dart';

abstract class FirebaseRepository {
  Future<MediaInfoEntity?> getMediaInfo({required String mediaId});

  Future<MediaInfoEntity?> updateMediaInfo({required MediaInfoEntity entity});



}
