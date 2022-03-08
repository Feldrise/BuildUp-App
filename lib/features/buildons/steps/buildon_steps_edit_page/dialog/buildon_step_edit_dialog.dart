import 'package:buildup/core/widgets/inputs/bu_dropdown.dart';
import 'package:buildup/core/widgets/inputs/bu_textfield.dart';
import 'package:buildup/features/buildons/steps/buildon_step.dart';
import 'package:flutter/material.dart';

class BuildOnStepEditDialog extends StatefulWidget {
  const BuildOnStepEditDialog({
    Key? key, 
    required this.formKey,
    required this.nameTextController,
    required this.descriptionTextController,
    required this.proofTypeTextController,
    required this.proofDescriptionTextController,
    required this.onClose, 
    required this.onRemove
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController  nameTextController;
  final TextEditingController descriptionTextController;
  final TextEditingController proofTypeTextController;
  final TextEditingController proofDescriptionTextController;

  final Function() onClose;
  final Function() onRemove;

  @override
  State<BuildOnStepEditDialog> createState() => _BuildOnStepEditDialogState();
}

class _BuildOnStepEditDialogState extends State<BuildOnStepEditDialog> {
  String _proofType = BuildOnStepProofType.comment;

  void _initialize() {
    _proofType = widget.proofTypeTextController.text;
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(covariant BuildOnStepEditDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
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

              // The form
              Flexible(child: _buildForm()),

              // The delete button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                  child: Row(
                    children: const [
                      Icon(Icons.delete_forever),
                      SizedBox(width: 4,),
                      Text("Supprimer l'étape")
                    ],
                  ),
                  onPressed: widget.onRemove,
                ),
              ),
            ]
          )
        )
      )
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
            child: Text("Configurer l'étape", style: Theme.of(context).textTheme.headline5,),
          ),

          // The close button
          IconButton(
            icon: Icon(
              Icons.close,
              color: Theme.of(context).textTheme.caption!.color,
            ),
            iconSize: 32,
            onPressed: widget.onClose,
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
            controller: widget.nameTextController,
            labelText: "Nom de l'étape",
            hintText: "",
            validator: (value) {
              if (value.isEmpty) return "Vous devez choisir un nom";

              return null;
            },
          ),
          const SizedBox(height: 20,),

          // The description
          BuTextField(
            controller: widget.descriptionTextController,
            labelText: "Description",
            hintText: "",
            inputType: TextInputType.multiline,
            maxLines: 4,
            validator: (value) {
              if (value.isEmpty) return "Vous devez décrire l'étape";

              return null;
            },
          ),
          const SizedBox(height: 20,),

          // The proof type
          BuDropdown<String>(
            stringValueController: widget.proofTypeTextController,
            label: "Type de preuves",
            items: BuildOnStepProofType.detailled,
            currentValue: _proofType,
            onChanged: (value) {
              setState(() {
                _proofType = value!;
              });
            },
          ),
          const SizedBox(height: 20,),

          // The proof description
          BuTextField(
            controller: widget.proofDescriptionTextController,
            labelText: "Déscription des preuves à fournir",
            hintText: "",
            inputType: TextInputType.multiline,
            maxLines: 4,
            validator: (value) {
              if (value.isEmpty) return "Vous décrire les preuves à fournir";

              return null;
            },
          ),
          const SizedBox(height: 20,),

        ],
      ),
    );
  }
}