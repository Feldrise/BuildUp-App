import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class ProcessWidget extends StatelessWidget {
  const ProcessWidget({
    Key key,
    @required this.title,
    @required this.description,
    @required this.index,
    @required this.maxSteps,
    this.child,
  }) : super(key: key);
  
  final String title;
  final List<Widget> description;

  final int index;
  final int maxSteps;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.headline3),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: index / maxSteps,
            backgroundColor: colorScaffoldGrey,
            valueColor: const AlwaysStoppedAnimation<Color>(colorPrimary),
          ),
          const SizedBox(height: 8),
          Text("Etape $index/$maxSteps", textAlign: TextAlign.center, style: const TextStyle(color: Color(0xff949c9e),),),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: colorGreyBackground,
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: Column(
              children: description
            ),
          ),
          const SizedBox(height: 32,),
          if (child != null) 
            child
        ],
      )
    );
  }
}