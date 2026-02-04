import 'package:chattera/components/drawer.dart';
import 'package:chattera/features/auth/presentation/components/my_textfield.dart';
import 'package:chattera/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:chattera/features/home/presentation/cubits/post_cubit.dart';
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
    );
  }
}
