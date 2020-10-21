import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class UserImage extends StatefulWidget {
  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File image;
  Future getImage(bool isCamera) async {
    File userImage;
    {
      userImage =
          (await ImagePicker().getImage(source: ImageSource.camera)) as File;
      setState(() {
        image = userImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
