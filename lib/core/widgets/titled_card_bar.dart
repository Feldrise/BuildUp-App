import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';

class TitledCardBar extends StatelessWidget {
  const TitledCardBar({
    Key? key, 
    required this.title, 
    this.actionText,
    this.actionIcon,
    this.onActionClicked
  }) : super(key: key);

  final String title;

  final String? actionText;
  final IconData? actionIcon;
  final Function()? onActionClicked;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool showText = constraints.maxWidth > 411;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // The title
            Flexible(child: Text(title, style: Theme.of(context).textTheme.headline3,)),

            // The button with text
            if (actionText != null && onActionClicked != null && showText)
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (actionIcon != null) ...{
                        Icon(actionIcon),
                        const SizedBox(width: 8,),
                      },

                      Text(actionText!)
                    ],
                  ),
                  onPressed: onActionClicked!
                ),
              )

            // Or we try the icon
            else if (actionIcon != null && onActionClicked != null)
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(
                    icon: Icon(actionIcon),
                    iconSize: 24,
                    color: Palette.colorWhite,
                    onPressed: onActionClicked,
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}