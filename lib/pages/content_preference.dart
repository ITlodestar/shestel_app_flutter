import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/global_data.dart';
import 'package:livestream/constants/image_urls.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/select_genres.dart';
import 'package:livestream/widgets/CustomTexts.dart';
import 'package:livestream/widgets/appbar.dart';
import 'package:livestream/widgets/buttons.dart';
import 'package:livestream/widgets/customtextfield.dart';
import '../services/webservices.dart';
import '../widgets/content_box.dart';
import 'homepage.dart';

import '../constants/colors.dart';
enum SingingCharacter { lafayette, jefferson }
class Content_Preference_Page extends StatefulWidget {
  final String email;
  final Map selectedServices;
  final Map? socialData;
  const Content_Preference_Page({Key? key,this.socialData, required this.email, required this.selectedServices}) : super(key: key);

  @override
  State<Content_Preference_Page> createState() => _Content_Preference_PageState();
}
bool show = true;
bool hide = false;
bool hideone = false;
bool isSwitched =false;
bool isChecked = false;
bool isdone = false;
int count = 0;
class _Content_Preference_PageState extends State<Content_Preference_Page> {
  SingingCharacter? _character = SingingCharacter.lafayette;
  TextEditingController search = TextEditingController();
 List prefrence=[];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  // getCount(){
  //   count=0;
  //   for(var i=0;i<contentList.length;i++){
  //     if(contentList[i]['checked']==true){
  //       count=count+1;
  //     }
  //   }
  //   setState(() {
  //
  //   });
  // }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: scaffoldKey,
      backgroundColor: Colors.black,
      // appBar: appBar(
      //   context: context,
      //   title: 'Streaming services ',
      //   titleColor: Colors.white,
      //   actions: [
      //     IconButton(onPressed: (){},
      //         icon: Icon(
      //           Icons.notifications,
      //         ),
      //     )
      //   ]
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImages.background_home),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topLeft
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSizedBox6,
                    ParagraphText(text: 'Content Preferences', fontSize: 25, fontFamily: 'semibold',),
                    vSizedBox2,
                    ParagraphText(text: 'Select all that apply',
                      fontSize: 12,),
                    vSizedBox2,
                    // for(var i=0; i<5; i++)
                    for(var i=0;i<contentList.length;i++)
                      ContentBox(
                        title:contentList[i]['name'],
                  checked:contentList[i]['checked'],
                  onChanged: (bool? value) {
                    setState(() {
                      contentList[i]['checked'] = value!;
                      if(value==false){
                        isdone = false;
                      }
                      // getCount();
                    });
                  }
                      ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ParagraphText(text: 'Select All', fontFamily: 'semibold', fontSize: 18, color: MyColors.primaryColor,),
                          Theme(
                            data:  Theme.of(context).copyWith(
                                unselectedWidgetColor: MyColors.primaryColor,
                                backgroundColor: Colors.white
                            ),
                            child:  Checkbox(
                              checkColor: Colors.white,
                              // fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: isdone,
                              activeColor: MyColors.primaryColor,
                              onChanged: (bool? value) {
                                isdone = value!;
                                if(isdone==true){
                                  for(var i=0;i<contentList.length;i++){
                                    contentList[i]['checked']=true;
                                  }
                                }
                                // getCount();
                                setState(() {


                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RoundEdgedButton(
                  text: 'Next',
                  textColor: Colors.white,
                  width: MediaQuery.of(context).size.width - 200,
                  color:  MyColors.primaryColor,
                  onTap: (){
                    // if( isdone3 == true){

                      List g = [];
                      for(var i=0; i<contentList.length;i++){
                        if(contentList[i]['checked']==true){
                          g.add(contentList[i]['slug']);
                        }
                      }

                      // print('chcking content ---'+ g.join(','));
                      push(context: context, screen: Select_Genres_Page(email:widget.email, con: g.join(','), selectedServices: widget.selectedServices, socialData:widget.socialData));


                    // }
                  },

                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
