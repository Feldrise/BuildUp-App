
import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:flutter/material.dart';

class AdminActiveCoachFormCard extends StatelessWidget {
  const AdminActiveCoachFormCard({Key key, @required this.coach}) : super(key: key);
  
  final Coach coach;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text("Réonses au formulaire", style: Theme.of(context).textTheme.headline3,),
          ),
          const SizedBox(height: 30,),
          for (final qa in coach.associatedForm.qas) 
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