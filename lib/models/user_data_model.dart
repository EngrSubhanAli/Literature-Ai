//
/// Model class for userModel to add the user data to the firebase and get it from the firebase;
//
class UserModel {
   String? username;
   String? email;
   String? uid;
   String? picUrl;
   String? password;
  final bool? reported;
  final bool? blocked;
  final DateTime? createdAt;
  UserModel(
      {required this.uid,
      required this.email,
      required this.blocked,
      required this.createdAt,
      required this.password,
      required this.picUrl,
      required this.reported,
      required this.username});

  factory UserModel.fromMap(Map<String, dynamic> data) {
    final String uid = data['uid'];
    final String email = data['email'];
    final String username = data['username'];
    final String picUrl = data['picUrl'];
    final String password = data['password'];
    final bool reported = data['reported'];
    final bool blocked = data['blocked'];
    final DateTime createdAt =   data['createdAt'].toDate();

    return UserModel(
        uid: uid,
        email: email,
        username: username,
        password: password,
        picUrl: picUrl,
        reported: reported,
        blocked: blocked,
        createdAt: createdAt);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      "picUrl": picUrl,
      "password": password,
      "reported": reported,
      "blocked": blocked,
      "createdAt": createdAt
    };
  }
}
