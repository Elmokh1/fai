class clientInvoiceModel {
  static const String collectionName = 'clientInvoiceModel';
  String? id;
  String? clientName;
  double? oldDebt;
  double? payment;
  double? newDebt;
  DateTime? dateTime;
  bool? isInvoice;

  clientInvoiceModel({
    this.oldDebt,
    this.id,
    this.clientName,
    this.payment,
    this.dateTime,
    this.newDebt,
    this.isInvoice = false,
  });

  clientInvoiceModel.fromFireStore(Map<String, dynamic>? date)
      : this(
    id: date?["id"],
    oldDebt: date?["oldDebt"],
    clientName: date?["clientName"],
    payment: date?["payment"],
    newDebt: date?["newDebt"],
    isInvoice: date?["isInvoice"],
    dateTime: DateTime.fromMillisecondsSinceEpoch(date?["dateTime"]),

  );

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "oldDebt": oldDebt,
      "clientName": clientName,
      "payment": payment,
      "newDebt": newDebt,
      "isInvoice": isInvoice,
      "dateTime": dateTime?.millisecondsSinceEpoch,
    };
  }
}
