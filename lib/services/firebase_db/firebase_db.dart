import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/user_data_model.dart';

UserModel? userData;

class FirebaseDBService {
  // Firebase-related operations (authentication, database interactions, etc.)

  // this is the collection name in firestore
  static var userCollection = FirebaseFirestore.instance.collection('users');
  //auth initialization
  var auth = FirebaseAuth.instance;
  // to create the used datamodel object;

  User? currentUser;

  ///User registration///////
  Future<String> registerUser(UserModel userDataModel) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: userDataModel.email!, password: userDataModel.password!);
      currentUser = auth.currentUser;
      userDataModel.uid = currentUser!.uid;
      await userCollection.doc(currentUser!.uid).set(userDataModel.toMap());
      await getUser();
      return "Sucess";
    } catch (e) {
      return e.toString();
    }
  }

  ///Getting User Data/////
  Future<void> getUser() async {
    try {
      final snapshot = await userCollection.doc(auth.currentUser!.uid).get();
      userData = UserModel.fromMap(snapshot.data()!, auth.currentUser!.uid);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  ////////User Login/////
  Future<String> loginUser(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      currentUser = auth.currentUser;
      await getUser();
      if (userData!.blocked == true) {
        return "You are blocked by admin";
      }
      return "Sucess";
    } catch (e) {
      return e.toString();
    }
  }

  /////Forget password //////
  Future<String> forgetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );
      return "Sucess";
    } catch (e) {
      return e.toString();
    }
  }

  ////Checking if user is already logged in/////
  Future<bool> checkUserIsLoggedIn() async {
    try {
      await auth.currentUser?.reload();
      if (auth.currentUser!.email != null) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  //////logging out the user/////
  Future<void> logoutUser() async {
    await auth.signOut();
  }
}
