import 'package:buildup/core/widgets/inputs/bu_textfield.dart';
import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';

class BuildOnEditDialog extends StatelessWidget {
  const BuildOnEditDialog({
    Key? key,
    required this.formKey,
    required this.nameTextController,
    required this.descriptionTextController,
    required this.urlTextController,
    required this.rewardsTextController,
    required this.buildOnStepsCount,
    required this.onClose,
    required this.onRemove,
    required this.onOpenSteps
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController nameTextController;
  final TextEditingController descriptionTextController;
  final TextEditingController urlTextController;
  final TextEditingController rewardsTextController;

  final int buildOnStepsCount;

  final Function() onClose;
  final Function() onRemove;
  final Function() onOpenSteps;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              offset: Offset(0.0, 1.0),
              blurRadius: 8.0,
              spreadRadius: 0
            ),
            BoxShadow(
              color: Color(0x1f000000),
              offset: Offset(0.0, 3.0),
              blurRadius: 4.0,
              spreadRadius: 0
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // The Header
              Flexible(child: _buildHeader(context)),

              // The steps header
              Flexible(child: _buildStepsHeader()),

              // The form
              Flexible(child: _buildForm(),),

              // The delete button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                  child: Row(
                    children: const [
                      Icon(Icons.delete_forever),
                      SizedBox(width: 4,),
                      Text("Supprimer le Build-On")
                    ],
                  ),
                  onPressed: onRemove,
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );   
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // The title
          Flexible(
            child: Text("Configurer le Build-On", style: Theme.of(context).textTheme.headline5,),
          ),

          // The close button
          IconButton(
            icon: Icon(
              Icons.close,
              color: Theme.of(context).textTheme.caption!.color,
            ),
            iconSize: 32,
            onPressed: onClose,
          )
        ],
      ),
    );
  }

  Widget _buildStepsHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // The button
          TextButton(
            onPressed: onOpenSteps,
            child: Row(
              children: const [
                Icon(Icons.edit, size: 18,),
                SizedBox(width: 4,),
                Text("Modifier les étapes")
              ],
            ),
          ),

          // The number
          Text(
            "$buildOnStepsCount étape(s)",
            style: const TextStyle(color: Palette.colorSecondary),
          )
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The name
          BuTextField(
            controller: nameTextController,
            labelText: "Nom du Build-On",
            hintText: "",
            validator: (value) {
              if (value.isEmpty) return "Vous devez choisir un nom";

              return null;
            },
          ),
          const SizedBox(height: 20,),

          // The description
          BuTextField(
            controller: descriptionTextController,
            labelText: "Description",
            hintText: "",
            inputType: TextInputType.multiline,
            maxLines: 4,
            validator: (value) {
              if (value.isEmpty) return "Vous décrire le Build-On";

              return null;
            },
          ),
          const SizedBox(height: 20,),

          // The annexe URL
          BuTextField(
            controller: urlTextController,
            labelText: "URL du dossier annexe",
            hintText: "",
            validator: (value) {
              if (value.isEmpty) return "Vous devez rentrer une URL";

              return null;
            },
          ),
          const SizedBox(height: 20,),

          // The rewards
          BuTextField(
            controller: rewardsTextController,
            labelText: "Récompense de fin",
            hintText: "",
            inputType: TextInputType.multiline,
            maxLines: 4,
            validator: (value) {
              if (value.isEmpty) return "Vous décrire les récompenses";

              return null;
            },
          ),
          const SizedBox(height: 20,),

        ],
      ),
    );
  }
}