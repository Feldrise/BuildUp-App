
import 'package:buildup/entities/coach.dart';
import 'package:buildup/services/coachs_services.dart';
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

  Future updateCoach(String authorization, Coach toUpdate, {bool updateUser}) async {
    await CoachsService.instance.updateCoach(authorization, toUpdate);
    // TODO: update user if necessary

    if (toUpdate.step != CoachSteps.active) {
      _coachs.remove(toUpdate);
    }

    notifyListeners();
  }
}