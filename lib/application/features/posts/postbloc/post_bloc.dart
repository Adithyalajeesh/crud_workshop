import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crud_bloc_task/domain/usecases/post_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/post_entity.dart';
import '../../../../sample_post.dart';

part 'post_event.dart';
part 'post_state.dart';
class PostBloc extends Bloc<PostEvent, PostState> {
  final PostUseCases postUseCases;

  PostBloc({required this.postUseCases}) : super(PostInitial()) {
    on<PostRequestedEvent>(_onPostRequested);
    on<PostAddedEvent>(_onPostAdded);
    on<PostDeletedEvent>(_onPostDeleted);
    on<PostUpdatedEvent>(_onPostUpdated);
    on<PostDetailRequestedEvent>(_onPostDetailRequested);

  }

  Future<void> _onPostRequested(PostRequestedEvent event, Emitter<PostState> emit) async {
    try {
      final posts = await postUseCases.getPostsFromDataSource();
      emit(PostStateLoaded(posts: posts));
    } catch (e) {
      emit(PostStateError(message: e.toString()));
    }
  }

  Future<void> _onPostAdded(PostAddedEvent event, Emitter<PostState> emit) async {
    try {
      final currentState = state;
      if (currentState is PostStateLoaded) {
        final highestUserId = currentState.posts.map((post) => post.userId).reduce((a, b) => a > b ? a : b);
        final newUserId = highestUserId + 1;

        final newPost = PostsEntity(
          id: DateTime.now().millisecondsSinceEpoch,
          userId: newUserId,
          title: event.title,
          body: event.body,
        );

        await postUseCases.addPost(newPost);
        final posts = await postUseCases.getPostsFromDataSource();
        emit(PostStateLoaded(posts: posts));
      }
    } catch (e) {
      emit(PostStateError(message: e.toString()));
    }
  }

  Future<void> _onPostDeleted(PostDeletedEvent event, Emitter<PostState> emit) async {
    print('PostDeletedEvent triggered'); // Debug print
   // Emit loading state
    try {
      final currentState = state;
      if (currentState is PostStateLoaded) {
        final postId = event.postId; // Access postId using getter
        await postUseCases.deletePost(postId);
        final posts = await postUseCases.getPostsFromDataSource();
        print('New posts after deleting: $posts'); // Debug print
        emit(PostStateLoaded(posts: posts));
      }
    } catch (e) {
      emit(PostStateError(message: e.toString()));
    }
  }

  Future<void> _onPostUpdated(PostUpdatedEvent event, Emitter<PostState> emit) async {
    try {
      await postUseCases.updatePosts(event.post); // Implement updatePost in your use case
      final posts = await postUseCases.getPostsFromDataSource();
      emit(PostStateLoaded(posts: posts));
    } catch (e) {
      emit(PostStateError(message: e.toString()));
    }
  }

  Future<void> _onPostDetailRequested(PostDetailRequestedEvent event, Emitter<PostState> emit) async {
    try {
      final posts = await postUseCases.getPostsFromDataSource();
      final post = posts.firstWhere((post) => post.id == event.postId);
      emit(PostDetailLoaded(post: post));
    } catch (e) {
      emit(PostStateError(message: e.toString()));
    }
  }

}


