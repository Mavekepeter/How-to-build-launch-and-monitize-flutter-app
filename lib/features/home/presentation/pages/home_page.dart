import 'package:chattera/components/drawer.dart';
import 'package:chattera/features/auth/presentation/components/my_textfield.dart';
import 'package:chattera/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:chattera/features/home/domain/entities/post.dart';
import 'package:chattera/features/home/presentation/components/post_tile.dart';
import 'package:chattera/features/home/presentation/cubits/post_cubit.dart';
import 'package:chattera/features/home/presentation/cubits/post_states.dart';
import 'package:chattera/features/home/presentation/pages/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //Tab controller
  late final _tabController = TabController(length: 3, vsync: this);

  //cubits
  late final postCubit = context.read<PostCubit>();

  @override
  void initState() {
    super.initState();

    //load posts initially
    postCubit.loadPosts();
  }

  //add new post to a given category
  void addPost() {
    //get current category
    String currentcategory;
    switch (_tabController.index) {
      case 0:
        currentcategory = "Build";
        break;

      case 1:
        currentcategory = "Launch";
        break;

      case 2:
        currentcategory = "Monitize";
        break;

      default:
        currentcategory = "Build";
    }
    //text controllers
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New Post"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //title text field
            MyTextfield(
              controller: titleController,
              hintText: "Title",
              obscureText: false,
            ),

            const SizedBox(height: 16),

            //title text field
            MyTextfield(
              controller: contentController,
              hintText: "Content",
              obscureText: false,
            ),
          ],
        ),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          //post button
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                //access cubits
                final postCubit = context.read<PostCubit>();
                final authCubit = context.read<AuthCubit>();
                postCubit.createPost(
                  title: titleController.text,
                  content: contentController.text,
                  category: currentcategory,
                  username: authCubit.currentUser!.email,
                );

                // pop box
                Navigator.pop(context);
              }
            },
            child: const Text("post"),
          ),
        ],
      ),
    );
  }

  //delete post
  void deletePost(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete post"),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          //delete button
          TextButton(
            onPressed: () {
              postCubit.deletePost(id);
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
  //Build list of posts for agiven caegory

  Widget _buildCategoryPosts(String category, List<Post> posts) {
    //filter posts for this category
    final postsInThisCategory = posts
        .where((post) => post.category == category)
        .toList();

    //posts are empty
    if (postsInThisCategory.isEmpty) {
      return const Center(child: Text("No posts is here yet.."));
    }
    //list of posts(for this category)
    return ListView.builder(
      itemCount: postsInThisCategory.length,
      itemBuilder: (context, index) {
        //get individual posts
        final post = postsInThisCategory[index];

        //post title
        return PostTile(
          post: post,
          onDelete: () => deletePost(post.id),
          onTap: () {
            //navigate to my post page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  PostPage(
                  post: post,
                ),
                )
              );
          },
        );
      },
    );
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    //SCAFFORD
    return Scaffold(
      //APP BAR
      appBar: AppBar(
        title: Text("Home"),
        bottom: TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          labelColor: Theme.of(context).colorScheme.inversePrimary,
          unselectedLabelColor: Theme.of(context).colorScheme.primary,
          tabs: const [
            Tab(text: "Build"),
            Tab(text: "Launch"),
            Tab(text: "Monitize"),
          ],
        ),

        // NEW POST BUTTON
        actions: [IconButton(onPressed: addPost, icon: Icon(Icons.add))],
      ),

      //DRAWER
      drawer: MyDrawer(),

      //Body
      body: BlocBuilder<PostCubit, PostStates>(
        builder: (context, state) {
          print(state);
          //loaded
          if (state is PostsLoaded) {
            return TabBarView(
              controller: _tabController,
              children: [
                _buildCategoryPosts("Build", state.posts),
                _buildCategoryPosts("Launch", state.posts),
                _buildCategoryPosts("Monetize", state.posts),
              ],
            );
          }
          //loading
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          //error
          if (state is PostError) {
            return Center(child: Text(state.message));
          }

          //fallback default
          return const SizedBox();
        },
      ),
    );
  }
}
