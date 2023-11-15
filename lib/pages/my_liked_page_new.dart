import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:livestream/pages/stream_feed_page.dart';
import 'package:livestream/widgets/MediaBox.dart';
import 'package:livestream/widgets/customLoader.dart';
import 'package:livestream/widgets/custom_circular_image.dart';

import '../constants/colors.dart';
import '../constants/drawer.dart';
import '../constants/global_data.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../functions/navigation_functions.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/appbar.dart';
import '../widgets/native_ads.dart';
import '../widgets/unreadCountCircle.dart';
import 'chat_list_page.dart';
import 'detail.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class MyLikedPage extends StatefulWidget {
  const MyLikedPage({Key? key}) : super(key: key);

  @override
  State<MyLikedPage> createState() => _MyLikedPageState();
}

class _MyLikedPageState extends State<MyLikedPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  List allProviderList1 = [];
  int _selectedIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  Map? selectedValue;
  final List<String> items = [
    'Netflix',
    'Prime Video',
    'Hulu',
    'Peacock',
    'TV+',
  ];

  bool load = false;
  getMyLikedData(
      {bool clearData = false,
      String? filterBy,
      bool movieRefresh = false,
      bool tvRefresh = false,
      bool sportsRefresh = false}) async {
    if (clearData) {
      myLikedTv = [];
      myLikedSports = [];
      myLikedMovies = [];
    }
    if (this.mounted)
      setState(() {
        load = true;
      });

    if (movieRefresh) {
      var request = {
        'media_type': {'value': MediaType.movie.name},
      };
      if (selectedValue != null) {
        if (selectedValue!['provider_name'] == "All providers") {
        } else {
          request['provider'] = {'value': selectedValue!['id'].toString()};
        }
      }
      Map jsonResponse = await Webservices.getData('my-liked', request);
      myLikedMovies = jsonResponse['data'];
      if (this.mounted) setState(() {});
    }

    if (tvRefresh) {
      var request = {
        'media_type': {'value': MediaType.tv.name},
      };
      if (selectedValue != null) {
        request['provider'] = {'value': selectedValue!['id'].toString()};
      }
      Map jsonResponse = await Webservices.getData('my-liked', request);
      myLikedTv = jsonResponse['data'];
      if (this.mounted) setState(() {});
    }
    if (sportsRefresh) {
      var request = {
        'media_type': {'value': MediaType.sport.name},
      };
      Map jsonResponse = await Webservices.getData('my-liked', request);
      myLikedSports = jsonResponse['data'];
      if (this.mounted) setState(() {});
    }
    // myTvWatchList = jsonResponse['tv'];
    // mySportsWatchlist = jsonResponse['sport'];
    if (this.mounted)
      setState(() {
        load = false;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 3, vsync: this);
    // = TabController(length: 3,)
    tabController.addListener(() {
      if (this.mounted)
        setState(() {
          _selectedIndex = tabController.index;
        });
      print("Selected Index: " + tabController.index.toString());
    });
    Map all = {"provider_name": "All providers"};
    selectedValue = all;
    allProviderList1.add(all);
    allProviderList1.addAll(allProviderList);
    if (this.mounted) setState(() {});
    getMyLikedData(sportsRefresh: true, movieRefresh: true, tvRefresh: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('the build ${myLikedMovies}');
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: appBar(
          context: context,
          title: 'Liked',
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
            //             child:unreadCircle(type:'allchat'),
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
      body: DefaultTabController(
        length: 3,
        child: Container(
          decoration: BoxDecoration(
              // image: DecorationImage(
              //     image: AssetImage(MyImages.background_home),
              //     fit: BoxFit.fitWidth,
              //     alignment: Alignment.topLeft
              // ),
              color: MyColors.black),
          child: Column(
            children: [
              Container(
                height: 50,
                child: Material(
                  color: Colors.transparent,
                  child: TabBar(
                      controller: tabController,
                      labelColor: MyColors.primaryColor,
                      unselectedLabelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: MyColors.primaryColor,
                      labelPadding: EdgeInsets.zero,
                      // indicator: BoxDecoration(
                      //     color: Colors.white
                      // ),
                      tabs: [
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Movies',
                              style: TextStyle(
                                  fontFamily: 'semibold', fontSize: 15),
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'TV',
                              style: TextStyle(
                                  fontFamily: 'semibold', fontSize: 15),
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Sports',
                              style: TextStyle(
                                  fontFamily: 'semibold', fontSize: 15),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              if (_selectedIndex != 2) vSizedBox,
              if (_selectedIndex != 2)
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
                          items: allProviderList1
                              .map((item) =>
                                  DropdownMenuItem<Map<dynamic, dynamic>>(
                                    value: item,
                                    child: Text(
                                      item['provider_name'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          // .toList(),
                          value: selectedValue,
                          onChanged: (Map<dynamic, dynamic>? value) {
                            // print("checking ---"+ value.toString());
                            if (this.mounted)
                              setState(() {
                                if (value != null) {
                                  selectedValue = value;
                                  getMyLikedData(
                                      movieRefresh: true,
                                      tvRefresh: true,
                                      sportsRefresh: true);
                                }
                              });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              vSizedBox,
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    myLikedMovies.length == 0
                        ? load
                            ? CustomLoader()
                            : Center(
                                child: ParagraphText(text: 'No Data Found'))
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: SingleChildScrollView(
                              child: Wrap(
                                runSpacing: 16,
                                spacing: 8,
                                direction: Axis.horizontal,
                                children: [
                                  NativeAds(
                                      padding: EdgeInsets.only(
                                          left: 0, right: 0, top: 5)),
                                  for (var index = 0;
                                      index < myLikedMovies.length;
                                      index++)
                                    GestureDetector(
                                      onTap: () async {
                                        await push(
                                            context: context,
                                            screen: Details_Page(
                                              id: myLikedMovies[index]['id']
                                                  .toString(),
                                              details: myLikedMovies[index],
                                              mediaType: MediaType.movie,
                                            ));
                                        getMyLikedData(movieRefresh: true);
                                      },
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
                                                  color: MyColors.primaryColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    myLikedMovies[index]['url'],
                                                    height: 230,
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
                                                height: 220,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                          if (myLikedMovies[index]
                                                      ['provider_logo'] !=
                                                  null &&
                                              myLikedMovies[index]
                                                      ['provider_logo'] !=
                                                  '')
                                            Positioned(
                                              left: 16,
                                              top: 16,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Image.network(
                                                  myLikedMovies[index]
                                                      ['provider_logo'],
                                                  height: 20,
                                                ),
                                              ),
                                            ),
                                          Positioned(
                                              right: 10,
                                              bottom: 10,
                                              child: Image.asset(
                                                MyImages.liked,
                                                height: 21,
                                              ))
                                        ],
                                      ),
                                    ),
                                  if (myLikedMovies.length > 1)
                                    NativeAds(
                                        padding: EdgeInsets.only(
                                            left: 0, right: 0, bottom: 8)),
                                ],
                              ),
                            ),
                          ),
                    myLikedTv.length == 0
                        ? load
                            ? CustomLoader()
                            : Center(
                                child: ParagraphText(text: 'No Data Found'))
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: SingleChildScrollView(
                              child: Wrap(
                                runSpacing: 16,
                                spacing: 8,
                                direction: Axis.horizontal,
                                children: [
                                  NativeAds(
                                      padding: EdgeInsets.only(
                                          left: 0, right: 0, top: 5)),
                                  for (var index = 0;
                                      index < myLikedTv.length;
                                      index++)
                                    GestureDetector(
                                      onTap: () async {
                                        await push(
                                            context: context,
                                            screen: Details_Page(
                                              id: myLikedTv[index]['id']
                                                  .toString(),
                                              details: myLikedTv[index],
                                              mediaType: MediaType.tv,
                                            ));
                                        getMyLikedData(tvRefresh: true);
                                      },
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
                                                  color: MyColors.primaryColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    myLikedTv[index]['url'],
                                                    height: 230,
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
                                                height: 220,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                          if (myLikedTv[index]
                                                      ['provider_logo'] !=
                                                  null &&
                                              myLikedTv[index]
                                                      ['provider_logo'] !=
                                                  '')
                                            Positioned(
                                              left: 16,
                                              top: 16,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Image.network(
                                                  myLikedTv[index]
                                                      ['provider_logo'],
                                                  height: 20,
                                                ),
                                              ),
                                            ),
                                          Positioned(
                                              right: 10,
                                              bottom: 10,
                                              child: Image.asset(
                                                MyImages.liked,
                                                height: 21,
                                              ))
                                        ],
                                      ),
                                    ),
                                  NativeAds(
                                      padding: EdgeInsets.only(
                                          left: 0, right: 0, bottom: 8)),
                                ],
                              ),
                            ),
                          ),
                    myLikedSports.length == 0
                        ? load
                            ? CustomLoader()
                            : Center(
                                child: ParagraphText(text: 'No Data Found'))
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SingleChildScrollView(
                              child: Wrap(
                                runSpacing: 16,
                                spacing: 8,
                                direction: Axis.horizontal,
                                children: [
                                  NativeAds(
                                      padding: EdgeInsets.only(
                                          left: 0, right: 0, top: 5)),
                                  for (var index = 0;
                                      index < myLikedSports.length;
                                      index++)
                                    MediaBox(
                                      marginRight: (index % 2 == 0) ? 8 : 0,
                                      data: myLikedSports[index],
                                      onTap: () async {
                                        await goDetails(
                                            context: context,
                                            data: myLikedSports[index],
                                            mediaType: MediaType.sport);
                                        // await push(context: context, screen: Details_Page(id: myLikedSports[index]['id'].toString(),details:myLikedSports[index] ,mediaType: MediaType.sport,));
                                        getMyLikedData(sportsRefresh: true);
                                      },
                                      // child: Stack(
                                      //   children: [
                                      //     Container(
                                      //       width: MediaQuery.of(context).size.width / 2 - 24,
                                      //       decoration: BoxDecoration(
                                      //           color: Colors.black,
                                      //           border: Border.all(
                                      //             color: MyColors.primaryColor,
                                      //           ),
                                      //           borderRadius: BorderRadius.circular(10)
                                      //       ),
                                      //       child: Column(
                                      //         crossAxisAlignment: CrossAxisAlignment.start,
                                      //         children: [
                                      //           ClipRRect(
                                      //             borderRadius: BorderRadius.circular(10),
                                      //             child: Image.network(myLikedSports[index]['url'],
                                      //               height: 230,
                                      //               width: MediaQuery.of(context).size.width,
                                      //               fit: BoxFit.cover,
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //     Positioned(
                                      //         top: 1,
                                      //         left: 1,
                                      //         child: Container(
                                      //           width: MediaQuery.of(context).size.width / 2 - 26,
                                      //           height: 220,
                                      //           decoration: BoxDecoration(
                                      //             borderRadius: BorderRadius.circular(10),
                                      //             gradient: LinearGradient(
                                      //                 colors: [Colors.black.withOpacity(1), Colors.transparent],
                                      //                 begin: Alignment.topCenter,
                                      //                 end: Alignment.bottomCenter,
                                      //                 stops: [0.0, 0.50]
                                      //             ),
                                      //           ),
                                      //         )
                                      //     ),
                                      //     if(myLikedSports[index]['provider_logo']!=null &&myLikedSports[index]['provider_logo']!='')
                                      //     Positioned(
                                      //       left: 16,
                                      //       top: 16,
                                      //       child: GestureDetector(
                                      //         onTap: (){
                                      //
                                      //         },
                                      //         child:  Image.network(myLikedSports[index]['provider_logo'], height: 30,),
                                      //       ),
                                      //     ),
                                      //     Positioned(
                                      //         right: 10,
                                      //         bottom: 10,
                                      //         child: Image.asset(MyImages.liked, height: 21,)
                                      //     )
                                      //   ],
                                      // ),
                                    ),
                                  NativeAds(
                                      padding: EdgeInsets.only(
                                          left: 0, right: 0, bottom: 8)),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
