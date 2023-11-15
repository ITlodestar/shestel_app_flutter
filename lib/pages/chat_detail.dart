import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/auth.dart';
import 'package:livestream/constants/global_data.dart';
import 'package:livestream/constants/image_urls.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/functions/globalFunctions.dart';
import 'package:livestream/widgets/custom_circular_image.dart';
import 'package:livestream/widgets/customtextfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/colors.dart';
import '../functions/image_picker.dart';
import '../functions/navigation_functions.dart';
import '../services/webservices.dart';
import '../widgets/appbar.dart';
import 'create_new_group.dart';
import 'other_profile_page.dart';

class SingleChat extends StatefulWidget {
  final String thread_id;

  final String? id;
  final String name;
  final String? created_by;
  SingleChat({
    required this.name,
    this.id,
    this.created_by,
    required this.thread_id,
    Key? key
  }) : super(key: key);

  @override
  _SingleChatState createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {

  final ScrollController _scroll_controller = ScrollController();
  final ScrollController _scroll_controller_status = ScrollController();
  bool isGroup=false;
  double numLines = 1.0;
  bool seeStatus = false;
  int timeinmilli=1000;
  // Timer? timerC = null;
  String current_user = '';
  bool loading = false;
  bool loadingChat = false;
  List chat_list = [];
  List status_list = [];
  TextEditingController chatController = TextEditingController();
  TextEditingController message = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    // if (timerC != null) {
    //   timerC!.cancel();
    // }

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    if(widget.id==null){
      isGroup=true;
    }
    super.initState();
    // startTimer();
    start();

  }
  start() async{
    current_user = await getCurrentUserId();
    await get_chats(1);
    listenChangesInChat();
  }

  listenChangesInChat() async{
     print("this is nested loop");
     try{
       setState(() {

       });
       Future.delayed(Duration(milliseconds: 1000), () async{
         if(unreadGroupChatCount>0 && isGroup==true){
           print("this is loop api called group");
           await get_chats(0);
         }
         else if(singleChatCount>0 && isGroup==false)
         {

           print("this is loop api called chat");
           await get_chats(0);
         }
         else{

         }
         listenChangesInChat();

       });
     }
     catch(e){

     }
  }
  // startTimer() async {
  //
  //
  //
  //   current_user = await getCurrentUserId();
  //   print("check------current user :$current_user--------created by: ${widget.created_by}");
  //
  //   get_chats(1);
  //   Timer.periodic(const Duration(seconds: 5), (timer) {
  //     print("timer running ------");
  //     timerC = timer;
  //     get_chats(0);
  //   });
  // }

