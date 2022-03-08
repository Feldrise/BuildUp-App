import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/features/buildons/buildon.dart';
import 'package:buildup/features/buildons/buildons_edit_page/dialog/buildon_edit_dialog.dart';
import 'package:buildup/features/buildons/buildons_edit_page/widgets/buildon_edit_card.dart';
import 'package:buildup/features/buildons/steps/buildon_steps_edit_page/buildon_steps_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BuildOnsEditList extends StatefulWidget {
  const BuildOnsEditList({
    Key? key,
    required this.buildOns,
    required this.creationMutation,
    required this.updateMutation,
    this.maxPanelWidth = 200
  }) : super(key: key);

  final List<BuildOn> buildOns;
  final double maxPanelWidth;

  final RunMutation creationMutation;
  final RunMutation updateMutation;

  @override
  State<BuildOnsEditList> createState() => BuildOnsEditListState();
}

class BuildOnsEditListState extends State<BuildOnsEditList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();
  final TextEditingController _urlTextController = TextEditingController();
  final TextEditingController _rewardsTextController = TextEditingController();

  List<BuildOn> _buildOns = [];
  double _maxPanelWidth = 200;

  int? _selectedBuildOnIndex;

  void _initialize() {
    _buildOns = widget.buildOns;
    _maxPanelWidth = widget.maxPanelWidth;
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(covariant BuildOnsEditList oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // The list of the buildons
        Expanded(
          child: Scaffold(
            // The list
            body: Center(
              child: _buildOns.isEmpty ? _buildEmptyInfo(context) : Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: ScreenUtils.instance.horizontalPadding
                ),
                constraints: const BoxConstraints(maxWidth: 650),
                child: ReorderableListView.builder(
                  scrollController: ScrollController(),
                  onReorder: (oldIndex, newIndex) {
                    final item = _buildOns.removeAt(oldIndex);
                    _buildOns.insert(newIndex < oldIndex ? newIndex : newIndex -1, item);

                    if (_selectedBuildOnIndex == oldIndex) _selectedBuildOnIndex = newIndex < oldIndex ? newIndex : newIndex - 1;
                  },
                  itemCount: _buildOns.length,
                  itemBuilder: (context, index) => InkWell(
                    key: ValueKey(_buildOns[index]),
                    onTap: () => _openBuildOnDialog(index),
                    child: BuildOnEditCard(
                      isSelected: index == _selectedBuildOnIndex,
                      buildOn: _buildOns[index],
                    ),
                  ),
                ),
              ),
            ),
            // The add button
            floatingActionButton: FloatingActionButton(
              onPressed: _onAddNewBuildOn,
              child: const Icon(Icons.add),
            ),
          ),
        ),

        // The edit buildon dialog
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _selectedBuildOnIndex != null ? _maxPanelWidth : 0.0,
          child: _selectedBuildOnIndex != null ? BuildOnEditDialog(
            formKey: _formKey,
            nameTextController: _nameTextController,
            descriptionTextController: _descriptionTextController,
            urlTextController: _urlTextController,
            rewardsTextController: _rewardsTextController,
            buildOnStepsCount: _buildOns[_selectedBuildOnIndex!].steps.length,
            onClose: _updateSelectedBuildOn,
            onRemove: _removeSelectedBuildOn,
            onOpenSteps: _openBuildOnStepsDialog,
          ) : Container(),
        )
      ],
    );
  }

  Widget _buildEmptyInfo(BuildContext context) {
    return Column(
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
          "Il n'y a aucun Build-On pour le moment. Ajoutez-en un en appuyant sur le bouton +",
          style: TextStyle(
            color: Theme.of(context).textTheme.caption!.color
          ),
        )
      ],
    );
  }

  Future<bool> save() async {
    if (!_updateSelectedBuildOn() && _selectedBuildOnIndex != null) return false;

    for (int i = 0; i < _buildOns.length; ++i) {
      final BuildOn buildOn = _buildOns[i];

      if (buildOn.id == null) {
        widget.creationMutation(<String, dynamic>{
          "name": buildOn.name,
          "description": buildOn.description,
          "index": i+1,
          "annexeUrl": buildOn.annexeUrl,
          "rewards": buildOn.rewards
        });
      } 
      else {
        widget.updateMutation(<String, dynamic>{
          "id": buildOn.id,
          "name": buildOn.name,
          "description": buildOn.description,
          "index": i+1,
          "annexeUrl": buildOn.annexeUrl,
          "rewards": buildOn.rewards
        });
      }
    }

    return true;
  }

  void _onAddNewBuildOn() {
    if (_formKey.currentState != null && !_formKey.currentState!.validate()) return;

    final BuildOn newBuildOn = BuildOn(null, 
      name: "", 
      description: "",
      index: _buildOns.length + 1,
      annexeUrl: "",
      rewards: "",
      steps: const []
    );

    setState(() {
      _buildOns.add(newBuildOn);
    });

    _openBuildOnDialog(_buildOns.length - 1);
  }

  bool _updateSelectedBuildOn() {
    if (_selectedBuildOnIndex == null) return false;
    if (!_formKey.currentState!.validate()) return false;

    setState(() {
      _buildOns[_selectedBuildOnIndex!] = _buildOns[_selectedBuildOnIndex!].copyWith(
        name: _nameTextController.text,
        description: _descriptionTextController.text,
        annexeUrl: _urlTextController.text,
        rewards: _rewardsTextController.text
      );
      _selectedBuildOnIndex = null;
    });

    return true;
  }

  void _removeSelectedBuildOn() {
    if (_selectedBuildOnIndex == null) return;

    setState(() {
      _buildOns.removeAt(_selectedBuildOnIndex!);
      _selectedBuildOnIndex = null;
    });
  }

  Future _openBuildOnStepsDialog() async {
    if (_selectedBuildOnIndex == null) return;
    if (!_formKey.currentState!.validate()) return;
    
    final int currentIndex = _selectedBuildOnIndex!;
    final bool saved = await save();

    if (!saved) return;

    Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (context) => BuildOnStepEditPage(buildOnId: _buildOns[currentIndex].id!)
      )
    );
  }

  void _openBuildOnDialog(int selectedIndex) {
    if (_selectedBuildOnIndex != null) {
      if (!_formKey.currentState!.validate()) return;

      _updateSelectedBuildOn();
    }

    final BuildOn selected = _buildOns[selectedIndex];

    setState(() {
      _nameTextController.text = selected.name;
      _descriptionTextController.text = selected.description;
      _urlTextController.text = selected.annexeUrl;
      _rewardsTextController.text = selected.rewards;

      _selectedBuildOnIndex = selectedIndex;
    });
  }

}