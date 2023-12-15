class TodosModel {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  TodosModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  factory TodosModel.fromJson(Map<String, dynamic> json) => TodosModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
