import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:livestream/pages/see_all.dart';
import 'package:livestream/pages/stream_feed_page.dart';
import 'package:livestream/widgets/customLoader.dart';
import 'package:livestream/widgets/custom_circular_image.dart';

import '../constants/colors.dart';
import '../constants/drawer.dart';
import '../constants/global_data.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../functions/ad_helper.dart';
import '../functions/navigation_functions.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/MediaBox.dart';
import '../widgets/appbar.dart';
import '../widgets/native_ads.dart';
import '../widgets/unreadCountCircle.dart';
import 'chat_list_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
  List allProviderList1 = [];
  late TabController tabController;
  int _selectedIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  // NativeAd? _ad;
  // NativeAd? _ad2;
  // NativeAd? _ad3;
  // TabController _controller;

  // TabController _controller = TabController(length: list.length, vsync: this);

  final List<String> items = [
    'Netflix',
    'Prime Video',
    'Hulu',
    'Peacock',
    'TV+',
  ];
  Map? selectedValue;

  bool load = false;

  getExploreResponse(
      {bool clearData = false,
      String? filterBy,
      bool movieRefresh = false,
      bool tvRefresh = false,
      bool sportsRefresh = false}) async {
    if (clearData) {
      tvExplorePage = [];
      sportsExplorePage = [];
      moviesExplorePage = [];
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
        } else if (selectedValue!['provider_name'] == "My Providers") {
          request['provider'] = {'value': ''};
          request['my_provider'] = {'value': getMyproviders()};
          // return;
        } else {
          request['provider'] = {'value': selectedValue!['id'].toString()};
        }
      }
      print('cc checking---' + request.toString());
      var jsonResponse = await Webservices.getData('explore-tab-data', request);

      moviesExplorePage = jsonResponse['data'] ?? [];
      if (this.mounted) setState(() {});
    }
    if (tvRefresh) {
      var request = {
        'media_type': {'value': MediaType.tv.name},
      };
      if (selectedValue != null) {
        if (selectedValue!['provider_name'] == "All Providers") {
        } else if (selectedValue!['provider_name'] == "My Providers") {
          request['provider'] = {'value': ''};
          request['my_provider'] = {'value': getMyproviders()};
          // return;
        } else {
          request['provider'] = {'value': selectedValue!['id'].toString()};
        }
      }
      var jsonResponse = await Webservices.getData('explore-tab-data', request);
      tvExplorePage = jsonResponse['data'];
      if (this.mounted) setState(() {});
    }
    if (sportsRefresh) {
      var request = {
        'media_type': {'value': MediaType.sport.name},
      };
      var jsonResponse = await Webservices.getData('explore-tab-data', request);
      log('sport -----' + jsonResponse.toString());
      sportsExplorePage = jsonResponse['data'];
      if (this.mounted) setState(() {});
    }

    // tvExplorePage = jsonResponse['tv'];
    if (this.mounted)
      setState(() {
        load = false;
      });
  }

  @override
  void initState() {
    // NativeAd(
    //   adUnitId: AdHelper.nativeAdUnitId,
    //   factoryId: 'listTile',
    //   request: AdRequest(),
    //   listener: NativeAdListener(
    //     onAdLoaded: (ad) {
    //       set State(() {
    //         _ad = ad as NativeAd;
    //       });
    //     },
    //     onAdFailedToLoad: (ad, error) {
    //       // Releases an ad resource when it fails to load
    //       ad.dispose();
    //       print('Ad load failed (code=${error.code} message=${error.message})');       },
    //   ),
    // ).load();
    // NativeAd(
    //   adUnitId: AdHelper.nativeAdUnitId,
    //   factoryId: 'listTile',
    //   request: AdRequest(),
    //   listener: NativeAdListener(
    //     onAdLoaded: (ad) {
    //       se tState(() {
    //         _ad2 = ad as NativeAd;
    //       });
    //     },
    //     onAdFailedToLoad: (ad, error) {
    //       // Releases an ad resource when it fails to load
    //       ad.dispose();
    //       print('Ad load failed (code=${error.code} message=${error.message})');       },
    //   ),
    // ).load();
    // NativeAd(
    //   adUnitId: AdHelper.nativeAdUnitId,
    //   factoryId: 'listTile',
    //   request: AdRequest(),
    //   listener: NativeAdListener(
    //     onAdLoaded: (ad) {
    //       set State(() {
    //         _ad3 = ad as NativeAd;
    //       });
    //     },
    //     onAdFailedToLoad: (ad, error) {
    //       // Releases an ad resource when it fails to load
    //       ad.dispose();
    //       print('Ad load failed (code=${error.code} message=${error.message})');       },
    //   ),
    // ).load();
    // TODO: implement initState
    // _controller = TabController(length: list.length, vsync: this);
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
    Map my = {"provider_name": "My Providers"};
    selectedValue = all;
    allProviderList1.add(all);
    allProviderList1.add(my);
    allProviderList1.addAll(allProviderList);
    if (this.mounted) setState(() {});

    getExploreResponse(
        movieRefresh: true, tvRefresh: true, sportsRefresh: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('the build ${moviesExplorePage}');
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: appBar(
          context: context,
          title: 'Explore',
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
              vSizedBox,
              // if(DefaultTabController.of(context)?.index!=2)
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
                                  getExploreResponse(
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
                    moviesExplorePage.length == 0
                        ? CustomLoader()
                        : ListView.builder(
                            itemCount: moviesExplorePage.length,
                            itemBuilder: (context, index) {
                              return (selectedValue == null ||
                                      moviesExplorePage[index]['data'].length >
                                          0)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (index > 0) NativeAds(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // moviesExplorePage[index]['slug'] == 'keep-watching'

                                              ParagraphText(
                                                text:
                                                    '${moviesExplorePage[index]['title']}',
                                                fontSize: 16,
                                                fontFamily: 'medium',
                                              ),
                                              if (moviesExplorePage[index]
                                                      ['slug'] !=
                                                  "recommendation")
                                                GestureDetector(
                                                  onTap: () {
                                                    push(
                                                        context: context,
                                                        screen: SeeAllPage(
                                                          heading:
                                                              moviesExplorePage[
                                                                      index]
                                                                  ['title'],
                                                          slug:
                                                              moviesExplorePage[
                                                                      index]
                                                                  ['slug'],
                                                          media_type:
                                                              MediaType.movie,
                                                        ));
                                                  },
                                                  child: ParagraphText(
                                                    text: 'See all',
                                                    color:
                                                        MyColors.primaryColor,
                                                    fontSize: 16,
                                                    fontFamily: 'medium',
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                        vSizedBox05,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Container(
                                            // clipBehavior: Clip.hardEdge,
                                            height: 270,

                                            child: moviesExplorePage[index]
                                                            ['data']
                                                        .length ==
                                                    0
                                                ? Center(
                                                    child: ParagraphText(
                                                        text: 'No Data Found'))
                                                : ListView.builder(
                                                    itemCount:
                                                        moviesExplorePage[index]
                                                                ['data']
                                                            .length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder: (context,
                                                        horizontalListIndex) {
                                                      return MediaBox(
                                                        data: moviesExplorePage[
                                                                index]['data'][
                                                            horizontalListIndex],
                                                        onTap: () async {
                                                          await goDetails(
                                                              context: context,
                                                              data: moviesExplorePage[
                                                                          index]
                                                                      ['data'][
                                                                  horizontalListIndex],
                                                              mediaType:
                                                                  MediaType
                                                                      .movie);

                                                          // await push(context: context, screen: Details_Page(id: moviesExplorePage[index]['data'][horizontalListIndex]['id'].toString(),details:moviesExplorePage[index]['data'][horizontalListIndex] ,mediaType: MediaType.movie,));
                                                          getExploreResponse(
                                                              movieRefresh:
                                                                  true);
                                                        },
                                                      );
                                                    }),
                                          ),
                                        ),
                                        vSizedBox2,
                                      ],
                                    )
                                  : Container();
                            },
                          ),
                    sportsExplorePage.length == 0
                        ? CustomLoader()
                        : ListView.builder(
                            itemCount: tvExplorePage.length,
                            itemBuilder: (context, index) {
                              return (selectedValue == null ||
                                      tvExplorePage[index]['data'].length > 0)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (index > 0) NativeAds(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ParagraphText(
                                                text:
                                                    '${tvExplorePage[index]['title']}',
                                                fontSize: 16,
                                                fontFamily: 'medium',
                                              ),
                                              if (tvExplorePage[index]
                                                      ['slug'] !=
                                                  "recommendation")
                                                GestureDetector(
                                                  onTap: () {
                                                    push(
                                                        context: context,
                                                        screen: SeeAllPage(
                                                          heading:
                                                              tvExplorePage[
                                                                      index]
                                                                  ['title'],
                                                          slug: tvExplorePage[
                                                              index]['slug'],
                                                          media_type:
                                                              MediaType.tv,
                                                        ));
                                                  },
                                                  child: ParagraphText(
                                                    text: 'See all',
                                                    color:
                                                        MyColors.primaryColor,
                                                    fontSize: 16,
                                                    fontFamily: 'medium',
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                        vSizedBox05,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Container(
                                            height: 270,
                                            child: tvExplorePage[index]['data']
                                                        .length ==
                                                    0
                                                ? Center(
                                                    child: ParagraphText(
                                                        text: 'No Data Found'))
                                                : ListView.builder(
                                                    itemCount:
                                                        tvExplorePage[index]
                                                                ['data']
                                                            .length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder: (context,
                                                        horizontalListIndex) {
                                                      return MediaBox(
                                                          onTap: () async {
                                                            await goDetails(
                                                                context:
                                                                    context,
                                                                data: tvExplorePage[
                                                                            index]
                                                                        ['data']
                                                                    [
                                                                    horizontalListIndex],
                                                                mediaType:
                                                                    MediaType
                                                                        .tv);
                                                            // await push(context: context, screen: Details_Page(id: tvExplorePage[index]['data'][horizontalListIndex]['id'].toString(),details:tvExplorePage[index]['data'][horizontalListIndex] ,mediaType: MediaType.tv,));
                                                            getExploreResponse(
                                                                tvRefresh:
                                                                    true);
                                                          },
                                                          data: tvExplorePage[
                                                                  index]['data']
                                                              [
                                                              horizontalListIndex]);
                                                    }),
                                          ),
                                        ),
                                        vSizedBox2,
                                      ],
                                    )
                                  : Container();
                            },
                          ),
                    tvExplorePage.length == 0
                        ? CustomLoader()
                        : ListView.builder(
                            itemCount: sportsExplorePage.length,
                            itemBuilder: (context, index) {
                              return (selectedValue == null ||
                                      sportsExplorePage[index]['data'].length >
                                          0)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (index > 0) NativeAds(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ParagraphText(
                                                text:
                                                    '${sportsExplorePage[index]['title']}',
                                                fontSize: 16,
                                                fontFamily: 'medium',
                                              ),
                                              if (sportsExplorePage[index]
                                                      ['slug'] !=
                                                  "recommendation")
                                                GestureDetector(
                                                  onTap: () {
                                                    push(
                                                        context: context,
                                                        screen: SeeAllPage(
                                                          heading:
                                                              sportsExplorePage[
                                                                      index]
                                                                  ['title'],
                                                          slug:
                                                              sportsExplorePage[
                                                                      index]
                                                                  ['slug'],
                                                          media_type:
                                                              MediaType.sport,
                                                        ));
                                                  },
                                                  child: ParagraphText(
                                                    text: 'See all',
                                                    color:
                                                        MyColors.primaryColor,
                                                    fontSize: 16,
                                                    fontFamily: 'medium',
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                        vSizedBox05,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Container(
                                            height: 270,
                                            child: sportsExplorePage[index]
                                                            ['data']
                                                        .length ==
                                                    0
                                                ? Center(
                                                    child: ParagraphText(
                                                        text: 'No Data Found'))
                                                : ListView.builder(
                                                    itemCount:
                                                        sportsExplorePage[index]
                                                                ['data']
                                                            .length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder: (context,
                                                        horizontalListIndex) {
                                                      return MediaBox(
                                                        data: sportsExplorePage[
                                                                index]['data'][
                                                            horizontalListIndex],
                                                        onTap: () async {
                                                          await goDetails(
                                                              context: context,
                                                              data: sportsExplorePage[
                                                                          index]
                                                                      ['data'][
                                                                  horizontalListIndex],
                                                              mediaType:
                                                                  MediaType
                                                                      .sport);
                                                          // await push(context: context, screen: Details_Page(id: sportsExplorePage[index]['data'][horizontalListIndex]['id'].toString(),details:sportsExplorePage[index]['data'][horizontalListIndex] ,mediaType: MediaType.sport,));
                                                          getExploreResponse(
                                                              sportsRefresh:
                                                                  true);
                                                        },
                                                      );
                                                    }),
                                          ),
                                        ),
                                        vSizedBox2,
                                      ],
                                    )
                                  : Container();
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

  String getMyproviders() {
    List streamingList = user_data!['services'];
    Map allP = {};
    for (int i = 0; i < streamingList.length; i++) {
      allP[streamingList[i]['provider_id'].toString()] = true;
    }
    print("checking---" + allP.keys.toList().join(','));
    return allP.keys.toList().join(',');
  }
}
