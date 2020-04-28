import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SignUpImages extends StatefulWidget {
  SignUpImages(this.parentAction);
  final ValueChanged<List<dynamic>> parentAction;

  @override
  _SignUpImagesState createState() => _SignUpImagesState();
}

class _SignUpImagesState extends State<SignUpImages> {

  //int _imagePosition = 0;
  //List<File> _imageList = List<File>.generate(4,(file) => File(''));
  File _image = File('');


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14.0,10,14,10),
      padding: const EdgeInsets.fromLTRB(14.0,10,14,10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]),
        borderRadius: BorderRadius.all(
            Radius.circular(25.0)
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:18.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Choose Your Profile Picture',
                style: TextStyle(fontSize: 26),),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  //_imagePosition = 0;
                  _getImage();
                },
                child: Container(
                  width: 160,
                  height: 160,
                  child:Card(
                      child: (_image.path != '')
                          ? Image.file(_image,fit: BoxFit.fill,)
                          : Icon(Icons.add_photo_alternate,
                          size: 130,color: Colors.grey[700])
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveDataAndPassToParent(String key, dynamic value) {
    List<dynamic> addData = List<dynamic>();
    addData.add(key);
    addData.add(value);
    widget.parentAction(addData);
  }

  Future _getImage() async {
    // Get image from gallery.
    File image = (await ImagePicker.pickImage(source: ImageSource.gallery));
    _cropImage(image);
  }

  Future<Null> _cropImage(File image) async {
    File croppedFile = (await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: Platform.isAndroid ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
        : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],

        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue[800],
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        )));

    if (croppedFile != null) {
      setState(() {
        _saveDataAndPassToParent('image0',croppedFile);
        _image = croppedFile;
      });
    }
  }
}
