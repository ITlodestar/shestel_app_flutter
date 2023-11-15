
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'CustomTexts.dart';

AppBar appBar(
    {String? title,
      Function()? onTitleTap,
      Color appBarColor = Colors.transparent,
      Color titleColor = Colors.black,
      bool implyLeading = true,
      IconData backIcon = Icons.chevron_left_outlined,
      double fontsize = 18,
      double size = 25,
      double toolbarHeight = 50,
      String badge = '0',
      String fontfamily = 'medium',
      bool titlecenter = true,
      required BuildContext context,
      List<Widget>? actions, leading}) {
  return AppBar(
    toolbarHeight: toolbarHeight,
    automaticallyImplyLeading: false,
    backgroundColor: appBarColor,
    elevation: 0,
    centerTitle: titlecenter,
    title: title == null
        ? null
        : GestureDetector(
            onTap: onTitleTap,
          child: AppBarHeadingText(
            text: title,
            color: titleColor,
            fontSize: fontsize,
            fontFamily: fontfamily,
          ),
        ),
    leading: implyLeading
        ? IconButton(
        icon:
        Icon(
         backIcon,
          color: titleColor,
          size: size,
        ),
      onPressed: () {
        Navigator.pop(context);
      },
    )
        : leading,
    actions: actions,
  );
}