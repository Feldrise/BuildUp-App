
import 'package:buildup/entities/buildons/buildon_returning.dart';
import 'package:buildup/entities/buildons/buildon_step.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:buildup/src/shared/widgets/bu_status_message.dart';
import 'package:buildup/src/shared/widgets/buildons/buildon_image_widget.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class BuildOnStepCard extends StatelessWidget {
  const BuildOnStepCard({
    Key key,
    @required this.buildOnStep,
    @required this.buildOnReturning,
    this.isSmall = false
  }) : super(key: key);

  final BuildOnStep buildOnStep;
  final BuildOnReturning buildOnReturning;

  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.zero,
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
        flex: isSmall ? 0 : 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BuildOnImageWidget(image: buildOnStep.image, corners: isSmall ? BuildOnImageRoundedCorner.onlyTop : BuildOnImageRoundedCorner.onlyTopLeft,),
            if (!isSmall)
              const SizedBox(height: 45,)
          ],
        )
      ),
      Flexible(
        flex: isSmall ? 0 : 7,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildInfos(context),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildInfos(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(buildOnStep.name, style: Theme.of(context).textTheme.headline5)),
          if (buildOnReturning == null)
            _buildBadgeCurrent()
          else if (buildOnReturning.status == BuildOnReturningStatus.validated)
            _buildBadgeValidated()
          else if (buildOnReturning.status == BuildOnReturningStatus.waiting)
            _buildBadgeWaiting()
        ],
      ),
      const SizedBox(height: 15),
      Flexible(
        child: Text(buildOnStep.description),
      ),
      const SizedBox(height: 15,),
      if (buildOnReturning == null) ...{
        BuStatusMessage(
          type: BuStatusMessageType.info,
          title: "Comment valider l'étape :",
          message: buildOnStep.returningDescription
        ),
        const SizedBox(height: 15),
      }
      else if (buildOnReturning.status == BuildOnReturningStatus.validated) ...{
        _buildValidatedInfo(),
        const SizedBox(height: 15),
      },
      if (buildOnReturning == null || buildOnReturning.status == BuildOnReturningStatus.waiting) 
        _buildValidationButton()
    ];
  }

  Widget _buildBadgeValidated() {
    return Row(
      children: const [
        Icon(Icons.check_circle, color: Color(0xff17ba63),),
        SizedBox(width: 5),
        Text("Validé", style: TextStyle(fontSize: 14, color: Color(0xff17ba63)))
      ],
    );
  }

  Widget _buildBadgeWaiting() {
    return Row(
      children: const [
        Icon(Icons.watch_later, color: Color(0xfff4bd21),),
        SizedBox(width: 5),
        Text("En attente de validation", style: TextStyle(fontSize: 14, color: Color(0xfff4bd21)))
      ],
    );
  }

  Widget _buildBadgeCurrent() {
    return Row(
      children: const [
        Icon(Icons.build, color: Color(0xff36a2b1),),
        SizedBox(width: 5),
        Text("En cours", style: TextStyle(fontSize: 14, color: Color(0xff36a2b1)))
      ],
    );
  }

  Widget _buildValidatedInfo() {
    Widget summaryWidget = Container();

    if (buildOnReturning.type == BuildOnReturningType.file) {
      summaryWidget = Row(
        children: const [
          Text("Télécharger", style: TextStyle(decoration: TextDecoration.underline, color: Color(0xff155724)),),
          SizedBox(width: 10,),
          Icon(Icons.file_download, size: 16, color: Color(0xff155724),)
        ],
      );
    }
    else if (buildOnReturning.type == BuildOnReturningType.comment) {
      summaryWidget = Text("Commentaire : ${buildOnReturning.comment}", style: const TextStyle(color: Color(0xff155724)),);
    }
    else {
      summaryWidget = const Text("Le retour attendu était externe", style: TextStyle(color: Color(0xff155724)),);
    }

    return BuStatusMessage(
      type: BuStatusMessageType.success,
      title: "Document envoyé :",
      children: [
        GestureDetector(
          onTap: _downloadFile,
          child: summaryWidget
        )
      ],
    );
  }

  Widget _buildValidationButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: _processValidation,
        child: const Text("Procéder à la validation d'étape >", textAlign: TextAlign.end, style: TextStyle(color: colorPrimary),)
      ),
    );
  }

  Future _processValidation() async {

  }

  Future _downloadFile() async {

  }
}