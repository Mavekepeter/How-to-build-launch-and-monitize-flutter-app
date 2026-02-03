/*
FIREBASE BACKEND
 */

import 'package:chattera/features/auth/domain/entities/app_user.dart';
import 'package:chattera/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo implements AuthRepo {
  ///access to firebase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Login:email & password
  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      //Attempt sign in
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      //create user
      AppUser user = AppUser(uid: userCredential.user!.uid, email: email);
      //return user
      return user;
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  //REGISTER: Email & Password
  @override
  Future<AppUser?> registerWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      //attempt sign up
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      //create user

      AppUser user = AppUser(uid: userCredential.user!.uid, email: email);

      //return user
      return user;
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }

  //DELETE ACCOUNT
  @override
  Future<void> deleteAccount() async {
    try {
      final user = firebaseAuth.currentUser;

      //check if there is a logged in user
      if (user == null) throw Exception("No user logged in..");
      //delete account
      await user.delete();

      await logout();
    } catch (e) {
      throw Exception("Failed to delete account");
    }
  }

  //Get Current User
  @override
  Future<AppUser?> getCurrentUser() async {
    //Get current logged in user from firebase

    final firebaseUser = firebaseAuth.currentUser;
    //no logged in user
    if (firebaseUser == null) return null;
    //logged user exits
    return AppUser(uid: firebaseUser.uid, email: firebaseUser.email!);
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  //RESET PASSWORD
  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "password reset email sent! Check your inbox";
    } catch (e) {
      return "An error occured: $e";
    }
  }
}
