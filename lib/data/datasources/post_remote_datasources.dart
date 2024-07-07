import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPostFromApi();

  Future<void> addPostToApi(PostModel post);

  Future<void> deletePost(int id);
}
class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final client = http.Client();

  //Get all posts:
  @override
  Future<List<PostModel>> getPostFromApi() async {
    try {
      final response = await client.get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'),
          headers: {'content-type': 'application/json'});

      if (response.statusCode == 200) {
        print(response.body);

        final List<dynamic> responseBody = jsonDecode(response.body);

        final List<PostModel> posts =
            responseBody.map((json) => PostModel.fromJson(json)).toList();

        return posts;
      } else {
        throw Exception("Failed to load posts");
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  //Add a post:
  @override
  Future<void> addPostToApi(PostModel post) async {
    try {
      final response = await client.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(post.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception("Failed to add post");
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  //Delete a post:
  @override
  Future<void> deletePost(int id) async {
    print('Making DELETE request to API for post with id: $id'); // Debug print
    final response = await client.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
    );
    print('Response status code: ${response.statusCode}'); // Debug print
    print('Response body: ${response.body}');
    // Debug print

    if (response.statusCode != 200) {
      print('Deleted post from API'); // Debug print
      throw Exception('Failed to delete post');
    }
  }
}
