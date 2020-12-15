import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:flutter/material.dart';

class BuStepperChild {
  final Color color;
  final Widget widget;

  const BuStepperChild({
    this.color = const Color(0xffaeb5b7),
    this.widget 
  });
}

class BuStepper extends StatelessWidget {
  const BuStepper({
    Key key, 
    @required this.children, 
    this.showLocked = true,
  }) : assert(children != null), super(key: key);

  final List<BuStepperChild> children;

  final bool showLocked;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < children.length; ++i) 
          _buildStep(i > 0 ? children[i - 1] : null, children[i], index: i + 1),
        
        if (showLocked)
          _buildLocked()
      ],
    );
  }

  Widget _buildRound(Widget widget, {Color color}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color
      ),
      width: 32,
      height: 32,
      child: Center(child: widget),
    ); 
  }

  Widget _buildNumber(int index, {Color color = const Color(0xffaeb5b7)}) {
    return _buildRound(
      Text(index.toString(), style: const TextStyle(color: Colors.white),), 
      color: color
    );
  }

  Widget _buildLock() {
    return _buildRound(
      const Icon(Icons.lock, size: 16, color: Color(0xffaeb5b7),),
      color: const Color(0xffE8E9EA)
    );
  }

  Widget _buildLine(double heigth, {Color color = const Color(0xffaeb5b7)}) {
    return Container(
      color: color,
      width: 1,
      height: heigth,
    );
  }

  Widget _buildFlexibleLine({Color color = const Color(0xffaeb5b7)}) {
    return Container(
      color: color,
      width: 1,
    );
  }

  Widget _buildIndicator(BuStepperChild previous, BuStepperChild current, {@required int index}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (previous != null) ...{
          _buildLine(35, color: previous.color),
          const SizedBox(height: 10),
        }
        else 
          const SizedBox(height: 45,),
        
        _buildNumber(index, color: current.color),

        if (showLocked || current != children.last) ...{
          const SizedBox(height: 10),
          Expanded(child: _buildFlexibleLine(color: current.color),)
        }
      ],
    );
  }

  Widget _buildLockedIndicator() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLine(35, color: const Color(0xffE8E9EA)),
        const SizedBox(height: 10),
        _buildLock()
      ],
    );
  } 

  Widget _buildStep(BuStepperChild previous, BuStepperChild current, {@required int index}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildIndicator(previous, current, index: index),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 9,
            child: current.widget,
          )
        ],
      )
    );
  }

  Widget _buildLocked() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildLockedIndicator()
          ),
          Expanded(
            flex: 9,
            child: SizedBox(
              height: 124,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: BuCard(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Container()
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [ 
                            Color(0xfff5f5f6),
                            Color(0x1ff5f5f6),
                          ],
                          stops: [0.2, 0.5],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter
                        )
                      ),
                    )
                  )
                ],
              ),
            )
          ),
        ],
      ),
    );
  }

}