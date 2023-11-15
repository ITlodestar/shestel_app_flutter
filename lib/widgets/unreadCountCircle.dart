import 'package:flutter/material.dart';
import 'package:livestream/constants/colors.dart';

import '../constants/global_data.dart';
import 'CustomTexts.dart';
class unreadCircle extends StatefulWidget {
  String type='';
  unreadCircle({
    required this.type,
    Key? key}) : super(key: key);

  @override
  State<unreadCircle> createState() => _unreadCircleState();
}

class _unreadCircleState extends State<unreadCircle> {
  int count=0;
  bool showCirlce=false;
  @override
  void initState() {
    // TODO: implement initState
    updateUi();
    super.initState();
  }

  updateUi() {
    Future.delayed(Duration(milliseconds: 1000),(){
      try{
        if(this.mounted)
        setState(() {
          // showCirlce
          if(widget.type=='single'){
            if(singleChatCount>0){
              count = singleChatCount;
              showCirlce=true;
            }
            else{
              showCirlce=false;
            }
          }
          else if(widget.type=='group'){
            if(unreadGroupChatCount>0){
              count = unreadGroupChatCount;
              showCirlce=true;
            }
            else{
              showCirlce=false;
            }
          }
          else if(widget.type=='notification'){
            if(NotiCount>0){
              count = NotiCount;
              showCirlce=true;
            }
            else{
              showCirlce=false;
            }
          }
          else if(widget.type=='allchat'){
            if(unreadChatCount>0){
              count = unreadChatCount;
              showCirlce=true;
            }
            else{
              showCirlce=false;
            }
          }
        });

      }
      catch(e){
          print("error-----------unread----${e}");
      }
      updateUi();

    });
  }


  @override
  Widget build(BuildContext context) {
    return (showCirlce)?Container(
        margin: EdgeInsets.only(left:10),
        height: (widget.type=='allchat')?14:20,
        width: (widget.type=='allchat')?14:20,
        decoration: BoxDecoration(
          color: (widget.type=='allchat')?Colors.red:Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3),
          child: ParagraphText(text:count.toString(),textAlign: TextAlign.end,color: Colors.white,fontSize: (widget.type=='allchat')?9:10,),
        ))):Container();
  }
}
