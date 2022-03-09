import 'package:buildup/core/widgets/bu_card.dart';
import 'package:buildup/features/buildons/buildon.dart';
import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';

class BuildOnStepperDetail extends StatelessWidget {
  const BuildOnStepperDetail({
    Key? key,
    required this.buildOn
  }) : super(key: key);

  final BuildOn buildOn;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Row(
        children: [
          // The image
          Flexible(
            flex: 25,
            child: Container(
              color: Palette.colorLightGrey3,
            ),
          ),
          const SizedBox(width: 12,),
    
          // The info
          Flexible(
            flex: 60,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // The title
                Flexible(
                  child: Text(buildOn.name, style: Theme.of(context).textTheme.headline5,),
                ),
                const SizedBox(height: 12,),
    
                // The description
                Flexible(child: Text(buildOn.description))
              ],
            ),
          ),
    
          // The arrow
          const Flexible(
            flex: 15,
            child: Icon(Icons.arrow_forward_ios, size: 24),
          )
        ],
      ),
    );
  }
}