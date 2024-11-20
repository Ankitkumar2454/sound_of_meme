class User {
  final String name;
  final String email;
  final String? profileUrl;

  User({
    required this.name,
    required this.email,
    this.profileUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      profileUrl: json['profile_url'] as String?,
    );
  }
}
