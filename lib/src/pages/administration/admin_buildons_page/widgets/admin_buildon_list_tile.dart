import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminBuildOnListTile extends StatelessWidget {
  final BuildOn buildOn;
  final bool isActive;

  const AdminBuildOnListTile({
    Key key,
    @required this.buildOn, 
    this.isActive = false
  }) : super(key: key);

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
            color: isActive ? colorPrimary : Colors.transparent
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