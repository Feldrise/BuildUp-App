import 'package:buildup/core/widgets/bu_card.dart';
import 'package:buildup/core/widgets/titled_card_bar.dart';
import 'package:buildup/features/users/forms/widgets/form_info.dart';
import 'package:buildup/features/users/user.dart';
import 'package:flutter/material.dart';

class FormCard extends StatelessWidget {
  const FormCard({
    Key? key,
    required this.user
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TitledCardBar(title: "Réponses au formulaire"),
          const SizedBox(height: 30,),

          Flexible(child: FormInfo(user: user,))
        ],
      ),
    );
  }
}