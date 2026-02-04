import 'package:chattera/features/home/domain/entities/post.dart';
import 'package:chattera/features/home/domain/repos/post_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePostRepo implements PostRepo {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createPost(Post post) async {
    await _firestore.collection('posts').doc(post.id).set(post.toJson());
  }

  @override
  Future<void> deletePost(String id) async {
    await _firestore.collection('posts').doc(id).delete();
  }

  @override
  Future<List<Post>> loadAllPosts() async {
    final snapShot = await _firestore.collection('posts').get();
    return snapShot.docs.map((doc) => Post.fromJson(doc.data())).toList();
  }
}
