import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final mediaCollection = FirebaseFirestore.instance.collection('media_info');

  @override
  Future<MediaInfoEntity?> getMediaInfo({required String mediaId}) async {
    final mediaSnapshot = await mediaCollection.where('media_id', isEqualTo: mediaId).get();

    final documents = mediaSnapshot.docs;

    if (documents.isNotEmpty) {
      final mediaInfo = documents.first.data();

      return MediaInfoEntity.fromJson(mediaInfo);
    }

    final emptyMediaInfo = {
      'media_id': mediaId,
      'likes': [],
      'tags': [],
    };

    await mediaCollection.doc(mediaId).set(emptyMediaInfo);

    return MediaInfoEntity.fromJson(emptyMediaInfo);
  }

  @override
  Future<MediaInfoEntity?> updateMediaInfo({required MediaInfoEntity entity}) async {


    await mediaCollection.doc(entity.mediaId).set(entity.toJson());

    return entity;
  }
}
