import 'package:chattera/features/home/domain/entities/post.dart';

abstract class PostStates {}

//initial state
class PostInitial extends PostStates {}

//loading state
class PostLoading extends PostStates {}

//loaded with posts
class PostsLoaded extends PostStates {
  final List<Post> posts;
  PostsLoaded(this.posts);
}

//error state
class PostError extends PostStates {
  final String message;
  PostError(this.message);
}

//post create Successfully
class PostCreated extends PostStates{}

//post deleted successfully
class PostDeleted extends PostStates{}
