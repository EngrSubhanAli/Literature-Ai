import 'package:mvvm/Core/constant/assets.dart';

// Define a class for the post
class Post {
  final String name;
  final String time;

  final String title;
  final String description;
  final String imageUrl;
  final int likes;
  final int dislikes;
  final int? rank;

  Post({
    this.rank,
    required this.name,
    required this.likes,
    required this.dislikes,
    required this.time,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

List<Post> posts = [
  Post(
    name: 'John Doe',
    time: '10:00 AM',
    title: 'First Post',
    description: loremipsum,
    imageUrl: profil2,
    likes: 3,
    rank: 1,
    dislikes: 5,
  ),
  Post(
    name: 'Jane Smith',
    time: '11:00 AM',
    title: 'Second Post',
    rank: 2,
    description: loremipsum,
    imageUrl: profil2,
    likes: 2,
    dislikes: 1,
  ),
  Post(
    name: 'Alice Johnson',
    time: '12:00 PM',
    title: 'Third Post',
    description: loremipsum,
    imageUrl: profil2,
    likes: 5,
    rank: 3,
    dislikes: 23,
  ),
  Post(
    name: 'Jane Smith',
    time: '11:00 AM',
    title: 'Second Post',
    description: loremipsum,
    imageUrl: profil2,
    rank: 4,
    likes: 2,
    dislikes: 1,
  ),
  Post(
    name: 'Alice Johnson',
    time: '12:00 PM',
    title: 'Third Post',
    description: loremipsum,
    rank: 5,
    imageUrl: profil2,
    likes: 5,
    dislikes: 23,
  ),
  Post(
    name: 'Jane Smith',
    time: '11:00 AM',
    title: 'Second Post',
    description: loremipsum,
    imageUrl: profil2,
    rank: 6,
    likes: 2,
    dislikes: 1,
  ),
  Post(
    name: 'Alice Johnson',
    time: '12:00 PM',
    title: 'Third Post',
    description: loremipsum,
    imageUrl: profil2,
    rank: 8,
    likes: 5,
    dislikes: 23,
  ),
];
