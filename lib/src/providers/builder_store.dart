import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/notification/builder_notification.dart';
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

  void notifyChange() {
    notifyListeners();
  }
  
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

  Future assignCoach(String authorization, String coachId) async {
    if (_builder == null) {
      return;
    }

    try {
      await BuildersService.instance.assignCoach(authorization, _builder, coachId);
      _builder.associatedCoach = await BuildersService.instance.getCoachForBuilder(authorization, coachId, _builder.id);
      
      notifyListeners();
    } on Exception {
      rethrow;
    }
  }
    
  Future signIntegration(String authorization) async {
    try {
      await BuildersService.instance.signIntegration(authorization, builder.id);
    } on Exception {
      rethrow;
    }

    builder.hasSignedFicheIntegration = true;
    notifyListeners();
  }

  Future markNotificationAsRead(String authorization, BuilderNotification notification) async {
    try {
      await BuildersService.instance.markNotificationAsRead(authorization, builder.id, notification.id);

      builder.associatedNotifications.remove(notification);
      notifyListeners();
    } on Exception {
      rethrow;
    }
    
    notifyListeners();
  }
}