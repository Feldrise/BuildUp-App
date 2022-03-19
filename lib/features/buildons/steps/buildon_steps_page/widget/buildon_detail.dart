import 'package:buildup/core/utils/constants.dart';
import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/features/buildons/buildon.dart';
import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';

class BuildOnDetail extends StatelessWidget {
  const BuildOnDetail({
    Key? key, 
    required this.buildOn
  }) : super(key: key);

  final BuildOn buildOn;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If we are on big screens
        if (constraints.maxWidth > ScreenUtils.instance.breakpointTablet) {
          return Padding(
            padding: const EdgeInsets.only(top: 15, left: 40, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // The image
                Expanded(
                  flex: 35,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      "$kImagesUrls/buildons/${buildOn.id}.jpg",
                      loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                        ),
                      ),
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(height: 250,);
                      },
                              ),
                  ),
                ),

                // The description
                Expanded(
                  flex: 65,
                  child: _buildDescription(context)
                )
              ],
            ),
          );
        }

        // On small screens
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // The image
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: Container(color: Palette.colorLightGrey3,)
            ),

            // The description
            Flexible(child: _buildDescription(context)),
          ],
        );
      }
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize:  MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The buildon title
          Text(buildOn.name, style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 10),

          // The buildon description
          Text(buildOn.description),
          const SizedBox(height: 10),

          // The button
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Accéder au dossier annexe"),
            ),
          )
        ],
      )
    );
  }
}