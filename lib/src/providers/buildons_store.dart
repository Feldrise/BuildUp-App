import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/services/buildons_service.dart';
import 'package:flutter/material.dart';

class BuildOnsStore with ChangeNotifier {
  List<BuildOn> _buildOns;

  void clear() {
    _buildOns = null;
    
    notifyListeners();
  }

  void buildonUpdated() {
    notifyListeners();
  }

  void reorder({int oldIndex, int newIndex}) {
    final item = _buildOns.removeAt(oldIndex);
    _buildOns.insert(newIndex < oldIndex ? newIndex: newIndex - 1, item);

    notifyListeners();
  }

  List<BuildOn> get loadedBuildOns => _buildOns;

  Future<List<BuildOn>> buildons(String authorization) async {
    return _buildOns ??= await BuildOnsService.instance.getAllBuildOns(authorization);
  }

  bool get hasData => _buildOns != null && _buildOns.isNotEmpty;

  Future syncBuildOns(String authorization) async {
    try {
      final synced = await BuildOnsService.instance.syncBuildOns(authorization, _buildOns);

      if (synced.length != _buildOns.length) {
        throw Exception("Quelques build-ons se sont perdu en route...");
      }

      for (int i = 0; i < synced.length; ++i) {
        _buildOns[i].id = synced[i].id;
        if (_buildOns[i].image.image != null) {
          _buildOns[i].image.isImageEvenWithServer = true;
        }
      }

      notifyListeners();
    } on Exception {
      rethrow;
    }
  }

  Future syncBuildOnSteps(String authorization, BuildOn buildOn) async {
    try {
      final synced = await BuildOnsService.instance.syncBuildOnSteps(authorization, buildOn.id, buildOn.steps);

      if (synced.length != buildOn.steps.length) {
        throw Exception("Quelques étapes du build-ons se sont perdu en route...");
      }

      for (int i = 0; i < synced.length; ++i) {
        buildOn.steps[i].id = synced[i].id;
        if (buildOn.steps[i].image.image != null) {
          buildOn.steps[i].image.isImageEvenWithServer = true;
        }
      }

      notifyListeners();
    } on Exception {
      rethrow;
    }
  }
}