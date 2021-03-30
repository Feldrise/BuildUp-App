class MeetingReport {
  String? id;

  DateTime date;
  DateTime nextMeetingDate;

  String objectif;
  String evolution;
  String whatsNext;
  String comments;

  MeetingReport(this.id,{
    required this.date,
    required this.nextMeetingDate,
    this.objectif = "",
    this.evolution = "",
    this.whatsNext = "",
    this.comments = "",
  });

  MeetingReport.fromMap(Map<String, dynamic> map) : 
    id = map['id'] as String?,
    date = DateTime.tryParse(map['date'] as String) ?? DateTime.now(),
    nextMeetingDate = DateTime.tryParse(map['nextMeetingDate'] as String) ?? DateTime.now(),
    objectif  = map['objectif'] as String,
    evolution = map['evolution'] as String,
    whatsNext = map['whatsNext'] as String,
    comments = map['comments'] as String;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "nextMeetingDate": nextMeetingDate.toIso8601String(),
      "objectif": objectif,
      "evolution": evolution,
      "whatsNext": whatsNext,
      "comments": comments
    };
  }
}