import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/global_data.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../constants/sized_box.dart';
import 'CustomTexts.dart';


class CustomPhoneNumberInput extends StatefulWidget {
  final TextEditingController controller;
  final String phone_code;
  final String hintText;
  final BoxBorder? border;
  final double horizontalPadding;
  final bool obscureText;
  final int? maxLines;
  final Color bgColor;
  final Color inputbordercolor;
  final Color hintcolor;
  final double fontsize;
  final double left;
  final double suffixheight;
  final double height;
  final double borderradius;
  final double verticalPadding;
  final String? prefixIcon;
  final String? prefixText;
  final Widget? suffixIcon;
  final TextAlign textAlign;
  final double paddingsuffix;
  final bool? enabled;
  final bool boxshadow;
  final FocusNode? focusNode;

  final bool issufiximage;

  final Function()? visiblity;
  final Function(String?)? onChange;
  final Color? textColor;
  final BuildContext context;
  final TextInputAction? textInputAction;
  CustomPhoneNumberInput({
    Key? key,
    required this.onChange,
    this.textInputAction=null,
    required this.controller,
    required this.hintText,
    this.border,
    this.maxLines,
    this.focusNode=null,
    this.horizontalPadding = 0,
    this.enabled=true,
    // this.onChange=null,
    this.prefixText,
    required this.context,
    // this.verticalPadding = false,
    this.obscureText = false,
    this.bgColor = Colors.white,
    this.inputbordercolor = Colors.transparent,
    this.hintcolor = MyColors.textcolor,
    this.verticalPadding = 0,
    this.fontsize = 13,
    this.left = 16,
    this.suffixheight = 10,
    this.height = 45,
    this.borderradius = 30,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign = TextAlign.left,
    this.paddingsuffix = 12,
    this.boxshadow=false,
    this.issufiximage=true,
    this.visiblity,
    this.textColor = MyColors.black,
    required this.phone_code
  }) : super(key: key);

  @override
  State<CustomPhoneNumberInput> createState() => _CustomPhoneNumberInputState();
}

class _CustomPhoneNumberInputState extends State<CustomPhoneNumberInput> {
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      margin: EdgeInsets.symmetric(horizontal: widget.horizontalPadding, vertical: widget.verticalPadding),
      decoration: BoxDecoration(
          color: widget.bgColor,
          border: widget.border?? Border.all(color: Colors.transparent),
          // border: Border,
          borderRadius: BorderRadius.circular(widget.borderradius),
          boxShadow:[
            shadow
          ]
      ),
      padding: EdgeInsets.only(left: widget.prefixIcon != null? 0 : widget.left),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
              child: GestureDetector(
                onTap: (){
                   showCupertinoModalPopup(
                      context: context,
                      builder: (_) => CupertinoActionSheet(
                        actions: [
                          for(int i=0;i < countries.length;i++ )
                          CupertinoActionSheetAction(
                              onPressed: () async {

                                widget.onChange!(countries[i]['phone_code'].toString());
                                Navigator.pop(context);
                              },
                              child: Text("(+${countries[i]['phone_code']}) ${countries[i]['name']}")
                          ),

                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: ()
                          {
                          widget.onChange!(null);
                          Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ));
                },
                child: (widget.phone_code=='')?Text("+1", style:TextStyle(color:Colors.grey, fontSize: 13)):Text("+"+widget.phone_code, style: TextStyle(fontSize: 13),),
              )
          ),
          Expanded(
            flex: 7,
            child: TextField(
              // onChanged: widget.onChange,
              // onSubmitted:widget.onSubmitted,
              focusNode: widget.focusNode,
              keyboardType: TextInputType.phone,
              // textInputAction:TextInputAction.,
              style: TextStyle(color: widget.textColor, fontSize: widget.fontsize, fontFamily: 'regular'),
              maxLines: widget.maxLines ?? 1,
              controller: widget.controller,
              enabled: widget.enabled,

              textAlign: widget.textAlign,
              textAlignVertical: TextAlignVertical.center,

              decoration: InputDecoration(
                isDense: true,
                hintText: widget.hintText,
                hintStyle: TextStyle(fontSize: widget.fontsize, color: widget.hintcolor, fontFamily: 'regular'),
                // border: InputBorder.none ,
                // focusedBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: inputbordercolor)
                // ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: widget.inputbordercolor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: widget.inputbordercolor),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: widget.inputbordercolor),
                ),
                prefixIcon:widget.prefixIcon==null?null:
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 8.0,bottom: 08.0),
                  child: Image.asset(
                    widget.prefixIcon!,
                    width: 10,
                    height: 10,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                suffixIcon: widget.suffixIcon,
                // suffix: widget.suffixIcon,

                //
                //     ==null?null:
                // Padding(
                //   padding: EdgeInsets.all(widget.paddingsuffix),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       if(widget.issufiximage)
                //       Image.asset(
                //         widget.suffixIcon!,
                //         // color: Colors.black,
                //         // width: 10,
                //         height: widget.suffixheight,
                //         fit: BoxFit.fitHeight,
                //       ),
                //       if(widget.issufiximage == false)
                //       GestureDetector(
                //         onTap:widget.visiblity,
                //         //     (){
                //         //   setState((){
                //         //     visiblity = !visiblity;
                //         //   });
                //         // },
                //           child: Icon(
                //             visiblity? Icons.visibility_outlined:
                //             Icons.visibility_off_outlined,
                //             color: MyColors.primaryColor,
                //             size: 18,
                //           )
                //       )
                //     ],
                //   ),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}