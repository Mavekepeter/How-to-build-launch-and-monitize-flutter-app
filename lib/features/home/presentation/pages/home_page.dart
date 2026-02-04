import 'package:chattera/components/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //Tab controller
  late final _tabController = TabController(length: 3, vsync: this);

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
            Tab(text: "Build",),
            Tab(text: "Laucnch",),
            Tab(text: "Monitize",),
          ],
          ),

          // NEW POST BUTTON
          actions: [
            IconButton(
              onPressed: () {}, 
              icon: Icon(Icons.add),
              ),
          ],

      ),

      //DRAWER
      drawer: MyDrawer(),
    );
  }
}
