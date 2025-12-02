class User {
  final String name;
  final String mobile;
  final String password;

  User({
    required this.name,
    required this.mobile,
    required this.password,
  });

  // JSON map to Dart User object
  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      password: json['password'] as String,
    );

  // Dart User object to JSON map
  Map<String, dynamic> toJson() => {
      'name': name,
      'mobile': mobile,
      'password': password,
    };
}
