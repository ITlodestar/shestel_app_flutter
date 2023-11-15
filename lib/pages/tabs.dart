import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/colors.dart';
import 'package:livestream/pages/expore_page.dart';
import 'package:livestream/pages/homepage.dart';
import 'package:livestream/pages/my_liked_page_new.dart';
import 'package:livestream/pages/watchlist_page_new.dart';

import '../constants/auth.dart';
import '../constants/global_data.dart';
import '../functions/dynamiclink.dart';
import '../functions/onesignal.dart';
import '../services/webservices.dart';
import '../widgets/unreadCountCircle.dart';
import 'chat_list_page.dart';

enum InitMode {
  setSource,
  play,
}
class tabs_second_page extends StatefulWidget {
  const tabs_second_page({Key? key}) : super(key: key);

  @override
  _tabs_second_pageState createState() => _tabs_second_pageState();
}

class _tabs_second_pageState extends State<tabs_second_page> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  // AudioPlayer player = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
  InitMode initMode = InitMode.setSource;
  late AnimationController _controller;
  late Animation<double> opacityAnimation;

static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   // StreamFeed_Page(),
  //   Home_Page(),
  //   Recommendation_Page(),
  //   Watchlist_Page(),
  //   Liked_Page(),
  //   // HomePag(),
  //   // Wallet_Page(),
  //   // ChatListPage(),
  //   // Personal_Profile_Page()
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  Future getNotyCount()async{
    var user_id = await getCurrentUserId();
    Map res = await Webservices.getData('unread-count', {"id":{'value':user_id}});
    // log("res-------------${res}");
    NotiCount=int.parse(res['data']['unread-notification'].toString());

    // if(unreadChatCount!=int.parse(res['data']['unread-chat'].toString()))
        // await setSource(AssetSource('noti.mp3'));
    unreadChatCount = int.parse(res['data']['unread-chat'].toString());
    unreadGroupChatCount = int.parse(res['data']['unread-group-chat'].toString());
    singleChatCount = int.parse(res['data']['unread-one-to-one-chat'].toString());


  }
  @override
  void initState() {
    // TODO: implement initState
    // Timer.periodic(new Duration(seconds: 10), (timer) {
    //   debugPrint(timer.tick.toString());
    //
    // });
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    opacityAnimation = CurvedAnimation(
        parent: Tween<double>(begin: 1, end: 0).animate(_controller),
        curve: Curves.easeInOutExpo);

    if(!kIsWeb){
      setNotificationHandler(context);
      initDynamiclinks(context);
    }

    recommendation();
    getNotificationsCount();
    super.initState();
  }

  clear() async{
  }

  // Future<void> setSource(Source source) async {
  //   if (initMode == InitMode.setSource) {
  //     try {
  //       await player.setSource(source);
  //       initMode = InitMode.play;
  //     }
  //     catch(e){
  //       print("error ------ set source  "+ e.toString());
  //     }
  //
  //   } else {
  //     try{
  //     await player.stop();
  //     await player.play(source);
  //   }
  //   catch(e){
  //
  //   print("error ------ play source  "+ e.toString());
  //   }
  //
  //   }
  // }

  getNotificationsCount() async{
    try{
      await getNotyCount();
      Future.delayed(Duration(milliseconds: 3000),(){
        getNotificationsCount();
      });
    }
    catch(e){
      Future.delayed(Duration(milliseconds: 1000),(){
        getNotificationsCount();
      });
    }


  }

  recommendation(){
    // https://developers.shestel.com/api/my-recommendation
    Webservices.getData('my-recommendation', {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: [
              Home_Page(),
              ExplorePage(),
              ChatList_Page(),
              WatchListPageNew(),
              // Liked_Page(),
              MyLikedPage(),
            ].elementAt(_selectedIndex),
          ),

        ],
      ),
      bottomNavigationBar: Container(
        clipBehavior: Clip.none,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: Colors.black,
            border: Border(
                top: BorderSide(
                    color: MyColors.primaryColor,
                    width: 0.5
                )
            )
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          unselectedItemColor: Color(0xFFffffff),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/home.png"),
                color: Color(0xFFffffff),
              ),
              activeIcon:  ImageIcon(
                AssetImage("assets/images/home_active.png"),
                // color: Color(0xFFffffff),
                // size: 30,
              ),

              // activeIcon: Icon(Icons.home, size: 30,color: themecolor,),
              // icon: Icon(Icons.home, size: 30,color: Colors.black,),
              label:'Home',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/recomendation.png"),
                color: Color(0xFFffffff),
              ),
              activeIcon:  ImageIcon(
                AssetImage("assets/images/recomendation_active.png"),
                // color: Color(0xFFffffff),
                // size: 30,
              ),
              // activeIcon: Icon(Icons.home, size: 30,color: themecolor,),
              // icon: Icon(Icons.home, size: 30,color: Colors.black,),
              label:'Explore',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.chat,
                  ),
                  // if(unreadChatCount>0)
                  Positioned(
                    right: -3,
                    top: -3,
                    child: unreadCircle(type:'allchat'),
                  )
                ],
              ),
              // activeIcon:  Stack(
              //   children: [
              //     Icon(
              //       Icons.chat,
              //     ),
              //     // if(unreadChatCount>0)
              //     Positioned(
              //       right: 0,
              //       child: unreadCircle(type:'allchat'),
              //     )
              //   ],
              // ),

              // activeIcon: Icon(Icons.home, size: 30,color: themecolor,),
              // icon: Icon(Icons.home, size: 30,color: Colors.black,),
              label:'Chats',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/Watchlist.png"),
                color: Color(0xFFffffff),
              ),
              activeIcon:  ImageIcon(
                AssetImage("assets/images/Watchlist_active.png"),
                // color: Color(0xFFffffff),
                // size: 30,
              ),

              // activeIcon: Icon(Icons.home, size: 30,color: themecolor,),
              // icon: Icon(Icons.home, size: 30,color: Colors.black,),
              label:'Watchlist',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/heart.png"),
                color: Color(0xFFffffff),
              ),
              activeIcon:  ImageIcon(
                AssetImage("assets/images/heart_active.png"),
                // color: Color(0xFFffffff),
                // size: 30,
              ),

              // activeIcon: Icon(Icons.home, size: 30,color: themecolor,),
              // icon: Icon(Icons.home, size: 30,color: Colors.black,),
              label:'Liked',
              backgroundColor: Colors.white,
            ),

          ],
          currentIndex: _selectedIndex,
          selectedItemColor: MyColors.primaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}