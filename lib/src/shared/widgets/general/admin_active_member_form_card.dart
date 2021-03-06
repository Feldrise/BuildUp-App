
import 'package:buildup/entities/forms/bu_form.dart';
import 'package:buildup/src/shared/widgets/general/bu_titled_card_bar.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:flutter/material.dart';

class MemberFormCard extends StatelessWidget {
  const MemberFormCard({Key? key, required this.form}) : super(key: key);
  
  final BuForm form;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BuTitledCardBar(title: "Réponses au formulaire",),
          const SizedBox(height: 30,),
          for (final qa in form.qas) 
            _buildBigInfo(qa.question, qa.answer)
        ],
      ),
    );
  }
  
  Widget _buildBigInfo(String title, String info) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 7,),
            Text(info)
          ],  
        ),
      ),
    );
  } 
}