import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvvm/Core/constant/constan.dart';
import 'package:mvvm/services/firebase_db/firebase_db.dart';

class HomeScreenViewModel extends ChangeNotifier {
  bool _condition = true;
  bool get condition => _condition;
  void toggleCondition(bool condition) {
    _condition = condition;

    notifyListeners(); // Notify listeners about the change
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void currentIndexCondition(int currentIndexcondition) {
    _currentIndex = currentIndexcondition;

    notifyListeners(); // Notify listeners about the change
  }

  String _setStateForHome = AppConstants.fromhome;
  String get setStateForHome => _setStateForHome;
  void setStateforHome(String setStateforHome) {
    _setStateForHome = setStateforHome;

    notifyListeners(); // Notify listeners about the change
  }

  void toggleLike(DocumentSnapshot snapshot) {
    List likedBy = snapshot["likedBy"];
    List dislikedBy = snapshot["dislikedBy"];
    int likes = snapshot["likes"];
    int dislikes = snapshot["dislikes"];
    debugPrint(likedBy.toString());
    debugPrint(dislikedBy.toString());

    if (likedBy.contains(userData!.uid)) {
      likedBy.remove(userData!.uid);
      likes -= 1;
    } else {
      likedBy.add(userData!.uid);
      likes += 1;
      if (dislikedBy.contains(userData!.uid)) {
        dislikedBy.remove(userData!.uid);
        dislikes -= 1;
      }
    }
    FirebaseDBService()
        .updateLikes(snapshot, likes, dislikes, dislikedBy, likedBy);
  }

  void toggleDislike(DocumentSnapshot snapshot) {
    List likedBy = snapshot["likedBy"];
    List dislikedBy = snapshot["dislikedBy"];
    int likes = snapshot["likes"];
    int dislikes = snapshot["dislikes"];

    debugPrint(likedBy.toString());
    debugPrint(dislikedBy.toString());

    if (dislikedBy.contains(userData!.uid)) {
      dislikedBy.remove(userData!.uid);
      dislikes -= 1;
    } else {
      dislikedBy.add(userData!.uid);
      dislikes += 1;
      if (dislikedBy.contains(userData!.uid)) {
        likedBy.remove(userData!.uid);
        likes -= 1;
      }
    }
    FirebaseDBService()
        .updateLikes(snapshot, likes, dislikes, dislikedBy, likedBy);
  }

  Future<void> hideStory(DocumentSnapshot snapshot) async {
    debugPrint(snapshot.id.toString());
    await FirebaseFirestore.instance
        .collection("Posts")
        .doc(snapshot.id)
        .update({
      "hidenBy": FieldValue.arrayUnion([userData!.uid])
    });
    Fluttertoast.showToast(
      msg: "Story hidden sucessfully",
      // toastLength: Toast
      //     .LENGTH_SHORT, // or Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
      timeInSecForIosWeb: 1, // Time duration for iOS and web
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> reportUser(DocumentSnapshot snapshot) async {
    debugPrint(snapshot.id.toString());
    await FirebaseFirestore.instance
        .collection("Posts")
        .doc(snapshot.id)
        .update({
      "reportedBy": FieldValue.arrayUnion([userData!.uid])
    });
    Fluttertoast.showToast(
      msg: "User reported sucessfully",
      // toastLength: Toast
      //     .LENGTH_SHORT, // or Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
      timeInSecForIosWeb: 1, // Time duration for iOS and web
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> deleteStory(DocumentSnapshot snapshot) async {
    debugPrint(snapshot.id.toString());
    await FirebaseFirestore.instance
        .collection("Posts")
        .doc(snapshot.id)
        .delete();

    await FirebaseFirestore.instance
        .collection("Stroies")
        .doc(userData!.uid)
        .collection("storyList")
        .where("storyBody", isEqualTo: snapshot["storyBody"])
        .where("storyTittle", isEqualTo: snapshot["storyTittle"])
        .get()
        .then((value) async {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Stroies")
          .doc(userData!.uid)
          .collection("storyList")
          .get();

      if (querySnapshot.docs.length < 2) {
        await FirebaseFirestore.instance
            .collection("Stroies")
            .doc(userData!.uid)
            .update({
          "createdAt": DateTime.now().subtract(const Duration(days: 2))
        });
      }

      await FirebaseFirestore.instance
          .collection("Stroies")
          .doc(userData!.uid)
          .collection("storyList")
          .doc(value.docs[0].id)
          .delete();
    });

    Fluttertoast.showToast(
      msg: "Story deleted sucessfully",
      // toastLength: Toast
      //     .LENGTH_SHORT, // or Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
      timeInSecForIosWeb: 1, // Time duration for iOS and web
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
