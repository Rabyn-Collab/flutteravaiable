



class Comment{
  final String username;
  final String imageUrl;
  final String text;

  Comment({
   required this.imageUrl,
   required this.text,
   required this.username
});

  factory Comment.fromJson(Map<String, dynamic> json){
    return Comment(
        imageUrl: json['imageUrl'],
        text: json['text'],
        username: json['username']
    );
  }

}

class Like{
  final int totalLikes;
  final List<String> usernames;
  Like({required this.totalLikes, required this.usernames});

  factory Like.fromJson(Map<String, dynamic> json){
    return Like(
     totalLikes: json['totalLikes'],
      usernames: (json['usernames'] as List).map((e) => e as String).toList()
    );
  }
}

class Post{

final String title;
final String detail;
final String imageUrl;
final String id;
final String uid;
final List<Comment> comments;
final Like like;
final String imageId;


Post({
  required this.imageUrl,
  required this.uid,
  required this.id,
  required this.comments,
  required this.detail,
  required this.like,
  required this.title,
  required this.imageId
});




}