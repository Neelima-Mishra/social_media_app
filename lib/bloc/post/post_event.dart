// lib/blocs/post/post_event.dart
part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class LoadPosts extends PostEvent {}

class PostsUpdated extends PostEvent {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> posts;

  PostsUpdated(this.posts);
}

class CreatePost extends PostEvent {
  final String message;
  final String userId;
  final String username;

  CreatePost({
    required this.message,
    required this.userId,
    required this.username,
  });
}

