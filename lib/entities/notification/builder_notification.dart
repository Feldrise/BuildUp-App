class BuilderNotification {
  String id;

  String builderId;
  DateTime date;
  String content;

  BuilderNotification.fromMap(Map<String, dynamic> map) : 
    id = map['id'] as String,
    builderId = map['builderId'] as String,
    date = DateTime.tryParse(map['date'] as String) ?? DateTime.now(),
    content = map['content'] as String;
}