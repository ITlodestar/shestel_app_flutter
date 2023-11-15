import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/colors.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/functions/globalFunctions.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/chat_detail.dart';
import 'package:livestream/pages/create_new_group.dart';
import 'package:livestream/pages/stream_feed_page.dart';
import 'package:livestream/widgets/CustomTexts.dart';
import 'package:livestream/widgets/appbar.dart';
import 'package:livestream/widgets/buttons.dart';
import '../constants/drawer.dart';
import '../constants/global_data.dart';
import '../services/webservices.dart';
import '../widgets/custom_circular_image.dart';
import '../widgets/showSnackbar.dart';
import '../widgets/unreadCountCircle.dart';
import 'invite.dart';

class ChatList_Page extends StatefulWidget {
  const ChatList_Page({Key? key}) : super(key: key);

  @override
  State<ChatList_Page> createState() => _ChatList_PageState();
}

class _ChatList_PageState extends State<ChatList_Page> {
  String selectedTab = "Chat";
  ScrollController _controller =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  // int page=1;
  bool loading = false;
  Map searchParams = {
    "page": {"value": "1"},
  };
  int groupCount = 0;
  int chatCount = 0;
  List results = [];
  List groups = [];
  @override
  void initState() {
    // TODO: implement initState
    // _controller.addListener(() {
    //   var isEnd = _controller.offset == _controller.position.maxScrollExtent;
    //
    //   if (isEnd) {
    //     print('object-789');
    //     // log('reach end - '+page.toString());
    //     // set State(() {
    //     if (loading == false) {
    //       print('object-555');
    //
    //       getUsers();
    //
    //       //  get_transactions();
    //     }
    //
    //     // });
    //   }
    // });
    groupCount = unreadGroupChatCount;
    chatCount = singleChatCount;
    start();
    // getUsers();
    super.initState();
  }

  start() async {
    await getUsers();
    listenChangesInChat();
  }

  listenChangesInChat() async {
    print("this is nested loop");
    try {
      if(this.mounted)
      setState(() {});
      Future.delayed(Duration(milliseconds: 1000), () async {
        if (groupCount != unreadGroupChatCount && selectedTab == "Group") {
          print("this is loop api called group");
          await getGroups();

          groupCount = unreadGroupChatCount;
        } else if (chatCount != singleChatCount && selectedTab == "Chat") {
          print("this is loop api called chat");
          await getUsers();
          chatCount = singleChatCount;
        } else {}
        listenChangesInChat();
      });
    } catch (e) {}
  }

  Future getUsers() async {
    loading = true;
    if(this.mounted)
    setState(() {});
    bool hasNewData = false;
    if (searchParams['page']['value'] == "1") {
      results = [];
    }
    Map res = await Webservices.getData('my-friends', searchParams);
    if (res["status"].toString() == '1') {
      loading = false;
      if(this.mounted)
      setState(() {});

      if (res["data"].toString() != 'null') {
        for (int m = 0; m < res["data"]['data'].length; m++) {
          hasNewData = true;
          res["data"]["data"][m]['load'] = false;
          print('--------chat-----' + res['data']['data'].toString());
          // results.add(res["data"]["data"][m]);
        }
        results = res["data"]["data"];
      }

      // if(hasNewData==true){
      //   searchParams['page']['value']= (int.parse(searchParams['page']['value'])+1).toString();
      //   // page = page + 1;
      // }
      if(this.mounted)
      setState(() {});
    } else {
      showSnackbar(res['message']);
      loading = false;
      if(this.mounted)
      setState(() {});
    }
    log("this is response" + res.toString());
  }

