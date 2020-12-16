
import 'dart:convert';

import 'package:buildup/entities/bu_file.dart';
import 'package:buildup/entities/buildons/buildon_returning.dart';
import 'package:buildup/entities/buildons/buildon_step.dart';
import 'package:buildup/entities/project.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/services/buildons_service.dart';
import 'package:buildup/src/pages/builder_buildon_steps_page/dialogs/buildon_step_send_validation_dialog.dart';
import 'package:buildup/src/providers/buildons_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/pages/builder_buildon_steps_page/dialogs/buildon_step_process_validation_dialog.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/src/shared/widgets/buildons/buildon_image_widget.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

class BuildOnStepCard extends StatefulWidget {
  const BuildOnStepCard({
    Key key,
    @required this.project,
    @required this.buildOnStep,
    @required this.buildOnReturning,
    this.nextBuildOnStep,
    this.nextBuildOn,
    this.isSmall = false
  }) : super(key: key);

  final Project project;
  final BuildOnStep buildOnStep;
  
  final BuildOnReturning buildOnReturning;

  final String nextBuildOn;
  final String nextBuildOnStep;

  final bool isSmall;

  @override
  _BuildOnStepCardState createState() => _BuildOnStepCardState();
}

class _BuildOnStepCardState extends State<BuildOnStepCard> {
  BuildOnReturning _buildOnReturning;

  bool _hasError = false;
  String _statusMessage = "";

  @override
  void initState() {
    super.initState();

    _buildOnReturning = widget.buildOnReturning;
  }

