import 'package:chattera/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:chattera/features/settings/presentation/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //confirm with user account deletion
  void confirmAccountDeletion() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Account?"),
        actions: [
          //cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              handleAccountDeletion();
            },
            child: const Text("cancel"),
          ),

          //yes button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              handleAccountDeletion();
            },
            child: const Text("yes"),
          ),
        ],
      ),
    );
  }

  //handle account delete
  void handleAccountDeletion() async {
    try {
      //show loading..
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      //delete account
      final authCubit = context.read<AuthCubit>();
      await authCubit.deleteAccount();

      //done loading ->after deletion
      if (mounted) {
        Navigator.pop(context); //remove loading circle
        Navigator.pop(context); //remove settingpage
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: [
          //Delete account
          MySettingsTile(
            title: "Delete Account",
            action: IconButton(
              onPressed: confirmAccountDeletion,
              icon: Icon(Icons.delete_forever),
            ),
          ),
        ],
      ),
    );
  }
}
