import 'package:buildup/entities/forms/form_qa.dart';

class BuForm {
  final List<FormQA> qas = [];

  BuForm.fromList(List<dynamic> qasList) {
    for (final qa in qasList) {
      qas.add(FormQA.fromMap(qa as Map<String, dynamic>));
    }
  }
}