import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_data_model.dart';

class FirebaseDBService {
  // Firebase-related operations (authentication, database interactions, etc.)

  // this is the collection name in firestore
  static var userCollection = FirebaseFirestore.instance.collection('users');
  // to create the used datamodel object;
  UserModel? userData;

  // for add the user data to the firebase
  /// [userDataModel] is the user data model object;
  Future<String> addUserData(UserModel userDataModel) async {
    await userCollection.doc('current_user_uid').set(userDataModel.toMap());
    await getUser('current_user_uid');
    return 'user is add successfully';
  }

  //Get the user data form the firebase;
  /// [id] is the user id;
  Future<UserModel?> getUser(String id) async {
    log('@getUser: id: $id');
    try {
      final snapshot = await userCollection.doc(id).get();
      log('User Data: ${snapshot.data()}');
      userData = UserModel.fromMap(snapshot.data()!, id);
      return UserModel.fromMap(snapshot.data()!, id);
    } catch (e) {
      log('Exception @DatabaseService/getUser $e');
      return UserModel();
    }
  }
}
