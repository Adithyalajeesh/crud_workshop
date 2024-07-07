import 'package:crud_bloc_task/data/repositories/post_repo_impl.dart';
import 'package:crud_bloc_task/domain/entities/post_entity.dart';
import 'package:crud_bloc_task/domain/repositories/post_repositories.dart';

class PostUseCases {
  final PostRepo postRepo = PostRepoImpl();

  Future<List<PostsEntity>> getPostsFromDataSource() async {
    final posts = await postRepo.getDataFromDataSource();
    return posts;
  }

  Future<void> addPost(PostsEntity post) async {
    await postRepo.addPostToDataSource(post);
  }

  Future<void> deletePost(int id) async {
    print('Deleting post with id: $id'); // Debug print
    await postRepo.deletePost(id);
    print('Post deleted'); // Debug print
  }

  Future<void> updatePosts(PostsEntity post) async {
    await postRepo.updatePosts(post);
  }
}
