import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livestream/constants/sized_box.dart';
import 'dart:io';

import '../constants/colors.dart';
// import 'package:file_picker/file_picker.dart';
// Future<File?> pickAudio()async{
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowedExtensions: ['mp3'],
//     type: FileType.custom
//   );
//
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



Future<File?> openImagePicker(
BuildContext context, {
double height = 165,
      bool shouldCrop=false

}) {
return showModalBottomSheet(
context: context,

isScrollControlled: true,
backgroundColor: Colors.transparent,
builder: (context) {
return Container(
height: height + MediaQuery.of(context).viewInsets.bottom,
padding: EdgeInsets.symmetric(horizontal: 0,vertical: 16),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.only(
topLeft: Radius.circular(20),
topRight: Radius.circular(20),
),
),
child: Column(children: [
  GestureDetector(
    onTap: () async{
      File? m = await pickImage(shouldCrop: shouldCrop,isGallery:false);
      Navigator.pop(context,m);
    },
    child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left:20,right:20, top:8, bottom:8),
        child: Row(
          children: [
            Icon(Icons.camera_alt_rounded), hSizedBox,
            Text("Take Photo", style: TextStyle(fontSize: 20),),
          ],
        )
    ),
  ),

  GestureDetector(
    onTap: () async{
          File? m = await pickImage(shouldCrop: shouldCrop,isGallery:true);
          Navigator.pop(context,m);
    },
    child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left:20,right:20, top:8, bottom:8),
        child: Row(
          children: [
            Icon(Icons.image), hSizedBox,
            Text("Choose From Gallery", style: TextStyle(fontSize: 20),),
          ],
        )
    ),
  ),

  GestureDetector(
    onTap: (){
        Navigator.pop(context);
        // return null;
    },
    child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left:20,right:20, top:8, bottom:8),
        child: Row(
          children: [
            Icon(Icons.close), hSizedBox,
            Text("Close", style: TextStyle(fontSize: 20),),
          ],
        )
    ),
  ),
],),
);
});
}


Future<File?> pickImage({bool shouldCrop = false, bool isGallery = true,int? maxSize}) async {
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
    if(pickedFile==null){
      return null;
    }
    print('the error is $pickedFile');
    // int length = await pickedFile!.;
    var length = await pickedFile.length();
    // print('the length is ${length}');
    // // print('size : ${length}');
    // print('size: ${pickedFile.readAsBytes()}');
    CroppedFile? croppedFile = null;//File(pickedFile!.path);
    if(shouldCrop){
      croppedFile = await ImageCropper().cropImage(
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
          uiSettings: [AndroidUiSettings(
              activeControlsWidgetColor: MyColors.primaryColor,
              toolbarTitle: 'Adjust your Post',
              toolbarColor: MyColors.primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
            IOSUiSettings(
              minimumAspectRatio: 1.0,
            )
          ]);
      _imageFile = croppedFile!.path;
      image = File(croppedFile.path);

      print("cropped file"+croppedFile.toString());
      print("cropped image"+image.toString());
    }
    else{
      _imageFile = pickedFile.path;
      image = File(pickedFile.path);
    }


      print(image);
    // setState(() {
    // });

    return image;
  } catch (e) {
    print("Image picker error $e");
  }
}

