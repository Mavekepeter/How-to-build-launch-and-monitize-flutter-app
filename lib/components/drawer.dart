import 'package:chattera/components/drawer_tile.dart';
import 'package:chattera/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:chattera/features/profile/profile_page.dart';
import 'package:chattera/features/settings/presentation/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  //logout
  void logout(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    authCubit.logout();
  }

  //confim logout
  void confirmLogout(BuildContext context) {
    //pop drawer first
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout?"),
        actions: [
          //cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              logout(context);
            },
            child: const Text("cancel"),
          ),

          //yes button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              logout(context);
            },
            child: const Text("yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                //header
                DrawerHeader(child: Icon(Icons.favorite)),
                //home tile
                MyDrawerTile(
                  text: "Home",
                  icon: Icons.home,
                  onTap: () => Navigator.pop(context),
                ),
                
                
                //profile tile
                MyDrawerTile(
                  text: "Profile",
                  icon: Icons.person,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                        ) );
                  },
                ),
                //settings tile
                MyDrawerTile(
                  text: "Settings",
                  icon: Icons.settings,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                        ) );
                  },
                ),
              ],
            ),

            //logout tile
            MyDrawerTile(
              text: "Logout",
              icon: Icons.logout,
              onTap: () => confirmLogout(context),
            ),
          ],
        ),
      ),
    );
  }
}
