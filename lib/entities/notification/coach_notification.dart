class CoachNotification {
  String id;

  String coachId;
  DateTime date;
  String content;

  CoachNotification.fromMap(Map<String, dynamic> map) : 
    id = map['id'] as String,
    coachId = map['coachId'] as String,
    date = DateTime.tryParse(map['date'] as String) ?? DateTime.now(),
    content = map['content'] as String;
}