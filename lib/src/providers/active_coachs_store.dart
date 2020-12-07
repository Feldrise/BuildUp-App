
import 'package:buildup/entities/coach.dart';
import 'package:buildup/services/coachs_services.dart';
import 'package:buildup/services/users_service.dart';
import 'package:flutter/material.dart';

class ActiveCoachsStore with ChangeNotifier {
  List<Coach> _coachs;

  void clear() {
    if (_coachs != null) {
      _coachs.clear();
    }
    notifyListeners();
  }

  void coachUpdated() {
    notifyListeners();
  }

  List<Coach> get coachs => _coachs;
  set coachs(List<Coach> newCoachs) {
    _coachs = newCoachs;
    notifyListeners();
  }

  bool get hasData => _coachs != null && _coachs.isNotEmpty;

  Future updateCoach(String authorization, Coach toUpdate, {bool updateUser = false}) async {
    try {
      await CoachsService.instance.updateCoach(authorization, toUpdate);
    
      if (updateUser) {
        await UsersService.instance.updateUser(authorization, toUpdate.associatedUser);

        if (toUpdate.associatedUser.profilePicture.image != null) {
          toUpdate.associatedUser.profilePicture.isImageEvenWithServer = true;
        }
      }

      if (toUpdate.step != CoachSteps.active) {
        _coachs.remove(toUpdate);
      }

      notifyListeners();
    } on Exception {
      rethrow;
    }
  }

  
  Future refuseCoach(String authorization, Coach toRefuse) async {
    await CoachsService.instance.refuseCoach(authorization, toRefuse.id);

    _coachs.remove(toRefuse);
    notifyListeners();
  }

}