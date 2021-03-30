import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/buildons/buildon_image_widget.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class BuildOnCard extends StatelessWidget {
  const BuildOnCard({
    Key? key,
    required this.buildOn,
    required this.onOpened,
    this.isSmall = false
  }) : super(key: key);

  final BuildOn buildOn;
  final Function() onOpened;

  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.zero,
      // child: LayoutBuilder(
      //   builder: (context, constraints) {
      //     if (constraints.maxWidth > 366) {
      //       return Row(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: _buildContent(context),
      //       );
      //     }

      //     return Column(
      //       children: _buildContent(context, isSmall: true),
      //     );
      //   },
      // ),
      child: isSmall 
      ? Column(
            children: _buildContent(context),
        )
      : Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildContent(context),
      )
    );
  }

  List<Widget> _buildContent(BuildContext context,) {
    return [
      Flexible(
        flex: isSmall ? 0 : 30,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BuildOnImageWidget(image: buildOn.image, corners: isSmall ? BuildOnImageRoundedCorner.onlyTop : BuildOnImageRoundedCorner.onlyTopLeft,),
            if (!isSmall)
              const SizedBox(height: 45,)
          ],
        )
      ),
      Flexible(
        flex: isSmall ? 0 : 55,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(buildOn.name, style: Theme.of(context).textTheme.headline5),
              const SizedBox(height: 15,),
              Text(buildOn.description)
            ],
          ),
        ),
      ),
      Flexible(
        flex: isSmall ? 0 : 15,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Center(
            child: _buildButton(),
          )
        ),
      ),
    ];
  }

  Widget _buildButton() {
    return InkWell(
      onTap: onOpened,
      child: isSmall 
      ? Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Text("Aller aux étapes", style: TextStyle(color: colorPrimary)),
          SizedBox(width: 5,),
          Icon(Icons.arrow_forward_ios, color: colorPrimary, size: 16,)
        ],
      )
      : const Icon(Icons.arrow_forward_ios, size: 24,)
    );
  }
}