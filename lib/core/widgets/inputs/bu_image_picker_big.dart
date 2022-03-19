import 'dart:convert';
import 'dart:typed_data';

import 'package:buildup/core/models/bu_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class BuImagePickerBig extends StatefulWidget {
  const BuImagePickerBig({
    Key? key,
    required this.imageURL,
    required this.onImageSelected,
    this.imageData
  }) : super(key: key);

  final String imageURL;
  final BuFile? imageData;

  final Function(BuFile) onImageSelected;

  @override
  State<BuImagePickerBig> createState() => _BuImagePickerBigState();
}

class _BuImagePickerBigState extends State<BuImagePickerBig> {
  BuFile? _image;

  @override
  void initState() {
    super.initState();

    _image = widget.imageData;
  }

  @override
  void didUpdateWidget(covariant BuImagePickerBig oldWidget) {
    super.didUpdateWidget(oldWidget);

    _image = widget.imageData;
  }

  @override
  Widget build(BuildContext context) {
    // First case, we selected an image
    return Container(
      color: Theme.of(context).dividerColor,
      child: Stack(
        children: [
          if (_image != null)
            Positioned.fill(
              child: Image.memory(
                  base64Decode(_image!.base64content!),
                  fit: BoxFit.cover,
              ),
            )
          else 
            Positioned.fill(
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: _pickImage,
                child: Row(
                  children: const [
                    Icon(Icons.add),
                    SizedBox(width: 8,),

                    Text("Ajouter une image")
                  ],
                ),
              ),
            ),
          )
        ],
      ),
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