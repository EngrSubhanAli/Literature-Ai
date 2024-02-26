import 'package:flutter/material.dart';
import 'package:mvvm/models/story_data_model.dart';
import 'package:mvvm/services/firebase_db/firebase_db.dart';

class PostStoryViewModel extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodycController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

//////loading state function/////
  void changeLoadingState() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

/////Dispose Funtion/////
  void disposeLoginControllers() {
    titleController = TextEditingController();
    bodycController = TextEditingController();
  }

  ///Upload Story////
  Future<String> uploadServeyData() async {
    changeLoadingState();
    try {
      StoryModel storyModel = StoryModel(
          uid: userData!.uid,
          email: userData!.email,
          blocked: false,
          createdAt: DateTime.now(),
          dislikedBy: [],
          dislikes: 0,
          hidenBy: [],
          likedBy: [],
          likes: 0,
          storyBody: bodycController.text,
          storyTittle: titleController.text,
          picUrl: userData!.picUrl,
          reportedBy: [],
           username: userData!.username);

      await FirebaseDBService().uploadStory(storyModel);
      changeLoadingState();
      return "Sucess";
    } catch (e) {
      changeLoadingState();
      return e.toString();
    }
  }
}
