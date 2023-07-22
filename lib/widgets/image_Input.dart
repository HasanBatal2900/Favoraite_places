import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
  const ImageInput({super.key, required this.onSelectedImage});
  final Function(File) onSelectedImage;
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selcetedImage;

  void _takePictureGallery() async {
    final imagePicker = ImagePicker();
    final imagePicked = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (imagePicked == null) {
      return;
    }

    setState(() {
      _selcetedImage = File(imagePicked.path);
    });
    widget.onSelectedImage(_selcetedImage!);
  }

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final imagePicked = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imagePicked == null) {
      return;
    }

    setState(() {
      _selcetedImage = File(imagePicked.path);
    });
    widget.onSelectedImage(_selcetedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          icon: const Icon(Icons.store),
          onPressed: _takePictureGallery,
          label: const Text("Choose From Gallery"),
        ),
        TextButton.icon(
          icon: const Icon(Icons.camera),
          onPressed: _takePicture,
          label: const Text("Choose a Picture"),
        ),
      ],
    );

    if (_selcetedImage != null) {
      content = GestureDetector(
        child: Image.file(
          _selcetedImage!,
          width: double.infinity,
          fit: BoxFit.cover,
          height: double.infinity,
        ),
        onTap: _takePicture,
      );
    }

    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: content,
    );
  }
}
