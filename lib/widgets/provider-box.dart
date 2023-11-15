import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/colors.dart';
class ProviderBox extends StatelessWidget {

  final String img;
  const ProviderBox({
    required this.img,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      width: 135,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
          border: Border.all(color: MyColors.primaryColor),
          color: Colors.black,
          borderRadius: BorderRadius.circular(15)
      ),
      child: CachedNetworkImage(
        imageUrl: img,
        placeholder: (context, url) => Container(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      // Image.network(img),
    );
  }
}
