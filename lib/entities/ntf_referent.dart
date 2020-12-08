class NtfReferent {
  String id;
  
  String name;
  String email;
  String discordTag;

  NtfReferent.fromMap(Map<String, dynamic> map) :
    id = map['id'] as String,
    name = map['name'] as String,
    email = map['email'] as String,
    discordTag = map['discordTag'] as String;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "name": name,
      "email": email,
      "discordTag": discordTag
    };
  }
}