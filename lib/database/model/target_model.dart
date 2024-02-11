
class Target {
  static const String collectionName = 'target';
  String? id;
  double? DailyTarget;
  String? clientName;
  DateTime? dateTime;

  Target({
    this.DailyTarget,
    this.id,
    this.clientName,
    this.dateTime,
  });

  Target.fromFireStore(Map<String, dynamic>? date)
      : this(
    id: date?["id"],
    DailyTarget: date?["DailyTarget"],
    clientName: date?["clientName"],
    dateTime: DateTime.fromMillisecondsSinceEpoch(date?["dateTime"]),

  );

  Map<String, dynamic>toFireStore() {
    return {
      "id": id,
      "DailyTarget": DailyTarget,
      "clientName": clientName,
      "dateTime": dateTime?.millisecondsSinceEpoch,
    };
  }
}
