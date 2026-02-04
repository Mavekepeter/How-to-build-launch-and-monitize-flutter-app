import 'package:chattera/features/home/domain/entities/post.dart';
import 'package:chattera/features/home/domain/repos/post_repo.dart';
import 'package:chattera/features/home/presentation/cubits/post_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
CUBIT HANDLES THE STATE MANAGEMENT FOR POSTS
*/

class PostCubit extends Cubit<PostStates> {
  final PostRepo postRepo;
  PostCubit({required this.postRepo}) : super(PostInitial());

  //locally cache posts
  List<Post> _posts = [];

  //get all posts
  List<Post> get posts => _posts;

  //load all posts
  Future<void> loadPosts() async {
    try {
      emit(PostLoading());
      _posts = await postRepo.loadAllPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  //Create new post
  Future<void> createPost({
    required String title,
    required String content,
    required String category,
    required String username,
  }) async {
    try {
      emit(PostLoading());
      final post = Post(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        content: content,
        category: category,
        username: username,
      );
      await postRepo.createPost(post);
      emit(PostCreated());
      await loadPosts();
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  //Delete a post
  Future<void> deletePost(String id) async {
    try {
      emit(PostLoading());
      await postRepo.deletePost(id);
      emit(PostDeleted());
      await loadPosts();
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
