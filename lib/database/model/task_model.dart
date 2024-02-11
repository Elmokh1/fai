class Task {
  static const String collectionName = 'tasks';
  String? id;
  String? title;
  String? desc;
  DateTime? dateTime;
  bool isDone;
  double? DailyTarget;
  double? Income;


  Task({
    this.id,
    this.title,
    this.desc,
    this.dateTime,
    this.DailyTarget,
    this.Income = 0,
    this.isDone = false,
  });

  Task.fromFireStore(Map<String, dynamic>? date)
      : this(
          id: date?["id"],
          title: date?["title"],
          desc: date?["desc"],
          dateTime: DateTime.fromMillisecondsSinceEpoch(date?["dateTime"]),
          isDone: date?["isDone"],
    DailyTarget: date?["DailyTarget"],
    Income: date?["Income"],
        );

  Map<String,dynamic>toFireStore() {
    return {
      "id": id,
      "title": title,
      "desc": desc,
      "dateTime": dateTime?.millisecondsSinceEpoch,
      "isDone": isDone,
      "DailyTarget": DailyTarget,
      "Income": Income,
    };
  }
}
