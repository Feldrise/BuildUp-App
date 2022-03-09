import 'package:buildup/core/widgets/bu_card.dart';
import 'package:buildup/features/buildons/steps/buildon_step.dart';
import 'package:buildup/features/project/proofs/proof.dart';
import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';

class BuildOnStepStepperDetail extends StatelessWidget {
  const BuildOnStepStepperDetail({
    Key? key,
    required this.step,
    this.associatedProof,
  }) : super(key: key);

  final BuildOnStep step;
  final Proof? associatedProof;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Row(
        children: [
          // The image
          Flexible(
            flex: 3,
            child: Container(
              color: Palette.colorLightGrey3,
            ),
          ),
          const SizedBox(width: 12,),
    
          // The info
          Flexible(
            flex: 7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // The title
                Flexible(
                  child: Text(step.name, style: Theme.of(context).textTheme.headline5,),
                ),
                const SizedBox(height: 12,),
    
                // The description
                Flexible(child: Text(step.description))
              ],
            ),
          ),
        ],
      ),
    );
  }
}