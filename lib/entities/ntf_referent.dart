class NtfReferent {
  String id;
  
  String firstName;
  String lastName;
  String email;
  String discordTag;

  String get name => "$firstName $lastName";

  NtfReferent(this.id, {
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.discordTag = ""
  });

  NtfReferent.fromMap(Map<String, dynamic> map) :
    id = map['id'] as String,
    firstName = map['firstName'] as String,
    lastName = map['lastName'] as String,
    email = map['email'] as String,
    discordTag = map['discordTag'] as String;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "discordTag": discordTag
    };
  }
}