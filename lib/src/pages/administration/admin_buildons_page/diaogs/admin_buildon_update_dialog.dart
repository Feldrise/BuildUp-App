import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:buildup/src/shared/widgets/bu_image_picker.dart';
import 'package:buildup/src/shared/widgets/bu_text_field.dart';
import 'package:flutter/material.dart';

class AdminBuildOnUpdateDialog extends StatelessWidget {
  const AdminBuildOnUpdateDialog({
    Key key,
    @required this.buildOn,
    @required this.onUpdated,
    @required this.onClosed
  }) : super(key: key);

  final BuildOn buildOn;

  final Function() onUpdated;
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
            padding: const EdgeInsets.all(8.0),
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
}