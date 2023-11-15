import 'package:flutter/material.dart';
import 'package:livestream/constants/image_urls.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/chat_list_page.dart';
import 'package:livestream/pages/detail.dart';
import 'package:livestream/pages/stream_feed_page.dart';
import 'package:livestream/widgets/CustomTexts.dart';
import 'package:livestream/widgets/appbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../constants/colors.dart';
import '../constants/drawer.dart';

class Watchlist_Page extends StatefulWidget {
  const Watchlist_Page({Key? key}) : super(key: key);

  @override
  State<Watchlist_Page> createState() => _Watchlist_PageState();
}

bool isSwitched = false;
bool show = true;
bool hide = false;
bool hideone = false;

class _Watchlist_PageState extends State<Watchlist_Page> {
  final List<String> items = [
    'Netflix',
    'Prime Video',
    'Hulu',
    'Peacock',
    'TV+',
  ];
  String? selectedValue;

  List<Map<String, dynamic>> imgList = [
    {
      "url": 'assets/images/slider.png',
    },
    {
      "url": 'assets/images/img1.jpg',
    },
    {
      "url": 'assets/images/img2.png',
    }
  ];

  List latest = [
    MyImages.movie_one,
    MyImages.movie_two,
    MyImages.movie_three,
    MyImages.movie_four,
    MyImages.movie_five,
    MyImages.movie_six,
  ];
  List logo = [
    MyImages.netflix_logo,
    MyImages.prime,
    MyImages.hulu,
    MyImages.desney,
    MyImages.netflix_logo,
    MyImages.prime,
  ];