  Future getGroups() async {
    loading = true;
    if(this.mounted)
    setState(() {});
    bool hasNewData = false;
    if (searchParams['page']['value'] == "1") {
      groups = [];
    }
    Map res = await Webservices.getData('group-list', searchParams);
    if (res["status"].toString() == '1') {
      print('-----------group---------------' + res.toString());
      loading = false;
      if(this.mounted)
      setState(() {});
      if (res["data"].toString() != 'null') {
        for (int m = 0; m < res["data"]['data'].length; m++) {
          hasNewData = true;
          res["data"]["data"][m]['load'] = false;
          groups.add(res["data"]["data"][m]);
        }
      }

      // if(hasNewData==true){
      //   searchParams['page']['value']= (int.parse(searchParams['page']['value'])+1).toString();
      //   // page = page + 1;
      // }
      if(this.mounted)
      setState(() {});
    } else {
      showSnackbar(res['message']);
      loading = false;
      if(this.mounted)
      setState(() {});
    }
    log("this is response" + res.toString());
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      // appBar: appBar(context: context, title: 'My Community', titleColor: Colors.white),
      appBar: appBar(
          context: context,
          title: 'My Community',
          titlecenter: false,
          titleColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: Icon(
              Icons.menu_outlined,
            ),
          ),
          implyLeading: false,
          actions: [
            IconButton(
              visualDensity: VisualDensity(horizontal: -4),
              padding: EdgeInsets.symmetric(horizontal: 5),
              constraints: BoxConstraints(),
              onPressed: () {
                push(context: context, screen: StreamFeed_Page());
              },
              icon: Icon(
                Icons.newspaper_outlined,
              ),
            ),
            // IconButton(
            //     onPressed: (){
            //       push(context: context, screen: ChatList_Page());
            //     },
            //     // padding: EdgeInsets.symmetric(horizontal: 5),
            //     constraints: BoxConstraints(),
            //     // visualDensity: VisualDensity(horizontal: -4),
            //     icon: Stack(
            //       children: [
            //         Icon(
            //           Icons.chat,
            //         ),
            //
            //           Positioned(
            //             right: 0,
            //             child: unreadCircle(type:'allchat'),
            //           )
            //       ],
            //     )
            //
            //
            //
            // ),
            // IconButton(onPressed: (){
            //   push(context: context, screen: ChatList_Page());
            // },
            //     padding: EdgeInsets.symmetric(horizontal: 5),
            //     constraints: BoxConstraints(),
            //     visualDensity: VisualDensity(horizontal: -4),
            //     icon: ImageIcon(
            //       AssetImage(MyImages.chat),
            //       size: 18,
            //     )
            // ),
            // IconButton(onPressed: (){},
            //   visualDensity: VisualDensity(horizontal: -4),
            //   padding: EdgeInsets.symmetric(horizontal: 5),
            //   constraints: BoxConstraints(),
            //   icon: Icon(
            //     Icons.notifications,
            //   ),
            // ),
          ]),
      drawer: get_drawer(context),
      body: Stack(
        children: [
          Column(
            children: [
              vSizedBox2,
              Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.white.withOpacity(0.20)))),
                    ),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if(this.mounted)
                            setState(() {
                              selectedTab = "Chat";
                              searchParams['page']['value'] = "1";
                              getUsers();
                            });
                          },
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ParagraphText(
                                    text: 'Chats',
                                    fontFamily: selectedTab == "Chat"
                                        ? 'medium'
                                        : 'light',
                                    color: selectedTab == "Chat"
                                        ? MyColors.primaryColor
                                        : Colors.white,
                                    fontSize: 16,
                                  ),
                                  unreadCircle(type: 'single')
                                ],
                              ),
                              vSizedBox05,
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: selectedTab == "Chat"
                                        ? MyColors.primaryColor
                                        : Colors.transparent),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if(this.mounted)
                            setState(() {
                              selectedTab = "Group";
                              searchParams['page']['value'] = "1";
                              getGroups();
                            });
                          },
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ParagraphText(
                                    fontFamily: selectedTab != "Chat"
                                        ? 'medium'
                                        : 'light',
                                    color: selectedTab != "Chat"
                                        ? MyColors.primaryColor
                                        : Colors.white,
                                    fontSize: 16,
                                    text: 'Groups',
                                  ),
                                  unreadCircle(type: 'group')
                                ],
                              ),
                              vSizedBox05,
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: selectedTab != "Chat"
                                        ? MyColors.primaryColor
                                        : Colors.transparent),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              vSizedBox2,
              if (selectedTab == "Chat")
                Container(
                  height: MediaQuery.of(context).size.height - 220,
                  // color:Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView(
                    controller: _controller,
                    children: [
                      for (var i = 0; i < results.length; i++)
                        GestureDetector(
                          onTap: () async {
                            await push(
                                context: context,
                                screen: SingleChat(
                                  name: results[i]['first_name']
                                          .toString()
                                          .toCapitalize() +
                                      " " +
                                      results[i]['last_name']
                                          .toString()
                                          .toLowerCase(),
                                  thread_id: results[i]['thread_id'].toString(),
                                  id: results[i]['id'].toString(),
                                ));
                            searchParams['page']['value'] = "1";
                            getUsers();
                          },
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: CustomCircularImage(
                                              imageUrl: results[i]['profile'],
                                              fit: BoxFit.cover,
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                          if (results[i]['online_status']
                                                  .toString() ==
                                              "1")
                                            Positioned(
                                              bottom: 3,
                                              right: 3,
                                              child: Container(
                                                height: 12,
                                                width: 12,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            )
                                        ],
                                      ),
                                      hSizedBox,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ParagraphText(
                                            text: results[i]['first_name']
                                                    .toString()
                                                    .toCapitalize() +
                                                " " +
                                                results[i]['last_name']
                                                    .toString()
                                                    .toLowerCase(),
                                            fontSize: 15,
                                            fontFamily: 'medium',
                                            color: MyColors.primaryColor,
                                          ),
                                          // if(false)
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                100,
                                            child: ParagraphText(
                                              text: results[i]
                                                          ['last_msg_type'] ==
                                                      "text"
                                                  ? results[i]['last_message']
                                                  : results[i][
                                                              'last_msg_type'] ==
                                                          "image"
                                                      ? "Image"
                                                      : results[i][
                                                                  'last_msg_type'] ==
                                                              "movie"
                                                          ? "Movie"
                                                          : results[i][
                                                                      'last_msg_type'] ==
                                                                  "tv"
                                                              ? "TV"
                                                              : "",
                                              fontSize: 12,
                                              fontWeight: (int.parse(results[i]
                                                              ['unread']
                                                          .toString()) >
                                                      0)
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              color: (int.parse(results[i]
                                                              ['unread']
                                                          .toString()) >
                                                      0)
                                                  ? Colors.white
                                                  : Colors.white
                                                      .withOpacity(0.55),
                                            ),
                                          ),
                                          // if(false)
                                          ParagraphText(
                                            text: results[i]['time_ago'] ?? '',
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  if (results[i]['unread'].toString() != "0")
                                    Positioned(
                                      right: 0,
                                      top: 20,
                                      child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Center(
                                              child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 3),
                                            child: ParagraphText(
                                              text: results[i]['unread']
                                                  .toString(),
                                              textAlign: TextAlign.end,
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ))),
                                    )
                                ],
                              ),
                              Divider(
                                height: 30,
                                indent: 60,
                                color: Colors.white.withOpacity(0.30),
                              )
                            ],
                          ),
                        ),
                      if (loading == false) SizedBox(height: 60),
                      if (loading == false && results.length == 0)
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: ParagraphText(
                            text: "No data found",
                            color: Colors.white,
                          ),
                        )),
                      if (loading == true &&
                          searchParams['page']['value'] == "1")
                        SizedBox(height: 100),
                      if (loading == true)
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: MyColors.primaryColor,

                              // radius: 18,
                            ),
                          ),
                        ),
                      SizedBox(height: 10)
                    ],
                  ),
                ),
              if (selectedTab != "Chat")
                Container(
                  height: MediaQuery.of(context).size.height - 200,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView(
                    children: [
                      for (var i = 0; i < groups.length; i++)
                        GestureDetector(
                          onTap: () async {
                            await push(
                                context: context,
                                screen: SingleChat(
                                    name: groups[i]['title']
                                        .toString()
                                        .toCapitalize(),
                                    thread_id: groups[i]['id'].toString(),
                                    created_by:
                                        groups[i]['create_by'].toString()));
                            searchParams['page']['value'] = "1";
                            getGroups();
                            // push(context: context, screen: SingleChat());
                          },
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: CustomCircularImage(
                                          imageUrl: groups[i]['icon'],
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      hSizedBox,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ParagraphText(
                                            text: groups[i]['title'],
                                            fontSize: 15,
                                            fontFamily: 'medium',
                                            color: MyColors.primaryColor,
                                          ),
                                          ParagraphText(
                                            text: groups[i]['memberCount']
                                                    .toString() +
                                                ' Members',
                                            fontSize: 12,
                                            color:
                                                Colors.white.withOpacity(0.55),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  if (groups[i]['unread'].toString() != "0")
                                    Positioned(
                                      right: 0,
                                      top: 20,
                                      child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Center(
                                              child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 3),
                                            child: ParagraphText(
                                              text: groups[i]['unread']
                                                  .toString(),
                                              textAlign: TextAlign.end,
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ))),
                                    )
                                ],
                              ),
                              Divider(
                                height: 30,
                                indent: 60,
                                color: Colors.white.withOpacity(0.30),
                              )
                            ],
                          ),
                        ),
                      if (loading == false) SizedBox(height: 60),
                      if (loading == false && groups.length == 0)
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: ParagraphText(
                            text: "No data found",
                            color: Colors.white,
                          ),
                        )),
                      if (loading == true &&
                          searchParams['page']['value'] == "1")
                        SizedBox(height: 100),
                      if (loading == true)
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: MyColors.primaryColor,

                              // radius: 18,
                            ),
                          ),
                        ),
                      SizedBox(height: 10)
                    ],
                  ),
                ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: selectedTab == "Chat"
                  ? RoundEdgedButton(
                      onTap: () {
                        push(context: context, screen: InviteFriends());
                      },
                      textColor: MyColors.white,
                      text: '+ Invite Friends',
                      minWidth: 130,
                      fontSize: 15,
                      horizontalPadding: 0,
                      verticalPadding: 0,
                      height: 35,
                      borderRadius: 8,
                    )
                  : GestureDetector(
                      onTap: () async {
                        await push(
                            context: context, screen: Create_New_Group_Page());
                        searchParams['page']['value'] = "1";
                        getGroups();
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.add_circle,
                          color: MyColors.primaryColor,
                          size: 50,
                        ),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
