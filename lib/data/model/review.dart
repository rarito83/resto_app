class Review {
  Review({
    this.name,
    this.review,
    this.date,
  });

  String? name;
  String? review;
  String? date;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    name: json["name"],
    review: json["review"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "review": review,
    "date": date,
  };
}