import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud_bloc_task/application/features/posts/postbloc/post_bloc.dart';

class PostDetailScreen extends StatelessWidget {
  final int postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PostDetailLoaded) {
            final post = state.post;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(post.body),
                ],
              ),
            );
          } else if (state is PostStateError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const Center(
            child: Text('Failed to load post detail'),
          );
        },
      ),
    );
  }
}
