import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final likesCollection = FirebaseFirestore.instance.collection('likes');
  final tagsCollection = FirebaseFirestore.instance.collection('tags');

  @override
  Future changeMediaLikes({required String mediaId}) async {
    // TODO: implement changeMediaLikes
    throw UnimplementedError();
  }

  @override
  Future createTag({required String title}) {
    // TODO: implement createTag
    throw UnimplementedError();
  }

  @override
  Future<LikeEntity?> getMediaLikes({required String mediaId}) async {
    final likesSnapshot = await likesCollection.where('media_id', isEqualTo: mediaId).get();

    final likes = likesSnapshot.docs;

    if (likes.isNotEmpty) {
      return LikeEntity.fromJson(likes.first.data());
    }

    return null;
  }

  @override
  Future<TagEntity?> getMediaTags({required String mediaId}) async {
    final tagsSnapshot = await tagsCollection.where('media_id', isEqualTo: mediaId).get();

    final tags = tagsSnapshot.docs;

    if (tags.isNotEmpty) {
      return TagEntity.fromJson(tags.first.data());
    }

    return null;
  }
}
