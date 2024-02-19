//
/// Model class for userModel to add the user data to the firebase and get it from the firebase;
//
class UserModel {
  final String? userId;
  final String? email;

  UserModel({this.userId, this.email});

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    final String userId = data['userId'];
    final String email = data['email'];

    return UserModel(userId: userId, email: email);
  }

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'email': email};
  }
}
