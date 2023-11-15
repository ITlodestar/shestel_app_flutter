import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:livestream/pages/stream_feed_page.dart';
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
import '../widgets/MediaBox.dart';
import '../widgets/appbar.dart';
import '../widgets/unreadCountCircle.dart';
import 'chat_list_page.dart';
import 'detail.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class WatchListPageNew extends StatefulWidget {
  const WatchListPageNew({Key? key}) : super(key: key);

  @override
  State<WatchListPageNew> createState() => _WatchListPageNewState();
}

class _WatchListPageNewState extends State<WatchListPageNew>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  List allProviderList1 = [];
  int _selectedIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> items = [
    'Netflix',
    'Prime Video',
    'Hulu',
    'Peacock',
    'TV+',
  ];
  Map? selectedValue;

  bool load = false;
  getMyWatchListResponse(
      {bool clearData = false,
      String? filterBy,
      bool movieRefresh = false,
      bool tvRefresh = false,
      bool sportsRefresh = false}) async {
    if (clearData) {
      myTvWatchList = [];
      mySportsWatchlist = [];
      myMoviesWatchlist = [];
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
        if (selectedValue!['provider_name'] == "All Providers") {
        } else {
          request['provider'] = {'value': selectedValue!['id'].toString()};
        }
      }
      var jsonResponse = await Webservices.getData('my-watchlist', request);
      myMoviesWatchlist = jsonResponse['data'];
      if (this.mounted) setState(() {});
    }
    if (tvRefresh) {
      var request = {
        'media_type': {'value': MediaType.tv.name},
      };
      if (selectedValue != null) {
        request['provider'] = {'value': selectedValue!['id'].toString()};
      }
      var jsonResponse = await Webservices.getData('my-watchlist', request);
      myTvWatchList = jsonResponse['data'];
      if (this.mounted) setState(() {});
    }
    if (sportsRefresh) {
      var request = {
        'media_type': {'value': MediaType.sport.name},
      };

      var jsonResponse = await Webservices.getData('my-watchlist', request);
      mySportsWatchlist = jsonResponse['data'];
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
    tabController = TabController(length: 3, vsync: this);
    // = TabController(length: 3,)
    tabController.addListener(() {
      if (this.mounted)
        setState(() {
          _selectedIndex = tabController.index;
        });
      print("Selected Index: " + tabController.index.toString());
    });
    Map all = {"provider_name": "All Providers"};
    selectedValue = all;
    allProviderList1.add(all);
    allProviderList1.addAll(allProviderList);
    if (this.mounted) setState(() {});
    // TODO: implement initState
    getMyWatchListResponse(
        movieRefresh: true, tvRefresh: true, sportsRefresh: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('the build ${myMoviesWatchlist}');
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
                                  getMyWatchListResponse(
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
                    myMoviesWatchlist.length == 0
                        ? CustomLoader()
                        : ListView.builder(
                            itemCount: myMoviesWatchlist.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // myMoviesWatchlist[index]['slug'] == 'keep-watching'
                                        ParagraphText(
                                          text:
                                              '${myMoviesWatchlist[index]['title']}',
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Container(
                                      // clipBehavior: Clip.hardEdge,
                                      height: 150,

                                      child:
                                          myMoviesWatchlist[index]['data']
                                                      .length ==
                                                  0
                                              ? Center(
                                                  child: ParagraphText(
                                                      text: 'No Data Found'))
                                              : ListView.builder(
                                                  itemCount:
                                                      myMoviesWatchlist[index]
                                                              ['data']
                                                          .length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder: (context,
                                                      horizontalListIndex) {
                                                    return GestureDetector(
                                                      onTap: () async {
                                                        await goDetails(
                                                            context: context,
                                                            data: myMoviesWatchlist[
                                                                        index]
                                                                    ['data'][
                                                                horizontalListIndex],
                                                            mediaType: MediaType
                                                                .movie);
                                                        // await push(context: context, screen: Details_ Page(id: myMoviesWatchlist[index]['data'][horizontalListIndex]['id'].toString(),details:myMoviesWatchlist[index]['data'][horizontalListIndex] ,mediaType: MediaType.movie,));
                                                        getMyWatchListResponse(
                                                            movieRefresh: true);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 8),
                                                        child: ClipRRect(
                                                          // clipBehavior: Clip.hardEdge,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Stack(
                                                            clipBehavior:
                                                                Clip.hardEdge,
                                                            children: [
                                                              Container(
                                                                // clipBehavior: Clip.hardEdge,
                                                                width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2 -
                                                                    24,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                        border: Border
                                                                            .all(
                                                                          color:
                                                                              MyColors.primaryColor,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                child:
                                                                    CustomCircularImage(
                                                                  imageUrl: myMoviesWatchlist[
                                                                              index]
                                                                          [
                                                                          'data']
                                                                      [
                                                                      horizontalListIndex]['url'],
                                                                  height: 138,
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  borderRadius:
                                                                      10,
                                                                ),
                                                              ),
                                                              Positioned(
                                                                  top: 1,
                                                                  left: 1,
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(context).size.width /
                                                                            2 -
                                                                        26,
                                                                    height: 150,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      gradient: LinearGradient(
                                                                          colors: [
                                                                            Colors.black.withOpacity(1),
                                                                            Colors.transparent
                                                                          ],
                                                                          begin: Alignment
                                                                              .topCenter,
                                                                          end: Alignment
                                                                              .bottomCenter,
                                                                          stops: [
                                                                            0.0,
                                                                            0.50
                                                                          ]),
                                                                    ),
                                                                  )),
                                                              if (myMoviesWatchlist[
                                                                          index]
                                                                      [
                                                                      'slug'] ==
                                                                  'keep-watching')
                                                                Positioned(
                                                                    bottom: 11,
                                                                    left: 1,
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3,
                                                                      height: 5,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.only(bottomLeft: Radius.circular(8)),
                                                                        color: MyColors
                                                                            .primaryColor,
                                                                      ),
                                                                    )),
                                                              if (myMoviesWatchlist[index]['data']
                                                                              [
                                                                              horizontalListIndex]
                                                                          [
                                                                          'provider_logo'] !=
                                                                      null &&
                                                                  myMoviesWatchlist[index]
                                                                              [
                                                                              'data'][horizontalListIndex]
                                                                          [
                                                                          'provider_logo'] !=
                                                                      '')
                                                                Positioned(
                                                                  left: 16,
                                                                  top: 16,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap:
                                                                        () {},
                                                                    child: Image
                                                                        .network(
                                                                      myMoviesWatchlist[index]['data']
                                                                              [
                                                                              horizontalListIndex]
                                                                          [
                                                                          'provider_logo'],
                                                                      height:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                    ),
                                  ),
                                  vSizedBox2,
                                ],
                              );
                            },
                          ),
                    mySportsWatchlist.length == 0
                        ? CustomLoader()
                        : ListView.builder(
                            itemCount: myTvWatchList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ParagraphText(
                                          text:
                                              '${myTvWatchList[index]['title']}',
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Container(
                                      height: 150,
                                      child:
                                          myTvWatchList[index]['data'].length ==
                                                  0
                                              ? Center(
                                                  child: ParagraphText(
                                                      text: 'No Data Found'))
                                              : ListView.builder(
                                                  itemCount:
                                                      myTvWatchList[index]
                                                              ['data']
                                                          .length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder: (context,
                                                      horizontalListIndex) {
                                                    return GestureDetector(
                                                      onTap: () async {
                                                        await goDetails(
                                                            context: context,
                                                            data: myTvWatchList[
                                                                        index]
                                                                    ['data'][
                                                                horizontalListIndex],
                                                            mediaType:
                                                                MediaType.tv);
                                                        // await push(context: context, screen: Details _Page(id: myTvWatchList[index]['data'][horizontalListIndex]['id'].toString(),details:myTvWatchList[index]['data'][horizontalListIndex] ,mediaType: MediaType.tv,));
                                                        getMyWatchListResponse(
                                                            tvRefresh: true);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 8),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2 -
                                                                    24,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                        border: Border
                                                                            .all(
                                                                          color:
                                                                              MyColors.primaryColor,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                child:
                                                                    CustomCircularImage(
                                                                  imageUrl: myTvWatchList[
                                                                              index]
                                                                          [
                                                                          'data']
                                                                      [
                                                                      horizontalListIndex]['url'],
                                                                  height: 138,
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  borderRadius:
                                                                      10,
                                                                ),
                                                              ),
                                                              Positioned(
                                                                  top: 1,
                                                                  left: 1,
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(context).size.width /
                                                                            2 -
                                                                        26,
                                                                    height: 150,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      gradient: LinearGradient(
                                                                          colors: [
                                                                            Colors.black.withOpacity(1),
                                                                            Colors.transparent
                                                                          ],
                                                                          begin: Alignment
                                                                              .topCenter,
                                                                          end: Alignment
                                                                              .bottomCenter,
                                                                          stops: [
                                                                            0.0,
                                                                            0.50
                                                                          ]),
                                                                    ),
                                                                  )),
                                                              if (myTvWatchList[index]['data']
                                                                              [
                                                                              horizontalListIndex]
                                                                          [
                                                                          'provider_logo'] !=
                                                                      null &&
                                                                  myTvWatchList[index]
                                                                              [
                                                                              'data'][horizontalListIndex]
                                                                          [
                                                                          'provider_logo'] !=
                                                                      '')
                                                                Positioned(
                                                                  left: 16,
                                                                  top: 16,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap:
                                                                        () {},
                                                                    child: Image
                                                                        .network(
                                                                      myTvWatchList[index]['data']
                                                                              [
                                                                              horizontalListIndex]
                                                                          [
                                                                          'provider_logo'],
                                                                      height:
                                                                          30,
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                    ),
                                  ),
                                  vSizedBox2,
                                ],
                              );
                            },
                          ),
                    myTvWatchList.length == 0
                        ? CustomLoader()
                        : ListView.builder(
                            itemCount: mySportsWatchlist.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ParagraphText(
                                          text:
                                              '${mySportsWatchlist[index]['title']}',
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Container(
                                      height: 270,
                                      child: mySportsWatchlist[index]['data']
                                                  .length ==
                                              0
                                          ? Center(
                                              child: ParagraphText(
                                                  text: 'No Data Found'))
                                          : ListView.builder(
                                              itemCount:
                                                  mySportsWatchlist[index]
                                                          ['data']
                                                      .length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context,
                                                  horizontalListIndex) {
                                                return MediaBox(
                                                  data: mySportsWatchlist[index]
                                                          ['data']
                                                      [horizontalListIndex],
                                                  onTap: () async {
                                                    await goDetails(
                                                        context: context,
                                                        data: mySportsWatchlist[
                                                                index]['data'][
                                                            horizontalListIndex],
                                                        mediaType:
                                                            MediaType.sport);

                                                    // await push(context: context, screen: Details_ Page(id: mySportsWatchlist[index]['data'][horizontalListIndex]['id'].toString(),details:mySportsWatchlist[index]['data'][horizontalListIndex] ,mediaType: MediaType.sport,));
                                                    getMyWatchListResponse(
                                                        sportsRefresh: true);
                                                  },
                                                );

                                                //   GestureDetector(
                                                //   onTap: ()async{
                                                //     await goDetails(context: context, data:mySportsWatchlist[index]['data'][horizontalListIndex], mediaType: MediaType.sport);
                                                //
                                                //     // await push(context: context, screen: Details_ Page(id: mySportsWatchlist[index]['data'][horizontalListIndex]['id'].toString(),details:mySportsWatchlist[index]['data'][horizontalListIndex] ,mediaType: MediaType.sport,));
                                                //     getMyWatchListResponse(sportsRefresh: true);
                                                //   },
                                                //   child: Padding(
                                                //     padding: const EdgeInsets.only(right: 8),
                                                //     child: ClipRRect(
                                                //       borderRadius: BorderRadius.circular(10),
                                                //       child: Stack(
                                                //         children: [
                                                //           Container(
                                                //             width: MediaQuery.of(context).size.width / 2 - 24,
                                                //             decoration: BoxDecoration(
                                                //                 color: Colors.black,
                                                //                 border: Border.all(
                                                //                   color: MyColors.primaryColor,
                                                //                 ),
                                                //                 borderRadius: BorderRadius.circular(10)
                                                //             ),
                                                //             child: CustomCircularImage(
                                                //               imageUrl: mySportsWatchlist[index]['data'][horizontalListIndex]['url'],
                                                //
                                                //               height: 138,
                                                //               width: MediaQuery.of(context).size.width,
                                                //               fit: BoxFit.cover,
                                                //               borderRadius: 10,
                                                //             ),
                                                //           ),
                                                //           Positioned(
                                                //               top: 1,
                                                //               left: 1,
                                                //               child: Container(
                                                //                 width: MediaQuery.of(context).size.width / 2 - 26,
                                                //                 height: 150,
                                                //                 decoration: BoxDecoration(
                                                //                   borderRadius: BorderRadius.circular(10),
                                                //                   gradient: LinearGradient(
                                                //                       colors: [Colors.black.withOpacity(1), Colors.transparent],
                                                //                       begin: Alignment.topCenter,
                                                //                       end: Alignment.bottomCenter,
                                                //                       stops: [0.0, 0.50]
                                                //                   ),
                                                //                 ),
                                                //               )
                                                //           ),
                                                //           if(mySportsWatchlist[index]['data'][horizontalListIndex]['provider_logo']!=null &&mySportsWatchlist[index]['data'][horizontalListIndex]['provider_logo']!='')
                                                //           Positioned(
                                                //             left: 16,
                                                //             top: 16,
                                                //             child: GestureDetector(
                                                //               onTap: (){
                                                //
                                                //               },
                                                //               child:  Image.network(mySportsWatchlist[index]['data'][horizontalListIndex]['provider_logo'], height: 30,),
                                                //             ),
                                                //           ),
                                                //
                                                //
                                                //         ],
                                                //       ),
                                                //     ),
                                                //   ),
                                                // );
                                              }),
                                    ),
                                  ),
                                  vSizedBox2,
                                ],
                              );
                            },
                          )
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
