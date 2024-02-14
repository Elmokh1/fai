
class QuestionsModel {
  static const String collectionName = 'Questions';
  String? id;
  String? questions;
  String? answer;
  DateTime? dateTime;


  QuestionsModel({
    this.id,
    this.questions,
    this.answer,
    this.dateTime,
  });

  QuestionsModel.fromFireStore(Map<String, dynamic>? date)
      : this(
    id: date?["id"],
    questions: date?["questions"],
    answer: date?["answer"],
    dateTime: DateTime.fromMillisecondsSinceEpoch(date?["dateTime"]),
  );

  Map<String, dynamic>toFireStore() {
    return {
      "id": id,
      "questions": questions,
      "answer": answer,
      "dateTime": dateTime?.millisecondsSinceEpoch,
    };
  }
}
