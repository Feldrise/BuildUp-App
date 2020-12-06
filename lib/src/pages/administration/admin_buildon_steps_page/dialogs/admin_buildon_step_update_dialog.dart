import 'package:buildup/entities/buildons/buildon_step.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:buildup/src/shared/widgets/bu_image_picker.dart';
import 'package:buildup/src/shared/widgets/bu_text_field.dart';
import 'package:flutter/material.dart';

class AdminBuildOnStepUpdateDialog extends StatelessWidget {
  const AdminBuildOnStepUpdateDialog({
    Key key,
    @required this.buildOnStep,
    @required this.onUpdated,
    @required this.onClosed
  }) : super(key: key);

  final BuildOnStep buildOnStep;

  final Function() onUpdated;
  final Function() onClosed;

  @override
  Widget build(BuildContext context) {
    if (buildOnStep == null) {
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
                  child: Text("Configurer l'étape", style: Theme.of(context).textTheme.headline5,),
                ),
                GestureDetector(
                  onTap: onClosed,
                  child: const Icon(Icons.close, size: 32,)
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BuImagePicker(
                  image: buildOnStep.image,
                  onUpdated: onUpdated,
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BuTextField(
                        controller: TextEditingController()..text = buildOnStep.name, 
                        labelText: "Nom de l'étape", 
                        hintText: "Nom",
                        onChanged: (value) {
                          buildOnStep.name = value;
                          onUpdated();
                        }
                      ),
                      const SizedBox(height: 10,),
                      BuTextField(
                        controller: TextEditingController()..text = buildOnStep.description, 
                        labelText: "Description", 
                        hintText: "Description",
                        inputType: TextInputType.multiline,
                        maxLines: 3,
                        onChanged: (value) {
                          buildOnStep.description = value;
                          onUpdated();
                        }
                      ),
                      const SizedBox(height: 10,),
                      BuTextField(
                        controller: TextEditingController()..text = buildOnStep.proofDescription, 
                        labelText: "Preuve à fournir", 
                        hintText: "Preuve",
                        inputType: TextInputType.multiline,
                        maxLines: 3,
                        onChanged: (value) {
                          buildOnStep.proofDescription = value;
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
}