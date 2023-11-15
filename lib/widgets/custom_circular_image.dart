import 'dart:io';

import 'package:flutter/material.dart';

import 'customLoader.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:shestel_app/constants/colorsmodal.dart';
// import 'package:shestel_app/constants/images_url.dart';
// import 'package:shestel_app/widgets/customLoader.dart';
// import 'package:provider/provider.dart';
enum CustomFileType { asset, network, file }

class CustomCircularImage extends StatelessWidget {
  final double height;
  final double width;
  final double? borderRadius;
  final String imageUrl;
  final CustomFileType fileType;
  final File? image;
  final BoxFit? fit;
  const CustomCircularImage({
    Key? key,
    required this.imageUrl,
    this.image,
    this.height = 60,
    this.width = 60,
    this.borderRadius,
    this.fileType = CustomFileType.network,
    this.fit
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius??height),
        image:fileType==CustomFileType.asset?  DecorationImage(
            image: AssetImage(
                imageUrl
            ),fit: fit??BoxFit.cover,
          alignment: Alignment.bottomCenter
        ):fileType==CustomFileType.file?
        DecorationImage(
            image: FileImage(
                image!
            ),
          fit: fit??BoxFit.cover
        )
            :
        // DecorationImage(
        //   image: NetworkImage(
        //     imageUrl
        //   ),
        //
        //   fit: fit??BoxFit.cover,
        // ),
        null
      ),
      child: fileType==CustomFileType.network?
      CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit??BoxFit.cover,
          alignment: Alignment.bottomCenter,
        // placeholder: (context, url) => Padding(
        //   padding: const EdgeInsets.all(14.0),
        //   child: CustomLoader(),
        // ),
        // errorWidget: (context, url, error) => Icon(Icons.error, color: Provider.of<MyColorssec>(context).blackColor,),
        // errorWidget: (context, url, error) =>Icon(Icons.error, ),
        errorWidget: (context, url, error) =>Container(
          color: Colors.white,
        ),
      ):null,

    );
  }
}




// class CustomCircularImage1 extends StatelessWidget {
//   final double height;
//   final double width;
//   final double? borderRadius;
//   final String imageUrl;
//   final CustomFileType fileType;
//   final File? image;
//   final BoxFit? fit;
//   const CustomCircularImage1({
//     Key? key,
//     required this.imageUrl,
//     this.image,
//     this.height = 60,
//     this.width = 60,
//     this.borderRadius,
//     this.fileType = CustomFileType.network,
//     this.fit
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(borderRadius??height),
//           image:fileType==CustomFileType.asset?  DecorationImage(
//               image: AssetImage(
//                   imageUrl
//               )
//           ):DecorationImage(
//             image: NetworkImage(
//                 imageUrl
//             ),
//
//             fit: fit,
//           )
//       ),
//
//
//     );
//   }
// }