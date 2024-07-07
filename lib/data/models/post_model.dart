import 'package:crud_bloc_task/domain/entities/post_entity.dart';
import 'package:flutter/foundation.dart';

class PostModel extends PostsEntity {
  PostModel({
    required int userId,
    required int id,
    required String title,
    required String body,
  }) : super(userId: userId, id: id, title: title, body: body);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
