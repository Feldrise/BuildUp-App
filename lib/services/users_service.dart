import 'package:buildup/utils/constants.dart';

class UsersService {
  UsersService._privateConstructor();

  final String serviceBaseUrl = "$kApiBaseUrl/users";

  static final UsersService instance = UsersService._privateConstructor();
}