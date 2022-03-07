import 'package:buildup/core/widgets/bu_card.dart';
import 'package:buildup/features/buildons/buildon.dart';
import 'package:flutter/material.dart';

class BuildOnEditCard extends StatelessWidget {
  const BuildOnEditCard({
    Key? key,
    required this.buildOn,
    this.isSelected = false,
  }) : super(key: key);

  final BuildOn buildOn;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final String buildOnName = buildOn.name.isEmpty ? "Sans titre" : buildOn.name;

    return BuCard(
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
              child: Text(buildOnName, style: Theme.of(context).textTheme.headline6,),
            )
          ],
        ),
      ),
    );
  }
}