import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/services/builders_service.dart';
import 'package:buildup/services/users_service.dart';
import 'package:flutter/cupertino.dart';

class BuilderStore with ChangeNotifier {
  BuBuilder _builder;

  Future loadBuilderFromUser(User associatedUser) async {
    if (_builder != null) {
      return _builder;
    }

    try {
      _builder = await BuildersService.instance.getBuilder(associatedUser.authentificationHeader, UserRoles.builder, associatedUser);
    }
    on Exception {
      rethrow;
    }

    notifyListeners();
  }

  BuBuilder get builder => _builder;

  
  Future updateBuilder(String authorization, BuBuilder toUpdate, {bool updateUser = false, bool updateProject = false}) async {
    try {
      await BuildersService.instance.updateBuilder(authorization, toUpdate);
    
      if (updateUser) {
        await UsersService.instance.updateUser(authorization, toUpdate.associatedUser);

        if (toUpdate.associatedUser.profilePicture.image != null) {
          toUpdate.associatedUser.profilePicture.isImageEvenWithServer = true;
        }
      }

      if (updateProject) {
        await BuildersService.instance.updateProject(authorization, toUpdate);
      }

      _builder = toUpdate;

      // notifyListeners();
    } on Exception {
      rethrow;
    }
  }
}