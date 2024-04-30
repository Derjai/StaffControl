class User {
  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  int? id;
  String name;
  String email;
  String password;

  String get getName => name;
  String get getEmail => email;
  String get getPassword => password;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
      };
}
