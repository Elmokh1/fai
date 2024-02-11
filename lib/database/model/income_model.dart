class Income {
  static const String collectionName = 'income';
  String? id;
  String? clientName;
  double? DailyInCome;
  DateTime? dateTime;

  Income({
    this.DailyInCome,
    this.id,
    this.clientName,
    this.dateTime,
  });

  Income.fromFireStore(Map<String, dynamic>? date)
      : this(
          id: date?["id"],
          DailyInCome: date?["DailyInCome"],
          clientName: date?["clientName"],
          dateTime: DateTime.fromMillisecondsSinceEpoch(date?["dateTime"]),
        );

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "DailyInCome": DailyInCome,
      "clientName": clientName,
      "dateTime": dateTime?.millisecondsSinceEpoch,

    };
  }
}
