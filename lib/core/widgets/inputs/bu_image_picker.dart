import 'dart:convert';
import 'dart:typed_data';

import 'package:buildup/core/models/bu_file.dart';
import 'package:buildup/theme/palette.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class BuImagePicker extends StatefulWidget {
  const BuImagePicker({
    Key? key,
    required this.imageURL,
    required this.onImageSelected,
    this.imageData
  }) : super(key: key);

  final String imageURL;
  final BuFile? imageData;

  final Function(BuFile) onImageSelected;

  @override
  State<BuImagePicker> createState() => _BuImagePickerState();
}

class _BuImagePickerState extends State<BuImagePicker> {
  BuFile? _image;

  @override
  void initState() {
    super.initState();

    _image = widget.imageData;
  }

  @override
  void didUpdateWidget(covariant BuImagePicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    _image = widget.imageData;
  }

  @override
  Widget build(BuildContext context) {
    // First case, we selected an image
    return Stack(
      children: [
        if (_image != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(48),
            child: Container(
              height: 92, width: 92,
              color: Theme.of(context).dividerColor,
              child: Positioned.fill(
                child: Image.memory(
                  base64Decode(_image!.base64content!),
                  fit: BoxFit.cover,
                ),
              )
            )
          )
        else 
          ClipRRect(
          borderRadius: BorderRadius.circular(48),
          child: Container(
            height: 92, width: 92,
            color: Theme.of(context).dividerColor,
            child: Positioned.fill(
              child: Image.network(
                widget.imageURL,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
                  ),
                ),
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(height: 250,);
                },
              ),
            ),
          )
        ),
        Positioned(
          top: 0,
          right: 0,
          child: CircleAvatar(
            radius: 14,
            backgroundColor: Theme.of(context).primaryColor,
            child: IconButton(
              onPressed: _pickImage,
              iconSize: 14,
              icon: const Icon(Icons.edit, color: Palette.colorWhite,),
            ),
          ),
        )
      ],
    );
  }

  Future _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true
    );

    if (result != null) {
      final Uint8List bytes = result.files.first.bytes!;
      final String fileName = result.files.first.name;

      final BuFile file = BuFile(
        base64content: base64Encode(bytes),
        filename: fileName
      );

      widget.onImageSelected(file);

      setState(() {
        _image = file;
      });
    }

  } 
}