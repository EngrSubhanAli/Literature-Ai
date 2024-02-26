class StoryModel {
  String? username;
  String? email;
  String? uid;
  String? picUrl;
  int? likes;
  int? dislikes;
  List likedBy;
  List dislikedBy;
  String? storyTittle;
  String? storyBody;
  List hidenBy;
  List reportedBy;
  final bool? blocked;
  final DateTime? createdAt;
  StoryModel(
      {required this.uid,
      required this.email,
      required this.blocked,
      required this.createdAt,
      required this.dislikedBy,
      required this.dislikes,
      required this.hidenBy,
      required this.likedBy,
      required this.likes,
      required this.storyBody,
      required this.storyTittle,
      required this.picUrl,
      required this.reportedBy,
      required this.username});

  factory StoryModel.fromMap(Map<String, dynamic> data, String documentId) {
    final String uid = data['uid'];
    final String email = data['email'];
    final String username = data['username'];
    final String picUrl = data['picUrl'];
    final int likes = data['likes'];
    final int dislikes = data['dislikes'];
    final List dislikedBy = data['dislikedBy'];
    final List likedBy = data['likedBy'];
    final List reportedBy = data['reportedBy'];
    final List hidenBy = data['hidenBy'];
    final String storyTittle = data['storyTittle'];
    final String storyBody = data['storyBody'];
    final bool blocked = data['blocked'];
    final DateTime createdAt = data['createdAt'].toDate();

    return StoryModel(
        uid: uid,
        email: email,
        username: username,
        picUrl: picUrl,
        reportedBy: reportedBy,
        blocked: blocked,
        createdAt: createdAt,
        dislikedBy: dislikedBy,
        dislikes: dislikes,
        hidenBy: hidenBy,
        likedBy: likedBy,
        likes: likes,
        storyBody: storyBody,
        storyTittle: storyTittle);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      "picUrl": picUrl,
      "reportedBy": reportedBy,
      "blocked": blocked,
      "createdAt": createdAt,
      "dislikedBy": dislikedBy,
      "dislikes": dislikes,
      "hidenBy": hidenBy,
      "likedBy": likedBy,
      "likes": likes,
      "storyBody": storyBody,
      "storyTittle": storyTittle
    };
  }
}
