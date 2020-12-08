
import 'package:buildup/entities/forms/bu_form.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:flutter/material.dart';

class AdminActiveMemeberFormCard extends StatelessWidget {
  const AdminActiveMemeberFormCard({Key key, @required this.form}) : super(key: key);
  
  final BuForm form;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text("Réponses au formulaire", style: Theme.of(context).textTheme.headline3,),
          ),
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