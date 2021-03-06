
import 'package:buildup/entities/coach.dart';
import 'package:buildup/entities/notification/coach_notification.dart';
import 'package:buildup/entities/notification/coach_request.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/services/coachs_services.dart';
import 'package:buildup/services/users_service.dart';
import 'package:flutter/foundation.dart';

class CoachStore with ChangeNotifier {
  Coach? _coach;

  Future loadCoachFromUser(User associatedUser) async {
    if (_coach != null) {
      return _coach;
    }

    try {
      _coach = await CoachsService.instance.getCoach(associatedUser.authentificationHeader, associatedUser);
    }
    on Exception {
      rethrow;
    }

    notifyListeners();
  }

  Coach? get coach => _coach;

  void notifyChange() {
    notifyListeners();
  }

  Future updateCoach(String authorization, Coach toUpdate, {bool updateUser = false}) async {
    try {
      await CoachsService.instance.updateCoach(authorization, toUpdate);
    
      if (updateUser) {
        await UsersService.instance.updateUser(authorization, toUpdate.associatedUser);

        if (toUpdate.associatedUser.profilePicture.image != null) {
          toUpdate.associatedUser.profilePicture.isImageEvenWithServer = true;
        }
      }
    } on Exception {
      rethrow;
    }
  }

  Future signIntegration(String authorization) async {
    if (_coach == null) {
      return;
    }

    try {
      await CoachsService.instance.signIntegration(authorization, coach!.id);
    } on Exception {
      rethrow;
    }

    coach!.hasSignedFicheIntegration = true;
    notifyListeners();
  }

  Future acceptCoachRequest(String authorization, CoachRequest request) async {
    if (_coach == null && _coach!.associatedRequest == null) {
      return;
    }

    try {
      await CoachsService.instance.acceptCoachRequest(authorization, coach!.id, request.id);

      coach!.associatedRequest!.remove(request);
      notifyListeners();
    } on Exception {
      rethrow;
    }

    notifyListeners();
  }

  Future refuseCoachRequest(String authorization, CoachRequest request) async {
    if (_coach == null && _coach!.associatedRequest == null) {
      return;
    }

    try {
      await CoachsService.instance.refuseCoachRequest(authorization, coach!.id, request.id);

      coach!.associatedRequest!.remove(request);
      notifyListeners();
    } on Exception {
      rethrow;
    }

    notifyListeners();
  }

  Future markNotificationAsRead(String authorization, CoachNotification notification) async {
    if (_coach == null && _coach!.associatedNotifications == null) {
      return;
    }

    try {
      await CoachsService.instance.markNotificationAsRead(authorization, coach!.id, notification.id);

      coach!.associatedNotifications!.remove(notification);
      notifyListeners();
    } on Exception {
      rethrow;
    }

    notifyListeners();
  }
}