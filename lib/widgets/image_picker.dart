import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../constants/colors.dart';
// import 'package:file_picker/file_picker.dart';
// Future<File?> pickAudio()async{
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowedExtensions: ['mp3'],
//     type: FileType.custom
//   );

//   if (result != null) {
//     File file = File(result.files.single.path!);
//     return file;
//   } else {
//     // User canceled the picker
//   }
// }
Future<File?> pickVideo({bool isGallery = true})async{
  final ImagePicker picker = ImagePicker();
  File? video;
  String? videoFile;
  try{
    XFile? pickedVideo;
    if(isGallery){
      pickedVideo = await picker.pickVideo(source: ImageSource.gallery,);

    }else{
      pickedVideo = await picker.pickVideo(source: ImageSource.camera);
    }

    int videoLength = await pickedVideo!.length();
    print('the length of the video is');
    print(videoLength);
    // if(videoLength>10485760){
    //   if(videoLength>1085760){
    //   showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, 'Video must be less than 1 mb');
    //   // return null;
    // }
    video = File(pickedVideo.path);
    videoFile = pickedVideo.path;
  }catch(e){
    print('Error in picking video $e');
  }


  return video;


}
Future<File?> pickImage(bool isGallery) async {
  final ImagePicker picker = ImagePicker();
  File? image;
  String? _imageFile;
  try {
    print('about to pick image');
    XFile? pickedFile;
    if(isGallery){
      pickedFile = await picker.pickImage(
          source: ImageSource.gallery, imageQuality: 70);
    }
    else{
      pickedFile = await picker.pickImage(
          source: ImageSource.camera, imageQuality: 90);
    }
    print('the error is $pickedFile');
    int length = await pickedFile!.length();
    print('the length is');
    // print('size : ${length}');
    print('size: ${pickedFile.readAsBytes()}');
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        cropStyle: CropStyle.rectangle,
        // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        // compressQuality: length > 100000 ?length > 200000 ?length > 300000 ?length > 400000 ? 20:30:40: 45 : 50,
        // compressQuality: length > 100000 ?length > 200000 ?length > 300000 ?length > 400000 ? 5:10:20: 30 : 50,
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          // CropAspectRatioPreset.original,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
        AndroidUiSettings(
              activeControlsWidgetColor: MyColors.primaryColor,
              toolbarTitle: 'Adjust your Post',
              toolbarColor: MyColors.primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
        ]

    );

      _imageFile = croppedFile!.path;
      image = File(croppedFile.path);
      print(croppedFile);
      print(image);
    // setState(() {
    // });

    return image;
  } catch (e) {
    print("Image picker error $e");
  }
}

