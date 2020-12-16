import 'package:buildup/entities/bu_file.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class BuFilePicker extends StatefulWidget {
  const BuFilePicker({
    Key key, 
    @required this.file,
    this.onUpdated, 
  }) : super(key: key);

  final Function() onUpdated;

  final BuFile file;

  @override
  _BuFilePickerState createState() => _BuFilePickerState();
}

class _BuFilePickerState extends State<BuFilePicker> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
         BuButton(
          text: "Choisir un fichier",
          icon: Icons.upload_file, 
          onPressed: _selecteFile
        ),
        const SizedBox(width: 5,),
        if (widget.file?.data != null)
          Text(widget.file.fileName)
      ],
    );
  }

  Future _selecteFile() async {
    final FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final PlatformFile file = result.files.first;
      widget.file.data = file.bytes;
      widget.file.fileName = file.name;

      setState(() {});

      if (widget.onUpdated != null) {
        widget.onUpdated();
      }
    }
  }
}