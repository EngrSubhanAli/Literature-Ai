import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/models/story_data_model.dart';
import '../../models/user_data_model.dart';

UserModel? userData;

class FirebaseDBService {
  // Firebase-related operations (authentication, database interactions, etc.)

  // this is the collection name in firestore
  static var userCollection = FirebaseFirestore.instance.collection('users');
  // this is the collection name in firestore
  static var postCollection = FirebaseFirestore.instance.collection('Posts');
  static var storyCollection = FirebaseFirestore.instance.collection('Stroies');
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
           await userCollection
          .where("email", isEqualTo:auth.currentUser!.email)
          .get()
          .then((value) async {
        String id = value.docs[0].id;
        final snapshot = await userCollection.doc(id).get();
        userData = UserModel.fromMap(snapshot.data()!);
      });
      // final snapshot = await userCollection.doc(auth.currentUser!.uid).get();
      // userData = UserModel.fromMap(snapshot.data()!);
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

  int hoursDifference(DateTime dateTime1, DateTime dateTime2) {
    // Calculate the difference in milliseconds
    int differenceInMilliseconds =
        dateTime1.difference(dateTime2).inMilliseconds;

    // Convert milliseconds to hours
    double differenceInHours =
        differenceInMilliseconds.abs() / (1000 * 60 * 60);

    // Return the difference in hours as an integer
    return differenceInHours.toInt();
  }

  ////////Uploading uploadStory Data//////
  Future<String> uploadStory(StoryModel storymodel) async {
    try {
      await postCollection.doc().set(storymodel.toMap());

      await storyCollection.doc(userData!.uid).set({
        "username": userData!.username,
        "storyTittle": storymodel.storyTittle,
        "storyBody": storymodel.storyBody,
        "uid": userData!.uid,
        "picUrl": userData!.picUrl,
        "createdAt": DateTime.now(),
      });

      await storyCollection.doc(userData!.uid).update({
        "username": userData!.username,
        "storyTittle": storymodel.storyTittle,
        "storyBody": storymodel.storyBody,
        "uid": userData!.uid,
        "picUrl": userData!.picUrl,
        "createdAt": DateTime.now(),
      });

      await storyCollection
          .doc(userData!.uid)
          .collection("storyList")
          .doc()
          .set(storymodel.toMap());

      await storyCollection
          .doc(userData!.uid)
          .collection("storyList")
          .get()
          .then((querySnapshot) async {
        // ignore: avoid_function_literals_in_foreach_calls
        querySnapshot.docs.forEach((doc) async {
          final createdAt = doc.data()['createdAt'].toDate();
          final dateTime1 = DateTime.now();
          final dateTime2 = createdAt;

          if (hoursDifference(dateTime1, dateTime2) > 24) {
            await storyCollection
                .doc(userData!.uid)
                .collection("storyList")
                .doc(doc.id)
                .delete();
          }
        });
      });

      return "Sucess";
    } catch (e) {
      return e.toString();
    }
  }

////Update Likes//////
  Future<String> updateLikes(DocumentSnapshot snapshot, int likes, int dislikes,
      List dislikedBy, List likedBy) async {
    try {
      await FirebaseFirestore.instance
          .collection("Posts")
          .doc(snapshot.id)
          .update({
        "dislikedBy": dislikedBy,
        "likedBy": likedBy,
        'likes': likes,
        "dislikes": dislikes
      });
      return "Sucess";
    } catch (e) {
      return e.toString();
    }
  }

//////Fetch userStories//////
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchUserStories(
      DocumentSnapshot userData) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> storiesSnapshot = [];
    await storyCollection
        .doc(userData.id)
        .collection("storyList")
        .orderBy("createdAt", descending: true)
        .get()
        .then((querySnapshot) async {
      // ignore: avoid_function_literals_in_foreach_calls
      querySnapshot.docs.forEach((doc) async {
        final createdAt = doc.data()['createdAt'].toDate();
        final dateTime1 = DateTime.now();
        final dateTime2 = createdAt;

        if (hoursDifference(dateTime1, dateTime2) < 24) {
          storiesSnapshot.add(doc);
        }
      });
    });

    return storiesSnapshot;
  }

  /////delete User//
  Future<String> reauthenticateAndDeleteAccount() async {
    // Get the currently signed-in user
    User? user = FirebaseAuth.instance.currentUser;

    // Check if the user is signed in
    if (user != null) {
      // Create a credential using the user's email and password
      AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!, password: userData!.password!);

      // Re-authenticate the user with the credential
      await user.reauthenticateWithCredential(credential);
      await userCollection.doc(userData!.uid).delete();
      await storyCollection
          .doc(userData!.uid)
          .collection("storyList")
          .get()
          .then((value) async {
        for (int i = 0; i < value.docs.length; i++) {
          await storyCollection
              .doc(userData!.uid)
              .collection("storyList")
              .doc(value.docs[i].id)
              .delete();
        }
      });
      await storyCollection.doc(userData!.uid).delete();
      await postCollection
          .where("uid", isEqualTo: userData!.uid)
          .get()
          .then((value) async {
        for (int i = 0; i < value.docs.length; i++) {
          await postCollection.doc(value.docs[i].id).delete();
        }
      });

      // Delete the user account
      await user.delete();

      return 'sucess';
    } else {
      return 'No user signed in.';
    }
  }
}
