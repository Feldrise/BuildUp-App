import 'package:buildup/entities/builder.dart';
import 'package:flutter/material.dart';

class BuildersStore with ChangeNotifier {
  final List<BuBuilder> _builders = [];

  void clear() {
    _builders.clear();
    notifyListeners();
  }

  void addBuilder(BuBuilder toAdd) {
    _builders.add(toAdd);
    notifyListeners();
  }

  void builderUpdated() {
    notifyListeners();
  }

  List<BuBuilder> get candidatingBuilder {
    List<BuBuilder> result;

    for (final builder in _builders) {
      if (builder.status == BuilderStatus.candidating) {
        result.add(builder);
      }
    }

    return result;
  }
}