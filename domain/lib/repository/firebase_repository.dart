import 'package:domain/domain.dart';
import 'package:domain/entities/tag_entity.dart';

abstract class FirebaseRepository {
  Future createTag({required String title});

  Future<TagEntity?> getMediaTags({required String mediaId});

  Future<LikeEntity?> getMediaLikes({required String mediaId});

  Future changeMediaLikes({required String mediaId});
}
