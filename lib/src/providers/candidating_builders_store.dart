import 'package:buildup/entities/builder.dart';
import 'package:buildup/services/builders_service.dart';
import 'package:flutter/material.dart';

class CandidatingBuilderStore with ChangeNotifier {
  List<BuBuilder> _builders;

  void clear() {
    _builders.clear();
    notifyListeners();
  }

  void builderUpdated() {
    notifyListeners();
  }

  List<BuBuilder> get builders => _builders;
  set builders(List<BuBuilder> newBuilder) {
    _builders = newBuilder;
    notifyListeners();
  }

  bool get hasData => _builders != null && _builders.isNotEmpty;

    Future refuseBuilder(String authorization, BuBuilder toRefuse) async {
    await BuildersService.instance.refuseBuilder(authorization, toRefuse.id);

    _builders.remove(toRefuse);
    notifyListeners();
  }
}