  @override
  void didUpdateWidget(covariant BuildOnStepCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    _buildOnReturning = widget.buildOnReturning;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BuCard(
          margin: const EdgeInsets.symmetric(vertical: 15),
          padding: EdgeInsets.zero,
          child: widget.isSmall 
          ? Column(
                children: _buildContent(context),
            )
          : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildContent(context),
          )
        ),
        if (_statusMessage.isNotEmpty)
          Positioned.fill(
            child: FutureBuilder(
              future: Future<void>.delayed(const Duration(seconds: 8)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  _hasError = false;
                  _statusMessage = "";

                  return Container();
                }

                return BuStatusMessage(
                  type: _hasError ? BuStatusMessageType.error : BuStatusMessageType.success,
                  title: _hasError ? "Erreur" : "Bravo !",
                  message: _statusMessage,
                );
              },
            )
        )
      ],
    );
  }

  List<Widget> _buildContent(BuildContext context,) {
    return [
      Flexible(
        flex: widget.isSmall ? 0 : 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BuildOnImageWidget(image: widget.buildOnStep.image, corners: widget.isSmall ? BuildOnImageRoundedCorner.onlyTop : BuildOnImageRoundedCorner.onlyTopLeft,),
            if (!widget.isSmall)
              const SizedBox(height: 45,)
          ],
        )
      ),
      Flexible(
        flex: widget.isSmall ? 0 : 7,
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
          Flexible(child: Text(widget.buildOnStep.name, style: Theme.of(context).textTheme.headline5)),
          if (_buildOnReturning == null)
            _buildBadgeCurrent()
          else if (_buildOnReturning.status == BuildOnReturningStatus.validated)
            _buildBadgeValidated()
          else if (_buildOnReturning.status == BuildOnReturningStatus.waiting)
            _buildBadgeWaiting()
          else if (_buildOnReturning.status == BuildOnReturningStatus.waitingCoach)
          _buildBadgeWaitingCoach()
          else if (_buildOnReturning.status == BuildOnReturningStatus.waitingAdmin)
          _buildBadgeWaitingAdmin()
        ],
      ),
      const SizedBox(height: 15),
      Flexible(
        child: Text(widget.buildOnStep.description),
      ),
      const SizedBox(height: 15,),
      if (_buildOnReturning == null) ...{
        BuStatusMessage(
          type: BuStatusMessageType.info,
          title: "Comment valider l'étape :",
          message: widget.buildOnStep.returningDescription
        ),
        const SizedBox(height: 15),
      }
      else if (_buildOnReturning.status == BuildOnReturningStatus.validated) ...{
        _buildValidatedInfo(context),
        const SizedBox(height: 15),
      },
      if (_buildOnReturning == null || 
          _buildOnReturning.status == BuildOnReturningStatus.waiting ||
          _buildOnReturning.status == BuildOnReturningStatus.waitingCoach ||
          _buildOnReturning.status == BuildOnReturningStatus.waitingAdmin) 
        _buildValidationButton(context)
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

  
  Widget _buildBadgeWaitingCoach() {
    return Row(
      children: const [
        Icon(Icons.watch_later, color: Color(0xfff4bd21),),
        SizedBox(width: 5),
        Text("En attente de validation du Coach", style: TextStyle(fontSize: 14, color: Color(0xfff4bd21)))
      ],
    );
  }

  
  Widget _buildBadgeWaitingAdmin() {
    return Row(
      children: const [
        Icon(Icons.watch_later, color: Color(0xfff4bd21),),
        SizedBox(width: 5),
        Text("En attente de validation d'un responsable", style: TextStyle(fontSize: 14, color: Color(0xfff4bd21)))
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

  Widget _buildValidatedInfo(BuildContext context) {
    Widget summaryWidget = Container();

    if (_buildOnReturning.type == BuildOnReturningType.file) {
      summaryWidget = Row(
        children: [
          Text(_buildOnReturning.file.fileName, style: const TextStyle(decoration: TextDecoration.underline, color: Color(0xff155724)),),
          const SizedBox(width: 10,),
          const Icon(Icons.file_download, size: 16, color: Color(0xff155724),)
        ],
      );
    }
    else if (_buildOnReturning.type == BuildOnReturningType.comment) {
      summaryWidget = Text("Commentaire : ${_buildOnReturning.comment}", style: const TextStyle(color: Color(0xff155724)),);
    }
    else {
      summaryWidget = const Text("Le retour attendu était externe", style: TextStyle(color: Color(0xff155724)),);
    }

    return BuStatusMessage(
      type: BuStatusMessageType.success,
      title: "Document envoyé :",
      children: [
        GestureDetector(
          onTap: () => _downloadFile(context),
          child: summaryWidget
        )
      ],
    );
  }

  Widget _buildValidationButton(BuildContext context) {
    return Consumer<UserStore>(
      builder: (context, userStore, child) {
        if (userStore.user.role == UserRoles.builder) {
          if (_buildOnReturning != null) {
            return Container();
          }

          return Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () => _askValidation(context),
              child: const Text("Demander validation d'étape >", textAlign: TextAlign.end, style: TextStyle(color: colorPrimary),)
            ),
          );
        }

        if (userStore.user.role == UserRoles.admin && widget.buildOnReturning?.status == BuildOnReturningStatus.waitingCoach) {
          return Container();
        }
        
        if (userStore.user.role == UserRoles.coach && widget.buildOnReturning?.status == BuildOnReturningStatus.waitingAdmin) {
          return Container();
        }

        return Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () => _processValidation(context),
            child: const Text("Procéder à la validation d'étape >", textAlign: TextAlign.end, style: TextStyle(color: colorPrimary),)
          ),
        );
      },
    ); 
  }

  Future _askValidation(BuildContext context) async {
    final buildOnReturning = BuildOnReturning(
      null,
      buildOnStepId: widget.buildOnStep.id,
      type: widget.buildOnStep.returningType,
      file: BuFile(null),
      comment: "",
      status: BuildOnReturningStatus.waiting
    );

    final bool send = await showDialog<bool>(
      context: context,
      builder: (context) => BuildOnStepSendValidationDialog(
        buildOnStep: widget.buildOnStep, 
        buildOnReturning: buildOnReturning, 
      )
    );

    if (send == null) {
      return;
    }

    final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;
    
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Mise à jour avec le serveur..."); 

    if (send) {
      try {
        buildOnReturning.id = await BuildOnsService.instance.sendReturning(authorization, widget.project.id, buildOnReturning);
        widget.project.associatedReturnings[widget.buildOnStep.id] = _buildOnReturning;

        _buildOnReturning = buildOnReturning;

        setState(() {
          _hasError = false;
          _statusMessage = "Votre preuve à bien été envoyé";
        });
      }
      on PlatformException catch(e) {
        setState(() {
          _hasError = true;
          _statusMessage = "Impossible d'envoyer la preuve : ${e.message}";
        });
      }
      on Exception catch(e) {
        setState(() {
          _hasError = true;
          _statusMessage = "Impossible d'envoyer la preuve : $e";
        });
      }
    }

    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
    Provider.of<BuildOnsStore>(context, listen: false).clear();
  }

  Future _processValidation(BuildContext context) async {
    final bool validate = await showDialog<bool>(
      context: context,
      builder: (context) => BuildOnStepProcessValidationDialog(buildOnStep: widget.buildOnStep, buildOnReturning: _buildOnReturning, onDownload: () => _downloadFile(context),)
    );

    if (validate == null) {
      return;
    }

    final UserStore userStore = Provider.of<UserStore>(context, listen: false);
    
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Mise à jour avec le serveur..."); 

    if (validate) {
      if (_buildOnReturning != null) {
        await BuildOnsService.instance.acceptReturnging(userStore.authentificationHeader, widget.project.id, _buildOnReturning.id);
      }
      else {
        await BuildOnsService.instance.validateBuildOnStep(userStore.authentificationHeader, widget.project.id, widget.buildOnStep.id);
      }

      if (_buildOnReturning != null) {
        if (_buildOnReturning.status != BuildOnReturningStatus.waiting) {
          _buildOnReturning.status = BuildOnReturningStatus.validated;
        }
        else {
           _buildOnReturning.status = userStore.user.role == UserRoles.admin ? BuildOnReturningStatus.waitingCoach : BuildOnReturningStatus.waitingAdmin;
        }
      }
      else {
        if (userStore.user.role == UserRoles.admin) {
            widget.project.associatedReturnings[widget.buildOnStep.id] = BuildOnReturning(null,
            buildOnStepId: widget.buildOnStep.id,
            type: BuildOnReturningType.comment,
            status: BuildOnReturningStatus.waitingCoach,
            comment: "Vous n'avez pas fournis de preuve pour cette étape"
          );
        }
        else if (userStore.user.role == UserRoles.coach) {
            widget.project.associatedReturnings[widget.buildOnStep.id] = BuildOnReturning(null,
            buildOnStepId: widget.buildOnStep.id,
            type: BuildOnReturningType.comment,
            status: BuildOnReturningStatus.waitingAdmin,
            comment: "Vous n'avez pas fournis de preuve pour cette étape"
          );
        }
      }

      widget.project.currentBuildOn = widget.nextBuildOn;
      widget.project.currentBuildOnStep = widget.nextBuildOnStep;
      widget.project.hasNotification = false;
    } else {
      await BuildOnsService.instance.refuseReturning(userStore.authentificationHeader, widget.project.id, _buildOnReturning.id);
    }

    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
    Provider.of<BuildOnsStore>(context, listen: false).clear();
    Navigator.of(context).pop();
  }

  Future _downloadFile(BuildContext context) async {
    
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Téléchargement du fichier..."); 

    final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;
    
    final rawData = await BuildOnsService.instance.downloadReturningContent(authorization, widget.project.id, _buildOnReturning.id);
    final content = base64Encode(rawData);

    if (kIsWeb) {
      html.AnchorElement()
        ..href = "data:application/octet-stream;charset=utf-16le;base64,$content"
        ..setAttribute("download", _buildOnReturning.file.fileName)
        ..click();
    }
    // TODO non web version
    
    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
  }
}