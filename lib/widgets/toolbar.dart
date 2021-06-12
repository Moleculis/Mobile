import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moleculis/utils/widget_utils.dart';

class Toolbar extends StatefulWidget {
  final String title;
  final String? initialImageUrl;
  final ValueChanged<File>? onImagePicked;
  final bool backButton;
  final String? cardId;
  final File? imageFile;
  final List<Widget>? actions;

  const Toolbar({
    Key? key,
    required this.title,
    this.onImagePicked,
    this.initialImageUrl,
    this.backButton = false,
    this.cardId,
    this.imageFile,
    this.actions,
  }) : super(key: key);

  @override
  _ToolbarState createState() => _ToolbarState();
}

class _ToolbarState extends State<Toolbar> {
  final ImagePicker imagePicker = ImagePicker();

  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: <Widget>[
                if (widget.backButton) WidgetUtils.backButton(context),
                Expanded(
                  child: AutoSizeText(
                    widget.title,
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.onImagePicked != null)
          if (widget.imageFile != null)
            imageView(widget.imageFile!)
          else
            pickedImage == null ? emptyImage : imageView(pickedImage!),
        if (widget.actions != null)
          ...widget.actions!.map((Widget action) => action).toList(),
      ],
    );
  }

  Widget get emptyImage {
    final bool toShowCameraIcon =
        widget.initialImageUrl == null || widget.initialImageUrl!.isEmpty;
    return GestureDetector(
      onTap: () {
        addImage();
      },
      child: CircleAvatar(
        backgroundColor: Theme.of(context).accentColor,
        backgroundImage: widget.initialImageUrl == null
            ? null
            : NetworkImage(widget.initialImageUrl!),
        radius: 50,
        child: toShowCameraIcon
            ? Icon(Icons.camera_enhance, color: Colors.grey[600], size: 28.0)
            : null,
      ),
    );
  }

  Widget imageView(File imageFile) {
    return GestureDetector(
      onTap: () {
        addImage();
      },
      child: CircleAvatar(
        backgroundImage: FileImage(imageFile),
        backgroundColor: Theme.of(context).accentColor,
        radius: 50,
      ),
    );
  }

  Future<void> addImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text(
                    'camera'.tr(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text(
                    'gallery'.tr(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final PickedFile? image = await imagePicker.getImage(source: source);
    if (image != null) {
      final imageFile = File(image.path);
      setState(() {
        pickedImage = imageFile;
      });

      widget.onImagePicked!(imageFile);
    }
  }
}
