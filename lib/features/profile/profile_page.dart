import 'package:chattera/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    //auth cubit
    final authCubit = context.read<AuthCubit>();
    //current user

    final currentUser = authCubit.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.person,
                size: 80,
                ),
            ),

              Text(currentUser!.email),
          ],
        ),
        );
  }
}
