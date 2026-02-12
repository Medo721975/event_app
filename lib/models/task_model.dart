class TaskModel {
  String title;
  String description;
  String category;
  bool isFavorite;
  int date;
  String id;
  String userId;

  TaskModel({
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    this.isFavorite = false,
    this.id = "",
    required this.userId,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
    : this(
        title: json['title'],
        description: json['description'],
        category: json['category'],
        date: json['date'],
        isFavorite: json['isFavorite'],
        id: json['id'],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "category": category,
      "isFavorite": isFavorite,
      "date": date,
      "id": id,
      "userId": userId,
    };
  }
}
