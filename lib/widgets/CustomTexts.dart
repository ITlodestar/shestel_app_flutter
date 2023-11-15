import 'package:flutter/material.dart';

class MainHeadingText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final double? height;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  const MainHeadingText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily = 'medium',
    this.textAlign,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color??Colors.black,
        // fontWeight:fontWeight??FontWeight.w500,
        fontSize: fontSize??20,
        // fontFamily:
        fontWeight: fontWeight?? FontWeight.bold,
        fontFamily: fontFamily,
        height: height,
        letterSpacing: 1,
      ),
    );
  }
}



class AppBarHeadingText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  const AppBarHeadingText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color??Colors.black,
          fontWeight:fontWeight??FontWeight.w500,
          fontSize: fontSize??22,
          // fontFamily:
          fontFamily: fontFamily
      ),
    );
  }
}

class SubHeadingText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign textAlign;
  final bool underlined;
  const SubHeadingText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textAlign=TextAlign.start,
    this.underlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color??Colors.black,
          fontWeight:fontWeight??FontWeight.w500,
          fontSize: fontSize??16,
          // fontFamily:
          fontFamily: fontFamily,
        decoration:underlined? TextDecoration.underline:null,
      ),
    );
  }
}

class ParagraphText extends StatelessWidget {
  final String text;
  final double? letterspaceing;
  final double? height;
  final Color? color;
  final double? fontSize;
  final int? maxline;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  final bool underlined;
  final TextOverflow? overflow;
  const ParagraphText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.maxline,
    this.letterspaceing,
    this.height,
    this.fontWeight,
    this.fontFamily,
    this.textAlign,
    this.underlined = false,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxline??null,
      textAlign: textAlign??TextAlign.start,
      overflow: overflow,


      style: TextStyle(
          // height: 1.5,
          overflow: maxline != null?TextOverflow.ellipsis: null,
          color: color??Colors.white,
          fontWeight:fontWeight??FontWeight.w400,
          fontSize: fontSize??15,
          height: height,
          // fontFamily:
          fontFamily: fontFamily,
          decoration:underlined? TextDecoration.underline:null,
          letterSpacing: letterspaceing?? 0,
      ),
    );
  }
}

class headingText extends StatelessWidget {
  final String text;
  final double? letterspaceing;
  final double? height;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  final bool underlined;
  const headingText({
    Key? key,
    required this.text,
    this.color = Colors.black,
    this.fontSize = 16,
    this.letterspaceing,
    this.height,
    this.fontWeight,
    this.fontFamily = 'semibold',
    this.textAlign,
    this.underlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign??TextAlign.start,
      style: TextStyle(
        // height: 1.5,
          color: color??Colors.black,
          fontWeight:fontWeight??FontWeight.w400,
          fontSize: fontSize??14,
          height: height,
          // fontFamily:
          fontFamily: fontFamily,
          decoration:underlined? TextDecoration.underline:null,
          letterSpacing: letterspaceing?? 0
      ),
    );
  }
}

class CustomDivider extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Divider(
      height: 40,
      thickness: 3,
      color: Color(0xFFF2F4FF),
    );
  }
}