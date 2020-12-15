
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/general/bu_icon_button.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class BuTitledCardBar extends StatelessWidget {
  const BuTitledCardBar({Key key, @required this.title, this.onModified}) : super(key: key);

  final String title;

  final Function() onModified;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool showText = constraints.maxWidth > 411;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(title, style: Theme.of(context).textTheme.headline3,)),
            if (onModified != null && showText)
              Container(
                constraints: const BoxConstraints(maxWidth: 200),
                child: BuButton(
                  icon: Icons.edit,
                  text: "Modifier",
                  onPressed: onModified,
                ),
              )
            else if (onModified != null)
              Container(
                constraints: const BoxConstraints(maxWidth: 200),
                child: BuIconButton(
                  backgroundColor: colorPrimary,
                  icon: Icons.edit,
                  iconSize: 24,
                  onPressed: onModified,
                ),
              )
          ],
        );
      },
    );
  }
}