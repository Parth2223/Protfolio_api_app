class AlbumsModel {
  int? userId;
  int? id;
  String? title;

  AlbumsModel({
    this.userId,
    this.id,
    this.title,
  });

  factory AlbumsModel.fromJson(Map<String, dynamic> json) => AlbumsModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
