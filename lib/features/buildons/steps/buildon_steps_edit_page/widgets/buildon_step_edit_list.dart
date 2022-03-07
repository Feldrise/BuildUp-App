import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/features/buildons/steps/buildon_step.dart';
import 'package:buildup/features/buildons/steps/buildon_steps_edit_page/dialog/buildon_step_edit_dialog.dart';
import 'package:buildup/features/buildons/steps/buildon_steps_edit_page/widgets/buildon_step_edit_card.dart';
import 'package:flutter/material.dart';

class BuildOnStepEditList extends StatefulWidget {
  const BuildOnStepEditList({
    Key? key,
    required this.steps,
    this.maxPanelWidth = 200
  }) : super(key: key);

  final List<BuildOnStep> steps;
  final double maxPanelWidth;

  @override
  State<BuildOnStepEditList> createState() => _BuildOnStepEditListState();
}

class _BuildOnStepEditListState extends State<BuildOnStepEditList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();
  final TextEditingController _proofDescriptionTextController = TextEditingController();

  List<BuildOnStep> _steps = [];

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
              child: Container(
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
            formKey: _formKey,
            nameTextController: _nameTextController,
            descriptionTextController: _descriptionTextController,
            proofDescriptionTextController: _proofDescriptionTextController,
            onClose: _updateSelectedStep,
            onRemove: _removeSelectedStep,
          ) : Container(),
        )
      ],
    );
  }

  void _onAddNewStep() {
    if (_formKey.currentState != null && !_formKey.currentState!.validate()) return;

    final BuildOnStep newStep = BuildOnStep(null,
      name: "",
      description: "",
      index: _steps.length + 1,
      proofDescription: ""
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
        proofDescription: _proofDescriptionTextController.text,
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
      _proofDescriptionTextController.text = selected.proofDescription;
    });
  }
}