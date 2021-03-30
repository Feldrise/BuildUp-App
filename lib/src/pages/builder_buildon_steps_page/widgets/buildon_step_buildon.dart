import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/src/shared/widgets/buildons/buildon_image_widget.dart';
import 'package:flutter/material.dart';

class BuildOnStepBuildOn extends StatelessWidget {
  const BuildOnStepBuildOn({Key? key, required this.buildOn}) : super(key: key);

  final BuildOn buildOn;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final description = Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize:  MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(buildOn.name, style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 10),
              Text(buildOn.description)
            ],
          )
        );
        
        if (constraints.maxWidth > 500) {
          return Padding(
            padding: const EdgeInsets.only(top: 15, left: 40, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 35,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BuildOnImageWidget(image: buildOn.image, corners: BuildOnImageRoundedCorner.none,),
                    ),
                  ),
                ),
                Expanded(
                  flex: 65,
                  child: description
                )
              ],
            ),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: BuildOnImageWidget(image: buildOn.image, corners: BuildOnImageRoundedCorner.none,),
            ),
            Flexible(child: description)
          ],
        );
      }
    );
  }
}