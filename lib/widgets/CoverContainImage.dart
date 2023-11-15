import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'customLoader.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:shestel_app/constants/colorsmodal.dart';
// import 'package:shestel_app/constants/images_url.dart';
// import 'package:shestel_app/widgets/customLoader.dart';
// import 'package:provider/provider.dart';
enum CustomFileType { asset, network, file }

class CoverContainImage extends StatelessWidget {
  final double height;
  final double width;
  final double? borderRadius;
  final String imageUrl;
  final CustomFileType fileType;
  final File? image;
  final BoxFit? fit;
  const CoverContainImage({
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
      child: Stack(
        children: [

          CachedNetworkImage(
            width: width,
            imageUrl: imageUrl,
            fit: BoxFit.cover,


            errorWidget: (context, url, error) =>Container(
              color: Colors.white,
            ),
          ),
          new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: new Container(
              decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
          ),
      Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.contain,


          errorWidget: (context, url, error) =>Container(
            color: Colors.white,
          ),
        ),
      )
        ],
      ),

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