class Report {
  Report({
    this.id,
    required this.userId,
    required this.startDate,
    required this.duration,
    required this.problemDescription,
    required this.rating,
  });

  int? id;
  int userId;
  int startDate;
  int duration;
  String problemDescription;
  int rating;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        userId: json["Support"],
        startDate: json["Start Date"],
        duration: json["Duration"],
        problemDescription: json["Problem Description"],
        rating: json["Rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Support": userId,
        "Start Date": startDate,
        "Duration": duration,
        "Problem Description": problemDescription,
        "Rating": rating,
      };
}
