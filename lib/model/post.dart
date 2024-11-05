
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String message;
  final String userId;
  final String username;
  final DateTime timestamp;

  Post({
    required this.id,
    required this.message,
    required this.userId,
    required this.username,
    required this.timestamp,
  });

  factory Post.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Post(
      id: doc.id,
      message: data['message'],
      userId: data['userId'],
      username: data['username'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}