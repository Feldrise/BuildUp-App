import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/services/buildons_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuildOnsStore with ChangeNotifier {
  List<BuildOn> _buildOns;

  void clear() {
    if (_buildOns != null) {
      _buildOns.clear();
    }
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
        _buildOns[i].image.isImageEvenWithServer = true;
      }

      notifyListeners();
    } on Exception {
      rethrow;
    }
  }
}