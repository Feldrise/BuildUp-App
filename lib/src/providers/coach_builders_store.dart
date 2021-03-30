
import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/coach.dart';
import 'package:buildup/services/coachs_services.dart';
import 'package:flutter/material.dart';

class CoachBuildersStore with ChangeNotifier {
  List<BuBuilder>? _builders;

  void clear() {
    if (_builders != null) {
      _builders!.clear();
      _builders = null;
    }
    notifyListeners();
  }

  void builderUpdated() {
    notifyListeners();
  }

  Future<List<BuBuilder>> builders(String authorization, Coach coach) async {
    return _builders ??= await CoachsService.instance.getBuildersForCoach(authorization, coach); 
  }

  List<BuBuilder>? get loadedBuilders => _builders;

  bool get hasData => _builders != null && _builders!.isNotEmpty;

}