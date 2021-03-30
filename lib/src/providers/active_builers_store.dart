
import 'package:buildup/entities/builder.dart';
import 'package:buildup/services/builders_service.dart';
import 'package:buildup/services/users_service.dart';
import 'package:flutter/material.dart';

class ActiveBuildersStore with ChangeNotifier {
  List<BuBuilder>? _builders;

  void clear() {
    if (_builders != null) {
      _builders!.clear();
    }
    notifyListeners();
  }

  void builderUpdated() {
    notifyListeners();
  }

  List<BuBuilder>? get builders => _builders;

  set builders(List<BuBuilder>? newBuilders) {
    _builders = newBuilders;
    notifyListeners();
  }

  bool get hasData => _builders != null && _builders!.isNotEmpty;

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

      if (toUpdate.step != BuilderSteps.adminMeeting &&
          toUpdate.step != BuilderSteps.coachMeeting &&
          toUpdate.step != BuilderSteps.active &&
          _builders != null) {
        _builders!.remove(toUpdate);
      }

      notifyListeners();
    } on Exception {
      rethrow;
    }
  }

  
  Future refuseBuilder(String authorization, BuBuilder toRefuse) async {
    await BuildersService.instance.refuseBuilder(authorization, toRefuse.id);

    if (_builders == null) {
      _builders!.remove(toRefuse);
    }
    notifyListeners();
  }

}