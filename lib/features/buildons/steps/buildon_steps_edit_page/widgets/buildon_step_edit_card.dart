import 'package:buildup/core/widgets/bu_card.dart';
import 'package:buildup/features/buildons/steps/buildon_step.dart';
import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';

class BuildOnStepEditCard extends StatelessWidget {
  const BuildOnStepEditCard({
    Key? key,
    required this.step,
    required this.index,
    this.isSelected = false,
  }) : super(key: key);

  final BuildOnStep step;
  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final String stepName = step.name.isEmpty ? "Sans titre" : step.name;

    return Row(
      children: [
        // The number indicator
        Container(
          width: 32, height: 32,
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.caption!.color,
            borderRadius: BorderRadius.circular(16)
          ),
          child: Center(
            child: Text(
              index.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Palette.colorWhite), 
            ),
          ),
        ),
        const SizedBox(width: 15,),

        // The actual card
        Expanded(
          child: BuCard(
            padding: EdgeInsets.zero,
            height: 60,
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? Theme.of(context).primaryColor : Colors.transparent
                )
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 72,
                    child: Icon(Icons.drag_indicator)
                  ),
                  Expanded(
                    child: Text(stepName, style: Theme.of(context).textTheme.headline6,),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}