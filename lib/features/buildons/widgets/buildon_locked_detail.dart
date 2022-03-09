import 'package:buildup/core/widgets/bu_card.dart';
import 'package:flutter/material.dart';

class BuildOnLockedDetail extends StatelessWidget {
  const BuildOnLockedDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                gradient: LinearGradient(
                  colors: [ 
                    Theme.of(context).scaffoldBackgroundColor,
                    Theme.of(context).cardColor,
                  ],
                  stops: const [0.3, 1],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
                )
              ),
            )
          )
        ],
      ),
    );
  }
}