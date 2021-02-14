
import 'package:buildup/entities/bu_image.dart';
import 'package:buildup/services/users_service.dart';

class AvailableCoach {
  final String id;
  
  BuImage profilePicture;

  String firstName;
  String lastName;

  String email;
  String discordTag;

  String situation;
  String description;

  String competences;
  String perpectives;
  String coachDefinition;

  String get fullName =>  "$firstName $lastName";

  AvailableCoach(this.id, {
    this.profilePicture,
    this.firstName,
    this.lastName,
    this.email,
    this.discordTag,
    this.situation,
    this.description,
    this.competences,
    this.perpectives,
    this.coachDefinition
  });

  AvailableCoach.fromMap(Map<String, dynamic> map) : 
    id = map['id'] as String,
    
    profilePicture = BuImage("${UsersService.instance.serviceBaseUrl}/${map['userId'] as String}/profile_picture"),
    firstName = map['firstName'] as String,
    lastName = map['lastName'] as String,

    email = map['email'] as String,
    discordTag = map['discordTag'] as String,
    
    description = map['description'] as String,
    situation = map['situation'] as String,

    competences = map['competences'] as String,
    perpectives = map['perspectives'] as String,
    coachDefinition = map['coachDefinition'] as String;
}