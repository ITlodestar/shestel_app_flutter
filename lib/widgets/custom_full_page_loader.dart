import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import '../constants/colors.dart';
class CustomFullPageLoader extends StatelessWidget {
  final Color? color;
  const CustomFullPageLoader({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: CircularProgressIndicator(
    //     color:color?? MyColors.primaryColor,
    //   ),
    // );
    return Container(
      color: Colors.white.withOpacity(0.4),
      child: Center(
          child: cupertino.CupertinoActivityIndicator(
            color:color?? MyColors.primaryColor,
            radius: 24,
          )
      ),
    );
    // return cupertino.CupertinoActivityIndicator
  }
}