  Future get_chats(k) async {
    print('${chatController.text}');

    Map searchParams = {
      'thread_id': {"value":widget.thread_id},
    };
    if (k == 1) {
     loading=true;
     setState((){});
    }
    Map res = await Webservices.getData('chat-detail', searchParams);
    if (k == 1) {
      loading=false;
      setState((){});
    }
    if (res['status'].toString() == '1') {
      if(isGroup==true){
        unreadGroupChatCount=0;
      }
      else if(isGroup==false)
      {
        singleChatCount=0;
      }
      if (chat_list.length != res['data']['data'].length) {
        chat_list = res['data']['data'];
        setState(() {});

          _scrollDown();

      }
    }
  }
  void _scrollDown() {
    Future.delayed(const Duration(milliseconds: 500), () {
    _scroll_controller.jumpTo(_scroll_controller.position.maxScrollExtent);
    });
  }




  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar(

          context: context,
          title: widget.name.toCapitalize(),
          onTitleTap: (){
            if(isGroup==false){
              push(context: context, screen: UserProfilePage(id:widget.id.toString()));
            }
          },
          titleColor: Colors.white,
          actions: [
            if(widget.created_by.toString()==current_user)
            IconButton(onPressed: () async{
              var m  = await push(context: context, screen: Create_New_Group_Page(group_id:widget.thread_id));
              print('response from create---'+m.toString());
            }, icon: Icon(Icons.edit, color: Colors.white,))
          ]
      ),

      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(16),
            controller: _scroll_controller,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              if(chat_list.length==0 && loading==false)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
                  child: Text("Not data found", textAlign: TextAlign.center, style:TextStyle(color: Colors.white)),
                ),

              if(chat_list.length==0 && loading==true)
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top:100),
                    height:30,
                    width:30,
                    child: CircularProgressIndicator(
                      color:MyColors.primaryColor,

                      // radius: 18,
                    ),
                  ),
                ),
              for(int i=0;i<chat_list.length;i++)
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: (chat_list[i]['sender_id'].toString()==current_user)?MainAxisAlignment.end:MainAxisAlignment.start,
                    children: [
                      if(chat_list[i]['sender_id'].toString()!=current_user)
                      GestureDetector(
                        onTap: (){

                          push(context: context, screen: UserProfilePage(id:chat_list[i]['sender_id'].toString()));
                        },
                          child: CustomCircularImage(imageUrl:chat_list[i]['profile'] ,)),
                      Container(
                        width: MediaQuery.of(context).size.width - 150,
                        margin: chat_list[i]['sender_id'].toString()==current_user?EdgeInsets.only(right: 16):EdgeInsets.only(left: 16),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                            color: chat_list[i]['sender_id'].toString()==current_user?MyColors.primaryColor:Color(0xFFF8F8F8),

                            borderRadius: BorderRadius.only(
                              topLeft: (chat_list[i]['sender_id'].toString()==current_user)?Radius.circular(20):Radius.circular(0),
                              topRight: (chat_list[i]['sender_id'].toString()!=current_user)?Radius.circular(20):Radius.circular(0),
                              bottomRight: Radius.circular(20),
                              bottomLeft:Radius.circular(20),
                            )),

                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if(isGroup)
                                Text(chat_list[i]['first_name'].toString().toCapitalize()+" "+chat_list[i]['last_name'].toString().toLowerCase(), style: TextStyle(
                                  color: chat_list[i]['sender_id'].toString()==current_user?MyColors.white:Color(0xFF000000),
                                  fontWeight: FontWeight.bold

                                ),),
                                if(chat_list[i]['msg_type']=='text')
                                Text(
                                  chat_list[i]['message'],
                                  style: TextStyle(

                                      fontSize: 14, fontFamily: 'light', height: 1.4, fontWeight: FontWeight.w600,
                                      color:(chat_list[i]['sender_id'].toString()==current_user)?Colors.white:Colors.black,
                                  ),
                                ),
                                if(chat_list[i]['msg_type']=='image')
                                  Container(
                                    padding: EdgeInsets.only(top:8),
                                      child: CachedNetworkImage(
                                        // width: double.infinity,

                                          // fit: BoxFit.contain,
                                          imageUrl:chat_list[i]['message'],
                                        // borderRadius: 8,
                                      )),
                                if(chat_list[i]['msg_type']=='movie' || chat_list[i]['msg_type']=='tv')
                                  GestureDetector(
                                    onTap: () async{
                                      print(chat_list[i]['media']);
                                      chat_list[i]['media']['id'] = chat_list[i]['media']['media_id'];
                                      await goDetails(context: context, data:chat_list[i]['media'], mediaType: MediaType.movie);
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(top:8),
                                            child: CachedNetworkImage(
                                              // width: double.infinity,

                                              // fit: BoxFit.contain,
                                              imageUrl:chat_list[i]['media']['url'],
                                              // borderRadius: 8,
                                            )),
                                        Positioned(
                                            bottom:10,
                                            right:10,
                                            child: Icon(Icons.play_arrow, color: Colors.white, size:40)
                                        )
                                      ],
                                    ),
                                  ),
                                if(chat_list[i]['msg_type']=='movie' || chat_list[i]['msg_type']=='tv')
                                  Padding(
                                    padding: const EdgeInsets.only(top:8.0),
                                    child: Text(
                                      chat_list[i]['media']['title'],

                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14, fontFamily: 'light', height: 1.4,
                                        color:(chat_list[i]['sender_id'].toString()==current_user)?Colors.white:Color(0xFE999999),
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:  (chat_list[i]['sender_id'].toString()==current_user)?MainAxisAlignment.start:MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      chat_list[i]['time_ago'],
                                      style: TextStyle(
                                          fontFamily: 'medium',
                                          fontSize: 8,
                                          color: (chat_list[i]['sender_id'].toString()==current_user)?Colors.white:Color(0xFE999999)),
                                    )
                                  ],
                                )
                              ],
                            ),
                            if(chat_list[i]['sender_id'].toString()!=current_user)
                            Positioned(
                              left: -25,
                              top: -10,
                              child: Image.asset(
                                'assets/images/light-traingle.png',
                                width: 20,
                              ),
                            ) else
                              Positioned(
                                  right: -25,
                                  top: -10,
                                  child: Image.asset(
                                    'assets/images/dark-traingle.png',
                                    width: 20,
                                  )
                              )
                          ],
                        ),
                      ),
                      if(chat_list[i]['sender_id'].toString()==current_user)
                        CustomCircularImage(imageUrl:chat_list[i]['profile'] ,),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),

            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                        onTap: () async{
                          File? prfl = await openImagePicker(context,shouldCrop: false);
                          if(prfl!=null){
                            Map param={
                              "thread_id"   :{"value":widget.thread_id},

                              "msg_type"    :{"value":"image"},
                              "is_group"    :{"value":(isGroup)?"1":"0"},
                            };

                            if(isGroup==false){
                              param['receiver_id'] = {"value":widget.id} ;
                            }
                            else{
                              param['receiver_id'] = {"value":"0"} ;
                            }
                            Map files = {
                              "message"     :prfl,
                            };
                            Map res = await Webservices.postData('send-message', param,files);
                            // loadComment = false;
                            // setState(() {   });
                            if(res["status"].toString()=="1"){
                              // message.text="";
                              // getComments();
                            }

                          }
                        },
                        child: Image.asset('assets/images/camera.png')
                    ),
                  ),
                  Expanded(
                      flex: 15,
                      child: Container(
                        // color: Colors.white,
                        child: CustomTextField(
                            height: numLines > 32.0?80:numLines>16?65:45,
                            onChange: (e){

                              final span = TextSpan(text: e);
                              final tp = TextPainter(
                                  text: span, maxLines: 3, textDirection: TextDirection.ltr);
                              tp.layout(maxWidth: MediaQuery.of(context).size.width - 135);
                              print(tp.height);
                              if(tp.height!=numLines){
                                numLines = tp.height;
                                setState(() {

                                });
                              }

                              // int c = '\n'.allMatches(e).length + 1;
                              // print('count------------------'+c.toString());
                              // if(c!=numLines){
                              //   numLines=c;
                              //   setState((){
                              //
                              //   });
                              // }



                            },
                            controller: message,
                            hintText: 'Type a message',
                            maxLines: 3,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (v){
                                  sendTextMessage();
                            },
                            borderradius: 30,
                            suffixIcon:  GestureDetector(
                              onTap: () {
                                sendTextMessage();
                                // loadComment = true;

                              },
                              child: Container(
                                // color:Colors.blue,
                                // padding: EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    loadingChat?Container(
                                      height:20,
                                      width:20 ,
                                      // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                      child: CircularProgressIndicator(
                                        color:MyColors.primaryColor,
                                        // value: 1,

                                        // radius: 18,
                                      ),
                                    ):Image.asset(
                                        MyImages.send,
                                        height: 20,
                                        fit: BoxFit.fitHeight,
                                      ),

                                  ],
                                ),
                              ),
                            ),
                            suffixheight: 25,

                        )
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );




  }
  sendTextMessage()async{
    if(message.text=='')
      return;
    loadingChat = true;
    setState(() {   });
    print("clickeddddd----");

    Map param={
      "thread_id"   :{"value":widget.thread_id},
      "msg_type"    :{"value":"text"},
      "message"     :{"value":message.text},
      "is_group"    :{"value":(isGroup)?"1":"0"},
    };

    if(isGroup==false){
      param['receiver_id'] = {"value":widget.id} ;
    }
    else{
      param['receiver_id'] = {"value":"0"} ;
    }
    Map res = await Webservices.postData('send-message', param,null);
    print('messagge set'+res.toString());
    if(res["status"].toString()=="1"){


      chat_list.add(
          {
            "msg_type":"text",
            "message":message.text,
            "time_ago":"Just Now",
            "sender_id":current_user,
            "first_name":user_data!['first_name'],
            "last_name":user_data!['last_name'],
            "profile":user_data!['profile'],
          }
      );
      setState(() {});
      _scrollDown();

      message.text="";
      // getComments();
    }
    loadingChat = false;
    setState(() {   });
  }


}
