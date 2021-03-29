mixin CoachRequestStatus {
  static const String accepted = "Accepted";
  static const String waiting = "Waiting";
  static const String refused = "Refused";

  static const Map<String, String> detailled = {
    accepted: "Accepté",
    waiting: "En attente",
    refused: "Refusé"
  };
}

class CoachRequest {
  String id;
  String coachId;
  String builderId;
  String status;

  CoachRequest(this.id, {
    required this.coachId,
    required this.builderId,
    required this.status,
  });

  CoachRequest.fromMap(Map<String, dynamic> map) : 
    id = map['id'] as String,
    coachId = map['coachId'] as String,
    builderId = map['builderId'] as String,
    status = map['status'] as String;
}