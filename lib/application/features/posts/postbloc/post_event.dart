part of 'post_bloc.dart';

@immutable
abstract class PostEvent extends Equatable{
  const PostEvent();
  @override
  List<Object?> get props=>[];


}

class PostRequestedEvent extends PostEvent{
   @override
  List<Object?> get props=>[];
}


class PostAddedEvent extends PostEvent {
  final String title;
  final String body;

  const PostAddedEvent({required this.title, required this.body});

  @override
  List<Object?> get props => [title, body];
}


class PostDeletedEvent extends PostEvent {
  final int postId;

  const PostDeletedEvent({required this.postId});

}

class PostUpdatedEvent extends PostEvent {
  final PostsEntity post;

  PostUpdatedEvent({required this.post});

  @override
  List<Object?> get props => [post];
}
class PostDetailRequestedEvent extends PostEvent {
  final int postId;

  PostDetailRequestedEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}
