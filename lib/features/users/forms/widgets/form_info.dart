import 'package:buildup/core/widgets/bu_status_message.dart';
import 'package:buildup/features/users/user.dart';
import 'package:flutter/material.dart';

class FormInfo extends StatelessWidget {
  const FormInfo({
    Key? key,
    required this.user
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    if (user.form == null) {
      return const BuStatusMessage(
        type: BuStatusMessageType.info,
        message: "Il n'y a pas de formulaire disponible",
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final item in user.form!.items) ...{
          // The question
          Text(item.question, style: const TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(height: 8,),

          // The answer
          Text(item.answer),
          const SizedBox(height: 20,)
        }
      ],
    );
  }
}