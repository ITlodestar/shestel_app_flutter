import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:livestream/constants/global_data.dart';
import 'package:livestream/functions/globalFunctions.dart';
import 'package:livestream/widgets/custom_circular_image.dart';
import 'package:share_plus/share_plus.dart';

import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../functions/navigation_functions.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/appbar.dart';
import '../widgets/buttons.dart';
import '../widgets/customtextfield.dart';
import '../widgets/showSnackbar.dart';
import 'chat_detail.dart';
import 'create_new_group.dart';
class InviteFriends extends StatefulWidget {
  const InviteFriends({Key? key}) : super(key: key);

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  TextEditingController search=TextEditingController();
  ScrollController _controller =
  ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  // int page=1;
  bool loading = false;
  Map searchParams={
    "keywords":{"value":""},
    "page":{"value":"1"},
  };
  List results=[];
  var list = [
    "John Smith",
    "Ryan Dokidis",
    "Jaylon Saris",
    "Alfonso Herwitz",
    "Jakob Levin"
  ];
  var list2 = [
    "Group Name 1",
    "Group Name 2",
    "Group Name 3",
    "Group Name 4",
    "Group Name 5",
    "Group Name 6",
  ];
  var images = [
    MyImages.chat1,
    MyImages.chat2,
    MyImages.chat3,
    MyImages.chat4,
    MyImages.chat5
  ];


  @override
  void initState() {
    // TODO: implement initState
    _controller.addListener(() {
      var isEnd = _controller.offset == _controller.position.maxScrollExtent;

      if (isEnd) {
        print('object-789');
        // log('reach end - '+page.toString());
        // setState(() {
        if (loading == false) {
          print('object-555');

          getUsers();

          //  get_transactions();
        }

        // });
      }
    });

    getUsers();
    super.initState();
  }




  getUsers() async{
    loading = true;
    if(searchParams['keywords']['value'].toString().length>0){
      if((searchParams['keywords']['value'].toString())[0]=='@'){
        searchParams['keywords']['value']=searchParams['keywords']['value'].toString().substring(1);
      }
    }
    setState(() {});
    bool hasNewData=false;
    if(searchParams['page']['value'] == "1"){
      results=[];
    }
    Map res = await Webservices.getData('users-list', searchParams);
    if(res["status"].toString()=='1'){
      loading = false;
      setState(() {});
      if(res["data"].toString()!='null'){

        for(int m=0;m<res["data"]['data'].length;m++){
          hasNewData = true;
          res["data"]["data"][m]['load']=false;
          results.add(res["data"]["data"][m]);
        }


      }

      if(hasNewData==true){
        searchParams['page']['value'] = (int.parse(searchParams['page']['value'])+1).toString();
      }

      setState(() {

      });
    }
    else{

      showSnackbar(res['message']);
      loading = false;
      setState(() {      });
    }
    log("this is response"+res.toString());

  }

  Future<bool> send_invitation(id) async{
    Map params={
      "user_id":{"value":id.toString()}
    };
    Map res = await Webservices.getData('send-invitation', params);
    if(res['status']==1){
      showSnackbar(res['message']);
      return true;
    }
    else{
      return false;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar(context: context, title: 'All Users', titleColor: Colors.white, actions: [
        RoundEdgedButton(
            onTap: () async{
              Share.share(user_data!['first_name'].toString().toCapitalize()+" "+user_data!['last_name'].toString().toCapitalize()+" invited you to join Shestel.\nDownload the mobile application:\n https://shestel.page.link/R6GT");
            },
            height: 30,
            horizontalPadding: 16,
            width: 80,
            verticalPadding: 3,
            verticalMargin: 12,
            fontSize: 13,
            text: "Invite", textColor: MyColors.white)
      ]),
      body: Stack(
        children: [

          ListView(
            controller: _controller,
            children: [
              vSizedBox4,
              vSizedBox4,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    for (var i = 0; i < results.length; i++)
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,

                            padding: EdgeInsets.only(top:8,bottom:8, right:10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1, color: Colors.white30, style: BorderStyle.solid))
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,

                              children: [
                                ClipRRect
                                  (
                                  borderRadius: BorderRadius.circular(50),
                                  child:CustomCircularImage(
                                    imageUrl: results[i]['profile'],
                                    fit: BoxFit.cover,
                                    width:50,
                                    height: 50,
                                  ),
                                ),
                                hSizedBox,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ParagraphText(
                                      text: results[i]['first_name']+" "+results[i]['last_name'],
                                      maxline: 2,
                                      fontSize: 15,
                                      fontFamily: 'medium',
                                      color: MyColors.primaryColor,
                                    ),

                                    ParagraphText(
                                      text: '@'+results[i]['username'],
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          Positioned(
                              right: 0,
                              top:18,
                              child: RoundEdgedButton(

                                load: results[i]['load'],

                                onTap: () async{

                                  if(results[i]['is_friend'].toString()=="0"){
                                    results[i]['load']=true;
                                    setState(() {});

                                    bool res =  await send_invitation(results[i]['id']);
                                    if(res==true){
                                      results[i]['is_friend']=2;
                                    }
                                    results[i]['load']=false;
                                    setState(() {});
                                  }
                                },
                                text:
                                (results[i]['is_friend'].toString()=="0")?'Send Invitation':(results[i]['is_friend'].toString()=="2")?"Request Sent":(results[i]['is_friend'].toString()=="1")?"Friends":"incoming",
                                textColor: Colors.white, height: 29, fontSize: 12, width: (results[i]['is_friend'].toString()=="0" || results[i]['is_friend'].toString()=="2")?120:70, verticalMargin: 0, verticalPadding: 2, horizontalPadding: 5, )
                          ),

                        ],
                      ),
                  ],
                ),
              ),
              if(loading==false)
          SizedBox(height:60),
              if(loading==false && results.length==0)
          Center(child: Padding(
            padding: const EdgeInsets.only(top:100),
            child: ParagraphText(text: "No data found", color: Colors.white,),
          )),

          if(loading==true && searchParams['page']['value'] =="1")
            SizedBox(height:100),


          if(loading==true)
            Center(
              child: Container(
                margin: EdgeInsets.only(top:30),
                height:30,
                width:30,
                child: CircularProgressIndicator(
                  color:MyColors.primaryColor,

                  // radius: 18,
                ),
              ),
            ),

          SizedBox(height:10)
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        textInputAction: TextInputAction.search,
                        controller: search,
                        onChange: (value){
                          if(value==null || value ==''){
                            searchParams["keywords"]["value"]="";

                            searchParams['page']['value']="1";

                            getUsers();
                          }

                        },
                        onSubmitted: (value){
                          searchParams["keywords"]["value"]=search.text;

                          searchParams['page']['value']="1";
                          search.text = value;
                          getUsers();

                          setState(() {

                          });

                        },
                        hintText: 'Search',
                        prefixIcon: MyImages.search,
                        borderradius: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Positioned(
          //     bottom: 8,
          //     right:8,
          //
          //
          //     child: RoundEdgedButton(
          //       onTap: () async{
          //         Share.share(user_data!['first_name'].toString().toCapitalize()+" "+user_data!['last_name'].toString().toCapitalize()+" invited you to join Shestel.\nDownload the mobile application:\n https://shestel.page.link/R6GT");
          //       },
          //       height: 36,
          //         width: 142,
          //         fontSize: 13,
          //         text: "Invite", textColor: MyColors.white)
          // )


        ],
      ),

    );
  }
}
