import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app/model/post.dart';

part 'post_event.dart';
part 'post_state.dart';

// lib/blocs/post/post_bloc.dart
class PostBloc extends Bloc<PostEvent, PostState> {
  final FirebaseFirestore _firestore;
  StreamSubscription? _postsSubscription;

  PostBloc(this._firestore) : super(PostInitial()) {
    on<LoadPosts>((event, emit) async {
      _postsSubscription?.cancel();
      _postsSubscription = _firestore
          .collection('posts')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .listen((snapshot) {
        add(PostsUpdated(snapshot.docs));
      });
    });

    on<PostsUpdated>((event, emit) {
      final posts = event.posts
          .map((doc) => Post.fromFirestore(doc))
          .toList();
      emit(PostLoaded(posts));
    });

    on<CreatePost>((event, emit) async {
      try {
        await _firestore.collection('posts').add({
          'message': event.message,
          'userId': event.userId,
          'username': event.username,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
  }

  @override
  Future<void> close() {
    _postsSubscription?.cancel();
    return super.close();
  }
}

