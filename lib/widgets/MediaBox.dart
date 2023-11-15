import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/global_data.dart';
import '../constants/sized_box.dart';
import 'CustomTexts.dart';
import 'buttons.dart';
import 'custom_circular_image.dart';
class MediaBox extends StatelessWidget {
  final data;
  final Function() onTap;
  final double marginRight;
  const MediaBox({
    required this.data,
    required this.onTap,
    this.marginRight=8,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
                  width: MediaQuery.of(context).size.width / 2 - 16,
                  height: 270,
                  margin: EdgeInsets.only(right: marginRight),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),

                  ),
                  child: (data['media_type']==MediaType.sport.name) ?
                  Container(  width: MediaQuery.of(context).size.width / 2 - 16,
                      height: 270,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColors.primaryColor,

                        ),
                        image: DecorationImage(image:AssetImage('assets/images/sportlogo.png'), opacity: 0.15, alignment: Alignment.bottomCenter, fit: BoxFit.contain),
                        borderRadius: BorderRadius.circular(12),),
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children:[
                            if(data['completed'].toString()=="1" && data['scores'].length>0)
                            vSizedBox
                            else
                              vSizedBox4,

                        ParagraphText(text: data['sport_title'],
                          fontSize: 15,
                          fontFamily: 'medium',


                        ),
                            if(data['completed'].toString()=="1" && data['scores'].length>0)
                              vSizedBox
                            else
                            vSizedBox2,
                              ParagraphText(text: data['home_team']  ,
                                textAlign: TextAlign.center,
                                fontSize: 17,
                                fontFamily: 'medium',
                                color: Colors.white,
                              ),
                            if(data['completed'].toString()=="1" && data['scores'].length>0)
                            vSizedBox05
                            else
                            vSizedBox,
                            ParagraphText(text: 'VS'  ,
                              fontSize: 18,
                              fontFamily: 'medium',
                              color: Colors.white,
                            ),
                            if(data['completed'].toString()=="1" && data['scores'].length>0)
                              vSizedBox05
                            else
                              vSizedBox,
                              ParagraphText(text: data['away_team']  ,
                                fontSize: 15,
                                fontFamily: 'medium',
                                textAlign: TextAlign.center,
                                color: Colors.white,
                              ),
                            if(data['completed'].toString()=="1" && data['scores'].length>0)
                              vSizedBox05
                            else
                              vSizedBox,
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                              decoration: BoxDecoration(
                                color:MyColors.primaryColor,
                                borderRadius: BorderRadius.circular(8)
                                
                                
                              ),
                              child: ParagraphText(text: data['commence_time']  ,
                                fontSize: 12,
                                fontFamily: 'medium',
                                color: MyColors.white,
                              ),
                            ),
                            if(data['completed'].toString()=="1" && data['scores'].length>0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  vSizedBox,

                                  for(int ii=0; ii<data['scores'].length;ii++)
                                    Container(
                                      padding: EdgeInsets.only(top:5),
                                      child: Wrap(


                                        children: [
                                          Text(data['scores'][ii]['name']+": ", style: TextStyle(color:Colors.amber, fontWeight: FontWeight.bold, fontSize: 12), ),
                                          Text(data['scores'][ii]['score'], style: TextStyle(color:Colors.white, fontSize: 13),),
                                        ],
                                      ),
                                    )


                                ],
                              )

                          ])
                  ):
                    Stack(
                    children: [
                      CustomCircularImage(
                        imageUrl: data['url'],
                        fit: BoxFit.cover,
                        borderRadius: 12,
                        width: MediaQuery.of(context).size.width / 2 - 16,
                        height: 270,
                      ),
                      Positioned(
                        left: 0,right: 0,bottom: 20,
                        child: Container(
                          height: 55,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              boxShadow: [new BoxShadow(
                                  color: Colors.black.withOpacity(0.7),
                                  blurRadius: 15.0,
                                  spreadRadius: 15,
                                  offset: Offset(10,12)
                              ),]
                          ),

                        ),
                      ),
                      Positioned(
                        left: 0,right: 0,bottom: 4,
                        child: Container(

                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(

                                child: ParagraphText(text: data['title']??data['name'],
                                  fontSize: 12,
                                  fontFamily: 'medium',
                                  maxline: 2,

                                ),
                              ),
                              if(data['imdbRating']!=null)
                              Row(
                                children: [
                                  ParagraphText(text: 'IMDB : ',
                                    color: MyColors.yellow,
                                    fontSize: 12,
                                    fontFamily: 'bold',
                                  ),

                                  ParagraphText(text: (data['imdbRating']!=0)?(data['imdbRating']/10 ).toString()+'/10':'N/A',
                                    color: MyColors.white,
                                    fontSize: 12,
                                    fontFamily: 'regular',
                                  ),
                                ],
                              ),
                              vSizedBox05,
                              // if(i==0 || i==2 || i==4)
                              if(data['episode_number']==null)
                              Row(
                                children: [
                                  RoundEdgedButton(
                                    text: 'Seen',
                                    isSolid:data['is_seen']==0?true:false,
                                    textColor: Colors.white,
                                    borderRadius: 8,
                                    fontfamily: 'semibold',
                                    width: 60,
                                    horizontalMargin: 0,
                                    horizontalPadding: 0,
                                    verticalPadding: 0,
                                    height: 25,
                                    fontSize: 14,
                                  ), hSizedBox05,
                                  RoundEdgedButton(
                                    text: 'Share',
                                    textColor: Colors.white,
                                    borderRadius: 8,
                                    fontfamily: 'semibold',
                                    width: 60,
                                    horizontalMargin: 0,
                                    horizontalPadding: 0,
                                    verticalPadding: 0,
                                    height: 25,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                              SizedBox(height: 4,)
                            ],
                          ),
                        ),
                      ),
                      Container(  width: MediaQuery.of(context).size.width / 2 - 16,
                        height: 270,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: MyColors.primaryColor,

                          ),
                          borderRadius: BorderRadius.circular(12),),),


                      Positioned(
                          top: 1,
                          left: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 18,
                            height: 220,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [Colors.black.withOpacity(1), Colors.transparent],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.0, 0.50]
                              ),
                            ),
                          )
                      ),
                      if(data['provider_logo']!=null &&data['provider_logo']!='')
                        Positioned(
                          left: 16,
                          top: 16,
                          child: CachedNetworkImage(imageUrl:data['provider_logo'], height: 20,),
                        ),
                    ],
                  ),
                ),




    );
  }
}
