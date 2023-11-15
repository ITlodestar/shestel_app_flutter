import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:livestream/functions/globalFunctions.dart';
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

class UserProfilePage extends StatefulWidget {
  final String id;
  UserProfilePage({
    required this.id,
    Key? key
  }) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>  with SingleTickerProviderStateMixin {
  late TabController tabController;
  Map? user=null;
  List allProviderList1=[];
  int _selectedIndex=0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List myTvWatchList1 = [];
  List mySportsWatchlist1 = [];
  List myMoviesWatchlist1 = [];
  Map? selectedValue;

  bool load = false;
  getMyWatchListResponse({bool clearData = false, String? filterBy, bool movieRefresh = false, bool tvRefresh = false,bool sportsRefresh = false})async{
    if(clearData){
      myTvWatchList1 = [];
      mySportsWatchlist1 = [];
      myMoviesWatchlist1 = [];
    }
    setState(() {
      load = true;
    });


    if(movieRefresh){
      var request = {
        'media_type': {'value': MediaType.movie.name},
        'user_id': {'value': widget.id},
      };

      var jsonResponse = await Webservices.getData('public-profile', request);
      myMoviesWatchlist1 = jsonResponse['data']['media'];
      user = jsonResponse['data'];
      setState(() {});
    }
    if(tvRefresh){
      var request = {
        'media_type': {'value': MediaType.tv.name},
        'user_id': {'value': widget.id},
      };

      var jsonResponse = await Webservices.getData('public-profile', request);
      myTvWatchList1 = jsonResponse['data']['media'];
      setState(() {});
    }
    if(sportsRefresh){
      var request = {
        'media_type': {'value': MediaType.sport.name},
        'user_id': {'value': widget.id},
      };

      var jsonResponse = await Webservices.getData('public-profile', request);
      mySportsWatchlist1 = jsonResponse['data']['media'];
      setState(() {});
    }

    // myTvWatchList = jsonResponse['tv'];
    // mySportsWatchlist = jsonResponse['sport'];
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {

    // user  = user_data;
    tabController=TabController(length: 3, vsync: this);
    // = TabController(length: 3,)
    tabController.addListener(() {
      setState(() {
        _selectedIndex = tabController.index;
      });
      print("Selected Index: " + tabController.index.toString());
    });


    setState(() {
    });
    // TODO: implement initState
    getMyWatchListResponse(movieRefresh: true, tvRefresh: true, sportsRefresh: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    log('the build ${myMoviesWatchlist1}');
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: appBar(
          context: context,
          title: '',
          titlecenter: false,
          titleColor: Colors.white,

          // implyLeading: false,
      ),
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
              color: MyColors.black
          ),
          child: Column(
            children: [
              if(user!=null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    CustomCircularImage(imageUrl: user!['profile']),
                    SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${user!['first_name'].toString().toCapitalize()} ${user!['last_name'].toString().toCapitalize()}", style: TextStyle(color:Colors.white),),
                        Text("${user!['email']}", style: TextStyle(color:Colors.white),),
                        Text("@${user!['username']}", style: TextStyle(color:Colors.white),),


                      ],
                    )
                  ],
                ),
              ),
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
                            child: Text('Movies', style: TextStyle(fontFamily: 'semibold', fontSize: 15),),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('TV', style: TextStyle(fontFamily: 'semibold', fontSize: 15),),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('Sports', style: TextStyle(fontFamily: 'semibold', fontSize: 15),),
                          ),
                        ),
                      ]
                  ),

                ),
              ),

                vSizedBox,

              vSizedBox,
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    myMoviesWatchlist1.length==0?CustomLoader():
                    ListView.builder(
                      itemCount: myMoviesWatchlist1.length,
                      itemBuilder: (context, index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // myMoviesWatchlist[index]['slug'] == 'keep-watching'
                                  ParagraphText(text: '${myMoviesWatchlist1[index]['title']}', fontSize: 16, fontFamily: 'medium',),
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
                                // clipBehavior: Clip.hardEdge,
                                height: 150,

                                child:myMoviesWatchlist1[index]['data'].length==0?Center(child: ParagraphText(text: 'No Data Found')): ListView.builder(
                                    itemCount: myMoviesWatchlist1[index]['data'].length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, horizontalListIndex){
                                      return GestureDetector(
                                        onTap: ()async{
                                          await push(context: context, screen: Details_Page(id: myMoviesWatchlist1[index]['data'][horizontalListIndex]['id'].toString(),details:myMoviesWatchlist1[index]['data'][horizontalListIndex] ,mediaType: MediaType.movie,));
                                          getMyWatchListResponse(movieRefresh: true);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 8),
                                          child: ClipRRect(
                                            // clipBehavior: Clip.hardEdge,
                                            borderRadius: BorderRadius.circular(10),
                                            child: Stack(
                                              clipBehavior: Clip.hardEdge,
                                              children: [
                                                Container(
                                                  // clipBehavior: Clip.hardEdge,
                                                  width: MediaQuery.of(context).size.width / 2 - 24,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      border: Border.all(
                                                        color: MyColors.primaryColor,
                                                      ),
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: CustomCircularImage(
                                                    imageUrl: myMoviesWatchlist1[index]['data'][horizontalListIndex]['url'],

                                                    height: 138,
                                                    width: MediaQuery.of(context).size.width,
                                                    fit: BoxFit.cover,
                                                    borderRadius: 10,
                                                  ),
                                                ),
                                                Positioned(
                                                    top: 1,
                                                    left: 1,
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width / 2 - 26,
                                                      height: 150,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        gradient: LinearGradient(
                                                            colors: [Colors.black.withOpacity(1), Colors.transparent],
                                                            begin: Alignment.topCenter,
                                                            end: Alignment.bottomCenter,
                                                            stops: [0.0, 0.50]
                                                        ),
                                                      ),
                                                    )
                                                ),
                                                if(myMoviesWatchlist1[index]['slug'] == 'keep-watching')
                                                  Positioned(
                                                      bottom: 11,
                                                      left: 1,
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width / 3,
                                                        height: 5,
                                                        decoration: BoxDecoration
                                                          (
                                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
                                                          color:MyColors.primaryColor,
                                                        ),

                                                      )
                                                  ),
                                                if(myMoviesWatchlist1[index]['data'][horizontalListIndex]['provider_logo']!=null &&myMoviesWatchlist1[index]['data'][horizontalListIndex]['provider_logo']!='')
                                                  Positioned(
                                                    left: 16,
                                                    top: 16,
                                                    child: GestureDetector(
                                                      onTap: (){

                                                      },
                                                      child:  Image.network(myMoviesWatchlist1[index]['data'][horizontalListIndex]['provider_logo'], height: 20,),
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
                    mySportsWatchlist1.length==0?CustomLoader():
                    ListView.builder(
                      itemCount: myTvWatchList1.length,
                      itemBuilder: (context, index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ParagraphText(text: '${myTvWatchList1[index]['title']}', fontSize: 16, fontFamily: 'medium',),
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
                                child:myTvWatchList1[index]['data'].length==0?Center(child: ParagraphText(text: 'No Data Found')): ListView.builder(
                                    itemCount: myTvWatchList1[index]['data'].length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, horizontalListIndex){
                                      return GestureDetector(
                                        onTap: ()async{
                                          await push(context: context, screen: Details_Page(id: myTvWatchList1[index]['data'][horizontalListIndex]['id'].toString(),details:myTvWatchList1[index]['data'][horizontalListIndex] ,mediaType: MediaType.tv,));
                                          getMyWatchListResponse(tvRefresh: true);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 8),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width / 2 - 24,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      border: Border.all(
                                                        color: MyColors.primaryColor,
                                                      ),
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: CustomCircularImage(
                                                    imageUrl: myTvWatchList1[index]['data'][horizontalListIndex]['url'],

                                                    height: 138,
                                                    width: MediaQuery.of(context).size.width,
                                                    fit: BoxFit.cover,
                                                    borderRadius: 10,
                                                  ),
                                                ),
                                                Positioned(
                                                    top: 1,
                                                    left: 1,
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width / 2 - 26,
                                                      height: 150,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        gradient: LinearGradient(
                                                            colors: [Colors.black.withOpacity(1), Colors.transparent],
                                                            begin: Alignment.topCenter,
                                                            end: Alignment.bottomCenter,
                                                            stops: [0.0, 0.50]
                                                        ),
                                                      ),
                                                    )
                                                ),
                                                if(myTvWatchList1[index]['data'][horizontalListIndex]['provider_logo']!=null &&myTvWatchList1[index]['data'][horizontalListIndex]['provider_logo']!='')
                                                  Positioned(
                                                    left: 16,
                                                    top: 16,
                                                    child: GestureDetector(
                                                      onTap: (){

                                                      },
                                                      child:  Image.network(myTvWatchList1[index]['data'][horizontalListIndex]['provider_logo'], height: 30,),
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
                    myTvWatchList1.length==0?CustomLoader():
                    ListView.builder(
                      itemCount: mySportsWatchlist1.length,
                      itemBuilder: (context, index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ParagraphText(text: '${mySportsWatchlist1[index]['title']}', fontSize: 16, fontFamily: 'medium',),
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
                                child:mySportsWatchlist1[index]['data'].length==0?Center(child: ParagraphText(text: 'No Data Found')): ListView.builder(
                                    itemCount: mySportsWatchlist1[index]['data'].length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, horizontalListIndex){
                                      return GestureDetector(
                                        onTap: ()async{
                                          await push(context: context, screen: Details_Page(id: mySportsWatchlist1[index]['data'][horizontalListIndex]['id'].toString(),details:mySportsWatchlist1[index]['data'][horizontalListIndex] ,mediaType: MediaType.sport,));
                                          getMyWatchListResponse(sportsRefresh: true);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 8),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width / 2 - 24,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      border: Border.all(
                                                        color: MyColors.primaryColor,
                                                      ),
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: MediaBox(
                                                    data:mySportsWatchlist1[index]['data'][horizontalListIndex],
                                                    onTap: ()async{
                                                      await goDetails(context: context, data:mySportsWatchlist1[index]['data'][horizontalListIndex], mediaType: MediaType.sport);
                                                      // await push(context: context, screen: Details_Page(id: sportsExplorePage[index]['data'][horizontalListIndex]['id'].toString(),details:sportsExplorePage[index]['data'][horizontalListIndex] ,mediaType: MediaType.sport,));

                                                    },

                                                  ),

                                                  // CustomCircularImage(
                                                  //   imageUrl: mySportsWatchlist[index]['data'][horizontalListIndex]['url'],
                                                  //
                                                  //   height: 138,
                                                  //   width: MediaQuery.of(context).size.width,
                                                  //   fit: BoxFit.cover,
                                                  //   borderRadius: 10,
                                                  // ),
                                                ),
                                                Positioned(
                                                    top: 1,
                                                    left: 1,
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width / 2 - 26,
                                                      height: 150,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        gradient: LinearGradient(
                                                            colors: [Colors.black.withOpacity(1), Colors.transparent],
                                                            begin: Alignment.topCenter,
                                                            end: Alignment.bottomCenter,
                                                            stops: [0.0, 0.50]
                                                        ),
                                                      ),
                                                    )
                                                ),
                                                if(mySportsWatchlist1[index]['data'][horizontalListIndex]['provider_logo']!=null &&mySportsWatchlist1[index]['data'][horizontalListIndex]['provider_logo']!='')
                                                  Positioned(
                                                    left: 16,
                                                    top: 16,
                                                    child: GestureDetector(
                                                      onTap: (){

                                                      },
                                                      child:  Image.network(mySportsWatchlist1[index]['data'][horizontalListIndex]['provider_logo'], height: 30,),
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
