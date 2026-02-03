import 'package:chattera/features/auth/data/firebase_auth_repo.dart';
import 'package:chattera/features/auth/presentation/components/loading.dart';
import 'package:chattera/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:chattera/features/auth/presentation/cubits/auth_state.dart';
import 'package:chattera/features/auth/presentation/pages/auth_page.dart';
import 'package:chattera/features/home/presentation/pages/home_page.dart';
import 'package:chattera/firebase_options.dart';
import 'package:chattera/themes/dark_mode.dart';
import 'package:chattera/themes/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  //firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //run app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  //auth repo
  final firebaseAuthRepo = FirebaseAuthRepo();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // Provide cubits to app
      providers: [
        //Auth cubit
        BlocProvider<AuthCubit>(
          create: (context) =>
              AuthCubit(authRepo: firebaseAuthRepo)..checkAuth(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,

        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state) {
            print(state);
            //Unauthenticated ->auth page
            if (state is Unauthenticated) {
              return const AuthPage();
            }
            //authenticated ->Home page
            if (state is Authenticated) {
              return const HomePage();
            }
            //loading
            else {
              return const LoadingScreen();
            }
          },

          // listen for state change
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ),
    );
  }
}
