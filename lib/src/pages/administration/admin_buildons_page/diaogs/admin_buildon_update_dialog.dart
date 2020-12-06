import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:buildup/src/shared/widgets/bu_image_picker.dart';
import 'package:buildup/src/shared/widgets/bu_text_field.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminBuildOnUpdateDialog extends StatelessWidget {
  const AdminBuildOnUpdateDialog({
    Key key,
    @required this.buildOn,
    @required this.onUpdated,
    @required this.onRequestUpdateSteps,
    @required this.onClosed
  }) : super(key: key);

  final BuildOn buildOn;

  final Function() onUpdated;
  final Function(BuildOn) onRequestUpdateSteps;
  final Function() onClosed;

  @override
  Widget build(BuildContext context) {
    if (buildOn == null) {
      return Container();
    }

    return BuCard(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text("Configurer le Build-On", style: Theme.of(context).textTheme.headline5,),
                ),
                GestureDetector(
                  onTap: onClosed,
                  child: const Icon(Icons.close, size: 32,)
                )
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: _updateSteps,
                    child: Row(
                      children: const [
                        Icon(Icons.edit, color: colorPrimary,),
                        Expanded(
                          child: Text("Modifier les étapes", style: TextStyle(color: colorPrimary),),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Text("${buildOn.steps.length} étapes", style: const TextStyle(color: colorSecondary),),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0,),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BuImagePicker(
                  image: buildOn.image,
                  onUpdated: onUpdated,
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BuTextField(
                        controller: TextEditingController()..text = buildOn.name, 
                        labelText: "Nom du Build-On", 
                        hintText: "Nom",
                        onChanged: (value) {
                          buildOn.name = value;
                          onUpdated();
                        }
                      ),
                      const SizedBox(height: 10,),
                      BuTextField(
                        controller: TextEditingController()..text = buildOn.description, 
                        labelText: "Description", 
                        hintText: "Description",
                        inputType: TextInputType.multiline,
                        maxLines: 3,
                        onChanged: (value) {
                          buildOn.description = value;
                          onUpdated();
                        }
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future _updateSteps() async {
    onRequestUpdateSteps(buildOn);
  }
}