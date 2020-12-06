import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/services/buildons_service.dart';
import 'package:flutter/material.dart';

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

}