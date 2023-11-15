import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/global_data.dart';
import 'package:livestream/constants/image_urls.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/complete_profile.dart';
import 'package:livestream/widgets/CustomTexts.dart';
import 'package:livestream/widgets/appbar.dart';
import 'package:livestream/widgets/buttons.dart';
import 'package:livestream/widgets/content_box.dart';
import 'package:livestream/widgets/customtextfield.dart';
import '../services/webservices.dart';
import 'homepage.dart';

import '../constants/colors.dart';
enum SingingCharacter { lafayette, jefferson }
class Select_Genres_Page extends StatefulWidget {
  final String email;
  final Map selectedServices;
  final Map? socialData;
  final String con;
  const Select_Genres_Page({Key? key,this.socialData, required this.email, required this.selectedServices, required this.con}) : super(key: key);

  @override
  State<Select_Genres_Page> createState() => _Select_Genres_PageState();
}
bool show = true;
bool hide = false;
bool hideone = false;
bool isSwitched =false;
bool isChecked = false;
bool isdone = false;

class _Select_Genres_PageState extends State<Select_Genres_Page> {
  SingingCharacter? _character = SingingCharacter.lafayette;
  TextEditingController search = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: scaffoldKey,
      backgroundColor: Colors.black,

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
                    ParagraphText(text: 'Genre Preferences', fontSize: 25, fontFamily: 'semibold',),
                    vSizedBox2,
                    hSizedBox,
                    ParagraphText(text: 'Select all that apply', fontSize: 12,),
                    vSizedBox2,
                    // vSizedBox2,
                      Container(
                        height: MediaQuery.of(context).size.height - 260,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for(var i=0; i<genreList.length; i++)
                                ContentBox(title: genreList[i]['name'], onChanged: (bool? value) {
                                  setState(() {
                                    genreList[i]['checked'] = value!;
                                          if(value==false){
                                            isdone = false;
                                          }
                                  });
                                }, checked: genreList[i]['checked'])

                            ],
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: ParagraphText(text: 'Select All', fontFamily: 'semibold', fontSize: 18, color: MyColors.primaryColor,),
                          ),
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
                                setState(() {
                                  isdone = value!;
                                  if(isdone==true){
                                    for(int i=0;i<genreList.length;i++){
                                      genreList[i]['checked']=true;
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    vSizedBox2,

                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RoundEdgedButton(text: 'Next', textColor: Colors.white,
                  width: MediaQuery.of(context).size.width - 200,
                  color: MyColors.primaryColor,
                onTap: (){

                    List g = [];
                    for(var i=0; i<genreList.length;i++){
                      if(genreList[i]['checked']==true){
                        print('chcking genre ---'+ genreList[i].toString());
                        g.add(genreList[i]['tvdb_id']);
                      }
                    }

                    push(context: context, screen: Complete_Profile_Page(email: widget.email,gen: g.join(','), con: widget.con, selectedServices: widget.selectedServices, socialData: widget.socialData,));


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
