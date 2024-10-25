class User {
  int id;
  String name;
  String email;
  String password;
  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password});
  // From JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'] ?? "",
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
