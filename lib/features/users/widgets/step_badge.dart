import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';

class StepBadge extends StatelessWidget {
  const StepBadge({
    Key? key,
    required this.step
  }) : super(key: key);

  final String step;

  @override
  Widget build(BuildContext context) {
    if (step == "ACTIVE") {
      return Row(
        children: [
          // The badge icon
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: Palette.colorSuccess,
              borderRadius: BorderRadius.circular(15)
            ),
            child: const Center(child: Icon(Icons.check, size: 15, color: Colors.white,),),
          ),
          const SizedBox(width: 5,),

          // The badge text
          const Flexible(child: Text("Actif", style: TextStyle(color: Palette.colorSuccess),))
        ],
      );
    }

    // By default, the waiting badge
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        // The badge icon
        Icon(Icons.schedule, size: 15, color: Palette.colorWarning,),
        SizedBox(width: 5,),

        // The badge text
        Flexible(child: Text("en attente", style: TextStyle(color: Palette.colorWarning),))
      ],
    );
  }
}