
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

  List<String> questions;
  List<String> answers;

  String get fullName =>  "$firstName $lastName";

  AvailableCoach(this.id, {
    required this.profilePicture,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.discordTag,
    required this.situation,
    required this.description,
    required this.competences,
    required this.questions,
    required this.answers
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
    
    questions = (map['questions'] as List<dynamic>).cast(),
    answers = (map['answers'] as List<dynamic>).cast();
}