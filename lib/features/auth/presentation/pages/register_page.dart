import 'package:chattera/features/auth/presentation/components/my_button.dart';
import 'package:chattera/features/auth/presentation/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePage;

  const RegisterPage({super.key,required this.togglePage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controlers
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final ConfirmPwController = TextEditingController();
  //BUILD UI
  @override
  Widget build(BuildContext context) {
    //SCAFFORD
    return Scaffold(
      //BODY
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //LOGO
              Icon(
                Icons.lock_open,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 25),
              //name of app
              Text(
                "Let's create account for you",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),

              const SizedBox(height: 25),

              //email textfield
              MyTextfield(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),

              const SizedBox(height: 10),
              //pw textfield
              MyTextfield(
                controller: pwController,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: 10),

              //Confirmpw textfield
              MyTextfield(
                controller: ConfirmPwController,
                hintText: "Confirm Password",
                obscureText: true,
              ),

              const SizedBox(height: 25),
              //login Button
              MyButton(onTap: () {}, text: "Sign Up"),

              const SizedBox(height: 25),
              //auth sign in later

              //dont have an account?register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.togglePage,
                    child: Text(
                      "Login now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
