


class User{

  final String username;

  final String email;
  final String token;
  final String id;


  User({
    required this.id,
    required this.username,
    required this.email,
    required this.token
});


  factory User.fromJson(Map<String, dynamic> json){
    return User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        token: json['token']
    );
  }

}