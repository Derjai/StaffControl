class Client {
  Client({
    this.id,
    // ignore: non_constant_identifier_names
    required this.Name,
  });

  int? id;
  // ignore: non_constant_identifier_names
  String Name;

  String get getName => Name;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        Name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": Name,
      };
}
