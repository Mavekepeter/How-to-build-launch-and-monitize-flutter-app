import 'package:chattera/features/home/domain/entities/comment.dart';
import 'package:chattera/features/home/domain/entities/post.dart';

abstract class PostRepo {
  //post functionality
  Future<void> createPost(Post post);
  Future<void> deletePost(String id);
  Future<List<Post>> loadAllPosts();

  //comment functionality
  Future<void> addComment(Comment comment);
  Future<void> deleteComment(String postId,String commentId);
  Future<List<Comment>> getComments(String postId);
}
