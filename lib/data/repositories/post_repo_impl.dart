
import 'package:crud_bloc_task/data/datasources/post_remote_datasources.dart';
import 'package:crud_bloc_task/domain/entities/post_entity.dart';
import 'package:crud_bloc_task/domain/repositories/post_repositories.dart';
import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class PostRepoImpl implements PostRepo{

  PostRemoteDataSource postRemoteDataSource= PostRemoteDataSourceImpl();
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  @override
  Future<List<PostsEntity>> getDataFromDataSource() async{

   final posts= await postRemoteDataSource.getPostFromApi();
   return posts;

  }
  @override
  Future<void> addPostToDataSource(PostsEntity post) async {
    await postRemoteDataSource.addPostToApi(PostModel(
      id: post.id,
      userId: post.userId,
      title: post.title,
      body: post.body,
    ));
  }

  @override
  Future<void> deletePost(int id) async {
    print('Deleting post from API with id: $id'); // Debug print
    await postRemoteDataSource.deletePost(id);
    print('Deleted post from API with id: $id');
    // Debug print

  }

  @override
  Future<void> updatePosts(PostsEntity post) async {
    final response = await http.put(
      Uri.parse('$baseUrl/posts/${post.id}'),
      headers: {'Content-Type': 'application/json'},
      body: {
        'title': post.title,
        'body': post.body,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update post');
    }
  }


}
