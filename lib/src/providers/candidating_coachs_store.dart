
import 'package:buildup/entities/coach.dart';
import 'package:buildup/services/coachs_services.dart';
import 'package:flutter/material.dart';

class CandidatingCoachsStore with ChangeNotifier {
  List<Coach> _coachs;

  void clear() {
    if (_coachs != null) {
      _coachs.clear();
    }
    notifyListeners();
  }

  void builderUpdated() {
    notifyListeners();
  }

  List<Coach> get coachs => _coachs;
  set coachs(List<Coach> newCoachs) {
    _coachs = newCoachs;
    notifyListeners();
  }

  bool get hasData => _coachs != null && _coachs.isNotEmpty;

  Future refuseCoach(String authorization, Coach toRefuse) async {
    await CoachsService.instance.refuseCoach(authorization, toRefuse.id);

    _coachs.remove(toRefuse);
    notifyListeners();
  }

  Future updateCoach(String authorization, Coach toUpdate) async {
    // We prevent builder to stay preselected
    if (toUpdate.status != CoachStatus.candidating &&
        toUpdate.step == CoachSteps.preselected) {
      toUpdate.step = CoachSteps.meetingDone;
    }

    await CoachsService.instance.updateCoach(authorization, toUpdate);

    if (toUpdate.status != CoachStatus.candidating) {
      _coachs.remove(toUpdate);
    }

    notifyListeners();
  }
}