import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';

enum StepperStepState {
  validated,
  waiting, 
  waitingValidation,
  locked,
}
class StepperStep extends StatelessWidget {
  const StepperStep({
    Key? key,
    required this.child,
    required this.state,
    required this.isLast,
    required this.index,
    this.previousColor,
  }) : super(key: key);

  final Widget child;

  final StepperStepState state;
  final bool isLast;
  final int index;

  final Color? previousColor;

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;

    if (state == StepperStepState.validated) {
      color = Palette.colorSuccess;
    }
    else if (state == StepperStepState.waiting) {
      color = Palette.colorInfo;
    }
    else if (state == StepperStepState.waitingValidation) {
      color = Palette.colorWarning;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildIndicator(color),
          ),
          const SizedBox(width: 5,),
          Expanded(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: child,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRound(Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      height: 32, width: 32,
      child: state == StepperStepState.locked 
        ? const Center(
          child: Icon(Icons.lock, size: 16,),
        )
        : Center(
        child: Text(index.toString(), style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildIndicator(Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // First, we draw the begining of the line if needed
        if (previousColor != null) ...{
          Container(color: previousColor, width: 1, height: 35,),
          const SizedBox(height: 10,),
        } 
        else 
          const SizedBox(height: 45,),

        // The we draw the number
        _buildRound(color),

        // Finally, if needed we draw the next line
        if (!isLast && state != StepperStepState.locked) 
          Flexible(child: Container(color: color, width: 1,)),
      ],
    );
  }
}