

import 'package:crud_bloc_task/domain/entities/post_entity.dart';

abstract class PostRepo{

  Future<List<PostsEntity>>getDataFromDataSource();
  Future<void> addPostToDataSource(PostsEntity post);
  Future<void> deletePost(int id);
  Future<void> updatePosts(PostsEntity post);

}