  // int _currentIndex = 0;
  TextEditingController search = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        appBar: appBar(
            context: context,
            title: 'Watchlist',
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
              IconButton(
                  onPressed: () {
                    push(context: context, screen: ChatList_Page());
                  },
                  // padding: EdgeInsets.symmetric(horizontal: 5),
                  constraints: BoxConstraints(),
                  // visualDensity: VisualDensity(horizontal: -4),
                  icon: Stack(
                    children: [
                      ImageIcon(
                        AssetImage(MyImages.chat),
                        size: 24,
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              color: MyColors.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: ParagraphText(
                              text: '4',
                              fontSize: 10,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
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
        body: Container(
          decoration: BoxDecoration(
              // image: DecorationImage(
              //     image: AssetImage(MyImages.background_home),
              //     fit: BoxFit.fitWidth,
              //     alignment: Alignment.topLeft
              // ),
              color: MyColors.black),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                show = true;
                                hide = false;
                                hideone = false;
                              });
                            },
                            child: Column(
                              children: [
                                ParagraphText(
                                  text: 'Movies',
                                  fontFamily: show ? 'medium' : 'light',
                                  color: show
                                      ? MyColors.primaryColor
                                      : Colors.white,
                                  fontSize: 16,
                                ),
                                vSizedBox05,
                                // if(show==true)
                                Container(
                                  height: 1,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: show == true
                                          ? MyColors.primaryColor
                                          : Colors.transparent),
                                )
                              ],
                            ),
                          ),
                          hSizedBox4,
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                show = false;
                                hide = true;
                                hideone = false;
                              });
                            },
                            child: Column(
                              children: [
                                ParagraphText(
                                  fontFamily: hide ? 'medium' : 'light',
                                  color: hide
                                      ? MyColors.primaryColor
                                      : Colors.white,
                                  fontSize: 16,
                                  text: 'TV Shows',
                                ),
                                vSizedBox05,
                                // if(hide==true)
                                Container(
                                  height: 1,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: hide == true
                                          ? MyColors.primaryColor
                                          : Colors.transparent),
                                )
                              ],
                            ),
                          ),
                          hSizedBox4,
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                show = false;
                                hide = false;
                                hideone = true;
                              });
                            },
                            child: Column(
                              children: [
                                ParagraphText(
                                  fontFamily: hideone ? 'medium' : 'light',
                                  color: hideone
                                      ? MyColors.primaryColor
                                      : Colors.white,
                                  fontSize: 16,
                                  text: 'Sports',
                                ),
                                vSizedBox05,
                                // if(hide==true)
                                Container(
                                  height: 1,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: hideone == true
                                          ? MyColors.primaryColor
                                          : Colors.transparent),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                vSizedBox2,
                vSizedBox05,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Text(
                            'Filter by provider',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                vSizedBox2,
                if (show)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ParagraphText(
                              text: 'Keep Watching',
                              fontSize: 16,
                              fontFamily: 'medium',
                            ),
                            // GestureDetector(
                            //   onTap: (){
                            //
                            //   },
                            //   child: ParagraphText(
                            //     text: 'See all',
                            //     color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
                            //
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      vSizedBox05,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 150,
                          child: ListView(
                            clipBehavior: Clip.none,
                            // physics: NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Wrap(
                                runSpacing: 16,
                                spacing: 8,
                                direction: Axis.horizontal,
                                children: [
                                  for (var i = 0; i < 5; i++)
                                    GestureDetector(
                                      onTap: () {
                                        push(
                                            context: context,
                                            screen: Details_Page());
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  24,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border.all(
                                                    color:
                                                        MyColors.primaryColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.asset(
                                                      latest[i],
                                                      height: 150,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                                top: 1,
                                                left: 1,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      26,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(1),
                                                          Colors.transparent
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        stops: [0.0, 0.50]),
                                                  ),
                                                )),
                                            Positioned(
                                              left: 16,
                                              top: 16,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Image.asset(
                                                  logo[i],
                                                  height: i == 1
                                                      ? 30
                                                      : i == 2
                                                          ? 15
                                                          : i == 3
                                                              ? 30
                                                              : 20,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: Container(
                                                  height: 4,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          MyColors.primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                )),
                                            // Positioned(
                                            //   right: 10,
                                            //   bottom: 10,
                                            //   child: RoundEdgedButton(
                                            //     text: 'Remove',
                                            //     textColor: Colors.white,
                                            //     minWidth: 68,
                                            //     horizontalPadding: 0,
                                            //     color: MyColors.primaryColor,
                                            //     fontSize: 12,
                                            //     height: 20,
                                            //     verticalPadding: 0,
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      vSizedBox2,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ParagraphText(
                              text: 'Saved to Watchlist',
                              fontSize: 16,
                              fontFamily: 'medium',
                            ),
                            // GestureDetector(
                            //   onTap: (){
                            //
                            //   },
                            //   child: ParagraphText(
                            //     text: 'See all',
                            //     color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
                            //
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      vSizedBox05,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 150,
                          child: ListView(
                            clipBehavior: Clip.none,
                            // physics: NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Wrap(
                                runSpacing: 16,
                                spacing: 8,
                                direction: Axis.horizontal,
                                children: [
                                  for (var i = 0; i < 5; i++)
                                    GestureDetector(
                                      onTap: () {
                                        push(
                                            context: context,
                                            screen: Details_Page());
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  24,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border.all(
                                                    color:
                                                        MyColors.primaryColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.asset(
                                                      latest[i],
                                                      height: 150,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                                top: 1,
                                                left: 1,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      26,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(1),
                                                          Colors.transparent
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        stops: [0.0, 0.50]),
                                                  ),
                                                )),
                                            Positioned(
                                              left: 16,
                                              top: 16,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Image.asset(
                                                  logo[i],
                                                  height: i == 1
                                                      ? 30
                                                      : i == 2
                                                          ? 15
                                                          : i == 3
                                                              ? 30
                                                              : 20,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: Container(
                                                  height: 4,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          MyColors.primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                )),
                                            // Positioned(
                                            //   right: 10,
                                            //   bottom: 10,
                                            //   child: RoundEdgedButton(
                                            //     text: 'Remove',
                                            //     textColor: Colors.white,
                                            //     minWidth: 68,
                                            //     horizontalPadding: 0,
                                            //     color: MyColors.primaryColor,
                                            //     fontSize: 12,
                                            //     height: 20,
                                            //     verticalPadding: 0,
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      vSizedBox2,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ParagraphText(
                              text: 'Movies & TV shows watched',
                              fontSize: 16,
                              fontFamily: 'medium',
                            ),
                            // GestureDetector(
                            //   onTap: (){
                            //
                            //   },
                            //   child: ParagraphText(
                            //     text: 'See all',
                            //     color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
                            //
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      vSizedBox05,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 150,
                          child: ListView(
                            clipBehavior: Clip.none,
                            // physics: NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Wrap(
                                runSpacing: 16,
                                spacing: 8,
                                direction: Axis.horizontal,
                                children: [
                                  for (var i = 0; i < 5; i++)
                                    GestureDetector(
                                      onTap: () {
                                        push(
                                            context: context,
                                            screen: Details_Page());
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  24,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border.all(
                                                    color:
                                                        MyColors.primaryColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.asset(
                                                      latest[i],
                                                      height: 150,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                                top: 1,
                                                left: 1,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      26,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(1),
                                                          Colors.transparent
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        stops: [0.0, 0.50]),
                                                  ),
                                                )),
                                            Positioned(
                                              left: 16,
                                              top: 16,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Image.asset(
                                                  logo[i],
                                                  height: i == 1
                                                      ? 30
                                                      : i == 2
                                                          ? 15
                                                          : i == 3
                                                              ? 30
                                                              : 20,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: Container(
                                                  height: 4,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          MyColors.primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                )),
                                            // Positioned(
                                            //   right: 10,
                                            //   bottom: 10,
                                            //   child: RoundEdgedButton(
                                            //     text: 'Remove',
                                            //     textColor: Colors.white,
                                            //     minWidth: 68,
                                            //     horizontalPadding: 0,
                                            //     color: MyColors.primaryColor,
                                            //     fontSize: 12,
                                            //     height: 20,
                                            //     verticalPadding: 0,
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      vSizedBox2,
                    ],
                  ),
                if (hide)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ParagraphText(
                              text: 'Keep Watching',
                              fontSize: 16,
                              fontFamily: 'medium',
                            ),
                            // GestureDetector(
                            //   onTap: (){
                            //
                            //   },
                            //   child: ParagraphText(
                            //     text: 'See all',
                            //     color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
                            //
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      vSizedBox05,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 150,
                          child: ListView(
                            clipBehavior: Clip.none,
                            // physics: NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Wrap(
                                runSpacing: 16,
                                spacing: 8,
                                direction: Axis.horizontal,
                                children: [
                                  for (var i = 0; i < 5; i++)
                                    GestureDetector(
                                      onTap: () {
                                        push(
                                            context: context,
                                            screen: Details_Page());
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  24,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border.all(
                                                    color:
                                                        MyColors.primaryColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.asset(
                                                      i == 0
                                                          ? latest[2]
                                                          : i == 1
                                                              ? latest[0]
                                                              : latest[i],
                                                      height: 150,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                                top: 1,
                                                left: 1,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      26,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(1),
                                                          Colors.transparent
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        stops: [0.0, 0.50]),
                                                  ),
                                                )),
                                            Positioned(
                                              left: 16,
                                              top: 16,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Image.asset(
                                                  logo[i],
                                                  height: i == 1
                                                      ? 30
                                                      : i == 2
                                                          ? 15
                                                          : i == 3
                                                              ? 30
                                                              : 20,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: Container(
                                                  height: 4,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          MyColors.primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                )),
                                            // Positioned(
                                            //   right: 10,
                                            //   bottom: 10,
                                            //   child: RoundEdgedButton(
                                            //     text: 'Remove',
                                            //     textColor: Colors.white,
                                            //     minWidth: 68,
                                            //     horizontalPadding: 0,
                                            //     color: MyColors.primaryColor,
                                            //     fontSize: 12,
                                            //     height: 20,
                                            //     verticalPadding: 0,
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      vSizedBox2,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ParagraphText(
                              text: 'Saved to Watchlist',
                              fontSize: 16,
                              fontFamily: 'medium',
                            ),
                            // GestureDetector(
                            //   onTap: (){
                            //
                            //   },
                            //   child: ParagraphText(
                            //     text: 'See all',
                            //     color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
                            //
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      vSizedBox05,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 150,
                          child: ListView(
                            clipBehavior: Clip.none,
                            // physics: NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Wrap(
                                runSpacing: 16,
                                spacing: 8,
                                direction: Axis.horizontal,
                                children: [
                                  for (var i = 0; i < 5; i++)
                                    GestureDetector(
                                      onTap: () {
                                        push(
                                            context: context,
                                            screen: Details_Page());
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  24,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border.all(
                                                    color:
                                                        MyColors.primaryColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.asset(
                                                      latest[i],
                                                      height: 150,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                                top: 1,
                                                left: 1,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      26,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(1),
                                                          Colors.transparent
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        stops: [0.0, 0.50]),
                                                  ),
                                                )),
                                            Positioned(
                                              left: 16,
                                              top: 16,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Image.asset(
                                                  logo[i],
                                                  height: i == 1
                                                      ? 30
                                                      : i == 2
                                                          ? 15
                                                          : i == 3
                                                              ? 30
                                                              : 20,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: Container(
                                                  height: 4,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          MyColors.primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                )),
                                            // Positioned(
                                            //   right: 10,
                                            //   bottom: 10,
                                            //   child: RoundEdgedButton(
                                            //     text: 'Remove',
                                            //     textColor: Colors.white,
                                            //     minWidth: 68,
                                            //     horizontalPadding: 0,
                                            //     color: MyColors.primaryColor,
                                            //     fontSize: 12,
                                            //     height: 20,
                                            //     verticalPadding: 0,
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      vSizedBox2,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ParagraphText(
                              text: 'Movies & TV shows watched',
                              fontSize: 16,
                              fontFamily: 'medium',
                            ),
                            // GestureDetector(
                            //   onTap: (){
                            //
                            //   },
                            //   child: ParagraphText(
                            //     text: 'See all',
                            //     color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
                            //
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      vSizedBox05,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 150,
                          child: ListView(
                            clipBehavior: Clip.none,
                            // physics: NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Wrap(
                                runSpacing: 16,
                                spacing: 8,
                                direction: Axis.horizontal,
                                children: [
                                  for (var i = 0; i < 5; i++)
                                    GestureDetector(
                                      onTap: () {
                                        push(
                                            context: context,
                                            screen: Details_Page());
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  24,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border.all(
                                                    color:
                                                        MyColors.primaryColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.asset(
                                                      latest[i],
                                                      height: 150,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                                top: 1,
                                                left: 1,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      26,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(1),
                                                          Colors.transparent
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        stops: [0.0, 0.50]),
                                                  ),
                                                )),
                                            Positioned(
                                              left: 16,
                                              top: 16,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Image.asset(
                                                  logo[i],
                                                  height: i == 1
                                                      ? 30
                                                      : i == 2
                                                          ? 15
                                                          : i == 3
                                                              ? 30
                                                              : 20,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: Container(
                                                  height: 4,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          MyColors.primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                )),
                                            // Positioned(
                                            //   right: 10,
                                            //   bottom: 10,
                                            //   child: RoundEdgedButton(
                                            //     text: 'Remove',
                                            //     textColor: Colors.white,
                                            //     minWidth: 68,
                                            //     horizontalPadding: 0,
                                            //     color: MyColors.primaryColor,
                                            //     fontSize: 12,
                                            //     height: 20,
                                            //     verticalPadding: 0,
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      vSizedBox2,
                    ],
                  ),
                if (hideone)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ParagraphText(
                              text: 'Keep Watching',
                              fontSize: 16,
                              fontFamily: 'medium',
                            ),
                            // GestureDetector(
                            //   onTap: (){
                            //
                            //   },
                            //   child: ParagraphText(
                            //     text: 'See all',
                            //     color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
                            //
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      vSizedBox05,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 150,
                          child: ListView(
                            clipBehavior: Clip.none,
                            // physics: NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Wrap(
                                runSpacing: 16,
                                spacing: 8,
                                direction: Axis.horizontal,
                                children: [
                                  for (var i = 0; i < 5; i++)
                                    GestureDetector(
                                      onTap: () {
                                        push(
                                            context: context,
                                            screen: Details_Page());
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  24,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border.all(
                                                    color:
                                                        MyColors.primaryColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.asset(
                                                      i == 0
                                                          ? latest[3]
                                                          : latest[i],
                                                      height: 150,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                                top: 1,
                                                left: 1,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      26,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(1),
                                                          Colors.transparent
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        stops: [0.0, 0.50]),
                                                  ),
                                                )),
                                            Positioned(
                                              left: 16,
                                              top: 16,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Image.asset(
                                                  logo[i],
                                                  height: i == 1
                                                      ? 30
                                                      : i == 2
                                                          ? 15
                                                          : i == 3
                                                              ? 30
                                                              : 20,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: Container(
                                                  height: 4,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          MyColors.primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                )),
                                            // Positioned(
                                            //   right: 10,
                                            //   bottom: 10,
                                            //   child: RoundEdgedButton(
                                            //     text: 'Remove',
                                            //     textColor: Colors.white,
                                            //     minWidth: 68,
                                            //     horizontalPadding: 0,
                                            //     color: MyColors.primaryColor,
                                            //     fontSize: 12,
                                            //     height: 20,
                                            //     verticalPadding: 0,
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      vSizedBox2,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ParagraphText(
                              text: 'Saved to Watchlist',
                              fontSize: 16,
                              fontFamily: 'medium',
                            ),
                            // GestureDetector(
                            //   onTap: (){
                            //
                            //   },
                            //   child: ParagraphText(
                            //     text: 'See all',
                            //     color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
                            //
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      vSizedBox05,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 150,
                          child: ListView(
                            clipBehavior: Clip.none,
                            // physics: NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Wrap(
                                runSpacing: 16,
                                spacing: 8,
                                direction: Axis.horizontal,
                                children: [
                                  for (var i = 0; i < 5; i++)
                                    GestureDetector(
                                      onTap: () {
                                        push(
                                            context: context,
                                            screen: Details_Page());
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  24,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border.all(
                                                    color:
                                                        MyColors.primaryColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.asset(
                                                      latest[i],
                                                      height: 150,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                                top: 1,
                                                left: 1,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      26,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(1),
                                                          Colors.transparent
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        stops: [0.0, 0.50]),
                                                  ),
                                                )),
                                            Positioned(
                                              left: 16,
                                              top: 16,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Image.asset(
                                                  logo[i],
                                                  height: i == 1
                                                      ? 30
                                                      : i == 2
                                                          ? 15
                                                          : i == 3
                                                              ? 30
                                                              : 20,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: Container(
                                                  height: 4,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          MyColors.primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                )),
                                            // Positioned(
                                            //   right: 10,
                                            //   bottom: 10,
                                            //   child: RoundEdgedButton(
                                            //     text: 'Remove',
                                            //     textColor: Colors.white,
                                            //     minWidth: 68,
                                            //     horizontalPadding: 0,
                                            //     color: MyColors.primaryColor,
                                            //     fontSize: 12,
                                            //     height: 20,
                                            //     verticalPadding: 0,
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      vSizedBox2,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ParagraphText(
                              text: 'Movies & TV shows watched',
                              fontSize: 16,
                              fontFamily: 'medium',
                            ),
                            // GestureDetector(
                            //   onTap: (){
                            //
                            //   },
                            //   child: ParagraphText(
                            //     text: 'See all',
                            //     color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
                            //
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      vSizedBox05,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 150,
                          child: ListView(
                            clipBehavior: Clip.none,
                            // physics: NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Wrap(
                                runSpacing: 16,
                                spacing: 8,
                                direction: Axis.horizontal,
                                children: [
                                  for (var i = 0; i < 5; i++)
                                    GestureDetector(
                                      onTap: () {
                                        push(
                                            context: context,
                                            screen: Details_Page());
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  24,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border.all(
                                                    color:
                                                        MyColors.primaryColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.asset(
                                                      latest[i],
                                                      height: 150,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                                top: 1,
                                                left: 1,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      26,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(1),
                                                          Colors.transparent
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        stops: [0.0, 0.50]),
                                                  ),
                                                )),
                                            Positioned(
                                              left: 16,
                                              top: 16,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Image.asset(
                                                  logo[i],
                                                  height: i == 1
                                                      ? 30
                                                      : i == 2
                                                          ? 15
                                                          : i == 3
                                                              ? 30
                                                              : 20,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: Container(
                                                  height: 4,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          MyColors.primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                )),
                                            // Positioned(
                                            //   right: 10,
                                            //   bottom: 10,
                                            //   child: RoundEdgedButton(
                                            //     text: 'Remove',
                                            //     textColor: Colors.white,
                                            //     minWidth: 68,
                                            //     horizontalPadding: 0,
                                            //     color: MyColors.primaryColor,
                                            //     fontSize: 12,
                                            //     height: 20,
                                            //     verticalPadding: 0,
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      vSizedBox2,
                    ],
                  ),
              ],
            ),
          ),
        ),
        drawer: get_drawer(context));
  }
}
