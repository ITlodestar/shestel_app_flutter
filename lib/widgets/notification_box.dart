import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import 'CustomTexts.dart';
import 'avatar.dart';
import 'buttons.dart';
import 'custom_circular_image.dart';
class NotificationBox extends StatelessWidget {
  Function()? onTap;
  Function(String) onAccept;
  Function(String) onReject;

  final Map data;
  NotificationBox({
    this.onTap,
    required this.onAccept,
    required this.onReject,
    required this.data,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                // margin: EdgeInsets.only(right:84),
                color: data['is_read'].toString()=="0" ? MyColors.primaryColor.withOpacity(0.2): Colors.transparent,
                // color:  Colors.red,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              if(data['type']!="accept-friend-request" && data['type']!='new-friend-request' &&  data['type']!='reject-friend-request')
                                CustomCircularImage(
                                // borderradius: 8,
                                height: 55,
                                width: 55,
                                // height: 55,
                                // width: 65,
                                fit: BoxFit.cover,
                                // border: true,
                                // isNetwork:true,
                                imageUrl: data['profile'],
                                // bgcolor: MyColors.primaryColor,
                              ),
                              if(data['type']=="accept-friend-request" || data['type']=='new-friend-request' || data['type']=='reject-friend-request')
                                CustomCircularImage(
                                // isNetwork:true,
                                imageUrl: data['profile'],
                                // borderradius: 8,
                                height: 55,
                                width: 55,
                                fit: BoxFit.cover,
                                // bgcolor: MyColors.primaryColor,
                              ),
                              hSizedBox,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ParagraphText(
                                      text: data['sender'],
                                      color: MyColors.white,
                                      fontSize: 16, fontFamily: 'medium',),
                                    ParagraphText(
                                      text: data['message'],
                                      fontSize: 13,
                                      fontFamily: 'light',
                                      color: Colors.white.withOpacity(0.50),
                                    ),
                                    if(data['type']=='new-friend-request' && data['firend_data']!=null && data['firend_data']['status'].toString()=='0')
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        RoundEdgedButton(onTap:
                                        (){

                                          onAccept(data['firend_data']['id'].toString());
                                        }
                                        ,
                                          load: data['loadA'],
                                          text: "Accept", textColor: Colors.white, height:25, width:70, fontSize: 12, horizontalPadding: 8,verticalPadding: 3, verticalMargin: 5,),
                                        SizedBox(width:20),
                                        RoundEdgedButton(onTap:   (){
                                          onReject(data['firend_data']['id'].toString());
                                        },
                                            load: data['loadR'],
                                            text: "Reject", textColor: Colors.white, height:25, width:70, fontSize: 12,horizontalPadding: 8, verticalPadding: 3, verticalMargin: 5),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),

                  ],
                ),
              ),
              Divider(height: 0, color: Colors.white.withOpacity(0.5),),
            ],
          ),
          Positioned(
            right:10,
            bottom:8,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: ParagraphText(
                text: data['time_ago'],
                fontSize: 12,
                color: MyColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }



}
