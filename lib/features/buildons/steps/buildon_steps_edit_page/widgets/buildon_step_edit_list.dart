import 'dart:convert';

import 'package:buildup/core/models/bu_file.dart';
import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/features/buildons/steps/buildon_step.dart';
import 'package:buildup/features/buildons/steps/buildon_steps_edit_page/dialog/buildon_step_edit_dialog.dart';
import 'package:buildup/features/buildons/steps/buildon_steps_edit_page/widgets/buildon_step_edit_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';

class BuildOnStepEditList extends StatefulWidget {
  const BuildOnStepEditList({
    Key? key,
    required this.steps,
    required this.creationMutation,
    required this.updateMutation,
    required this.buildOnId,
    this.maxPanelWidth = 200
  }) : super(key: key);

  final List<BuildOnStep> steps;
  final double maxPanelWidth;

  final RunMutation creationMutation;
  final RunMutation updateMutation;
  final String buildOnId;

  @override
  State<BuildOnStepEditList> createState() => BuildOnStepEditListState();
}

class BuildOnStepEditListState extends State<BuildOnStepEditList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();
  final TextEditingController _proofTypeTextController = TextEditingController();
  final TextEditingController _proofDescriptionTextController = TextEditingController();

  List<BuildOnStep> _steps = [];

  BuFile? _selectedImage;
  
  int? _selectedStepIndex;

  void _initialize() {
    _steps = widget.steps;
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(covariant BuildOnStepEditList oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // The list
        Expanded(
          child: Scaffold(
            body: Center(
              child: _steps.isEmpty ? _buildEmptyInfo(context) : Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: ScreenUtils.instance.horizontalPadding
                ),
                constraints: const BoxConstraints(maxWidth: 650),
                child: ReorderableListView.builder(
                  scrollController: ScrollController(),
                  onReorder: (oldIndex, newIndex) {
                    final item = _steps.removeAt(oldIndex);
                    _steps.insert(newIndex < oldIndex ? newIndex : newIndex - 1, item);
          
                    if (_selectedStepIndex == oldIndex) _selectedStepIndex = newIndex < oldIndex ? newIndex : newIndex - 1;
                  },
                  itemCount: _steps.length,
                  itemBuilder: (context, index) => InkWell(
                    key: ValueKey(_steps[index]),
                    onTap: () => _openStepDialog(index),
                    child: BuildOnStepEditCard(
                      step: _steps[index],
                      index: index + 1,
                      isSelected: _selectedStepIndex == index,
                    ),
                  ),
                ),
              ),
            ),
            // The add button
            floatingActionButton: FloatingActionButton(
              onPressed: _onAddNewStep,
              child: const Icon(Icons.add),
            )
          ),
        ),

        // The edit step dialog
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _selectedStepIndex != null ? widget.maxPanelWidth : 0.0,
          child: _selectedStepIndex != null ? BuildOnStepEditDialog(
            buildOnStepID: _selectedStepIndex != null ? _steps[_selectedStepIndex!].id : null,
            formKey: _formKey,
            nameTextController: _nameTextController,
            descriptionTextController: _descriptionTextController,
            proofTypeTextController: _proofTypeTextController,
            proofDescriptionTextController: _proofDescriptionTextController,
            image: _selectedStepIndex != null ? _steps[_selectedStepIndex!].image : null,
            onClose: _updateSelectedStep,
            onRemove: _removeSelectedStep,
            onImageSelected: _onImageSelected,
          ) : Container(),
        )
      ],
    );
  }

  Widget _buildEmptyInfo(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.list, 
            size: 92,
            color: Theme.of(context).textTheme.caption!.color
          ),
          const SizedBox(height: 8,),
          Text(
            "Il n'y a aucune étape pour le moment. Ajoutez-en un en appuyant sur le bouton +",
            style: TextStyle(
              color: Theme.of(context).textTheme.caption!.color
            ),
          )
        ],
      ),
    );
  }

  void _onImageSelected(BuFile image) {
    _selectedImage = image;
  }

  Future<bool> save() async {
    if (!_updateSelectedStep() && _selectedStepIndex != null) return false;

    for (int i = 0; i < _steps.length; ++i) {
      final BuildOnStep step = _steps[i];

      if (step.id == null) {
        widget.creationMutation(<String, dynamic>{
          "buildOnID": widget.buildOnId,
          "name": step.name,
          "description": step.description,
          "index": i+1,
          "proofType": step.proofType,
          "proofDescription": step.proofDescription,
          if (step.image != null) 
            "image": MultipartFile.fromBytes(
              "file",
              base64Decode(step.image!.base64content!),
              filename: step.image!.filename
            )
        });
      }
      else {
        widget.updateMutation(<String, dynamic>{
          "id": step.id,
          "name": step.name,
          "description": step.description,
          "index": i+1,
          "proofType": step.proofType,
          "proofDescription": step.proofDescription,
          if (step.image != null)
            "image": MultipartFile.fromBytes(
              "file",
              base64Decode(step.image!.base64content!),
              filename: step.image!.filename
            )
        });
      }
    }

    return true;
  }

  void _onAddNewStep() {
    if (_formKey.currentState != null && !_formKey.currentState!.validate()) return;

    final BuildOnStep newStep = BuildOnStep(null,
      name: "",
      description: "",
      index: _steps.length + 1,
      proofType: BuildOnStepProofType.comment,
      proofDescription: "",
    );

    setState(() {
      _steps.add(newStep);
    });

    _openStepDialog(_steps.length - 1);
  }

  bool _updateSelectedStep() {
    if (_selectedStepIndex == null) return false;
    if (!_formKey.currentState!.validate()) return false;

    setState(() {
      _steps[_selectedStepIndex!] = _steps[_selectedStepIndex!].copyWith(
        name: _nameTextController.text,
        description: _descriptionTextController.text,
        proofType: _proofTypeTextController.text,
        proofDescription: _proofDescriptionTextController.text,
        image: _selectedImage
      );
      _selectedStepIndex = null;
    });

    return true;
  }

  void _removeSelectedStep() {
    if (_selectedStepIndex == null) return;

    setState(() {
      _steps.removeAt(_selectedStepIndex!);
      _selectedStepIndex = null;
    });
  }

  void _openStepDialog(int selectedIndex) {
    if (_selectedStepIndex != null) {
      if (!_formKey.currentState!.validate()) return;

      _updateSelectedStep();
    }

    final BuildOnStep selected = _steps[selectedIndex];

    setState(() {
      _selectedStepIndex = selectedIndex;
      _nameTextController.text = selected.name;
      _descriptionTextController.text = selected.description;
      _proofTypeTextController.text = selected.proofType;
      _proofDescriptionTextController.text = selected.proofDescription;
      _selectedImage = selected.image;
    });
  }
}