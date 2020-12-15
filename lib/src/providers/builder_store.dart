import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/services/builders_service.dart';
import 'package:flutter/cupertino.dart';

class BuilderStore with ChangeNotifier {
  BuBuilder _builder;

  Future loadBuilderFromUser(User associatedUser) async {
    if (_builder != null) {
      return _builder;
    }
    
    try {
      _builder = await BuildersService.instance.getBuilder(associatedUser.authentificationHeader, associatedUser);
    }
    on Exception {
      rethrow;
    }

    notifyListeners();
  }

  BuBuilder get builder => _builder;
}