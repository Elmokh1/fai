
class AddPostModel {
  static const String collectionName = 'Posts';
  String? id;
  String? uId;
  String? title;
  String? content;
  DateTime? dateTime;
  String? photo ;
  AddPostModel({
    this.id,
    this.title,
    this.content,
    this.dateTime,
     this.photo,
    this.uId
  });

  AddPostModel.fromFireStore(Map<String, dynamic>? date)
      : this(
    id: date?["id"],
    uId: date?["uId"],
    title: date?["title"],
    content: date?["content"],
    photo: date?["photo"],
    dateTime: DateTime.fromMillisecondsSinceEpoch(date?["dateTime"]),

  );

  Map<String, dynamic>toFireStore() {
    return {
      "id": id,
      "uId": uId,
      "title": title,
      "content": content,
      "photo": photo,
      "dateTime": dateTime?.millisecondsSinceEpoch,
    };
  }
}