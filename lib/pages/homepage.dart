import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/drawer.dart';
import 'package:livestream/constants/image_urls.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/chat_list_page.dart';
import 'package:livestream/pages/search.dart';
import 'package:livestream/pages/see_all.dart';
import 'package:livestream/pages/stream_feed_page.dart';
import 'package:livestream/widgets/CustomTexts.dart';
import 'package:livestream/widgets/appbar.dart';
import 'package:livestream/widgets/customLoader.dart';
import 'package:livestream/widgets/customtextfield.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../constants/colors.dart';
import '../constants/global_data.dart';
import '../services/webservices.dart';
import '../widgets/CoverContainImage.dart';
import '../widgets/MediaBox.dart';
import '../widgets/native_ads.dart';
import '../widgets/unreadCountCircle.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../functions/ad_helper.dart';


class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);



  @override
  State<Home_Page> createState() => _Home_PageState();
}

bool isSwitched =false;
class _Home_PageState extends State<Home_Page> {

  // NativeAd? _ad;
  // NativeAd? _ad2;
  // NativeAd? _ad3;
  //
  //
  // loadAds() async{
  //  await NativeAd(
  //     adUnitId: AdHelper.nativeAdUnitId,
  //     factoryId: 'listTile',
  //     request: AdRequest(),
  //     listener: NativeAdListener(
  //       onAdLoaded: (ad) {
  //         setState(() {
  //             _ad = ad as NativeAd;
  //         });
  //       },
  //       onAdFailedToLoad: (ad, error) {
  //         // Releases an ad resource when it fails to load
  //         ad.dispose();
  //         print('Ad load failed (code=${error.code} message=${error.message})');       },
  //     ),
  //   ).load();
  //
  //  await NativeAd(
  //    adUnitId: AdHelper.nativeAdUnitId,
  //    factoryId: 'listTile',
  //    request: AdRequest(),
  //    listener: NativeAdListener(
  //      onAdLoaded: (ad) {
  //        setState(() {
  //          _ad2 = ad as NativeAd;
  //        });
  //      },
  //      onAdFailedToLoad: (ad, error) {
  //        // Releases an ad resource when it fails to load
  //        ad.dispose();
  //        print('Ad load failed (code=${error.code} message=${error.message})');       },
  //    ),
  //  ).load();
  //
  //
  //  await NativeAd(
  //    adUnitId: AdHelper.nativeAdUnitId,
  //    factoryId: 'listTile',
  //    request: AdRequest(),
  //    listener: NativeAdListener(
  //      onAdLoaded: (ad) {
  //        setState(() {
  //          _ad3 = ad as NativeAd;
  //        });
  //      },
  //      onAdFailedToLoad: (ad, error) {
  //        // Releases an ad resource when it fails to load
  //        ad.dispose();
  //        print('Ad load failed (code=${error.code} message=${error.message})');       },
  //    ),
  //  ).load();
  // }
  ValueNotifier<int> _currentIndexValueNotifier = ValueNotifier(0);
  // int _currentIndex = 0;
  TextEditingController search = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool load = false;




  getAllData() async{
    if(this.mounted)
    setState((){
      load = true;
    });
    Map res = await Webservices.getData('home-page-data', {});
    if (res['status'].toString() == "1") { //user is new need to signup
      log(res.toString());
      // for (var i = 0; i < res['data'].length; i++) {
      //   res['data'][i]['checked'] = false;
      // }
      homePageData = res['data'];
      if(this.mounted)
      setState((){
        load = false;
      });
    }

    Future.delayed(const Duration(milliseconds: 5000), () {
      if(this.mounted)
      setState(() {

      });
      // _scrollDown();
    });
  }


  @override
  void initState() {
    // TODO: implement initState

    // loadAds();
    getAllData();
    updateHomeData();
    super.initState();
  }
  updateHomeData(){
    Future.delayed(const Duration(milliseconds: 1000), () {
      if(changed_country==true){
        try{
          if(this.mounted){
            setState(() {

            });
            changed_country=false;
          }

        }
        catch(e){

        }
      }
      updateHomeData();
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: scaffoldKey,
      backgroundColor: Colors.black,
        appBar: appBar(
            context: context,
            title: 'Home',
            titlecenter: false,
            titleColor: Colors.white,
            leading: GestureDetector(
              onTap: (){
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
                onPressed: (){
                  push(context: context, screen: StreamFeed_Page());
                },
                icon:Icon(
                  Icons.newspaper_outlined,
                ),
              ),
              // IconButton(
              //     onPressed: (){
              //   push(context: context, screen: ChatList_Page());
              // },
              //     // padding: EdgeInsets.symmetric(horizontal: 5),
              //     constraints: BoxConstraints(),
              //     // visualDensity: VisualDensity(horizontal: -4),
              //     icon: Stack(
              //       children: [
              //         Icon(
              //           Icons.chat,
              //         ),
              //         // if(unreadChatCount>0)
              //            Positioned(
              //           right: 0,
              //           child: unreadCircle(type:'allchat'),
              //         )
              //       ],
              //     )
              //
              //
              //
              // ),

            ]
        ),
      body: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage(MyImages.background_home),
          //     fit: BoxFit.fitWidth,
          //     alignment: Alignment.topLeft
          // ),
          color: Colors.black
        ),
        child:load && homePageData.length==0?CustomLoader(): SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      30
                      // topLeft: Radius.circular(4),
                      // bottomLeft: Radius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap:(){
                              push(context: context, screen: SearchPage(filter:false));
                            },
                            child: CustomTextField(
                              controller: search,
                              enabled:false,
                              hintText: 'Search',
                              prefixIcon: MyImages.search,
                              borderradius: 0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            push(context: context, screen: SearchPage(filter:true));
                          },
                            child: Image.asset(
                              MyImages.filter, height: 45,)
                        )
                      ],
                    ),
                  ),
                ),
              ),

            for(int i=0;i<homePageData.length;i++)
              Column(
                children: [
                       if (i>1)
                         NativeAds(),
                  (homePageData[i]['slug']=='in-theater-movie')?
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        vSizedBox,
                        vSizedBox05,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ParagraphText(text: homePageData[i]['title'], fontSize: 20,
                            fontFamily: 'semibold',
                          ),
                        ),
                        vSizedBox,
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: 213,
                                  autoPlay:true,
                                  viewportFraction: 1,
                                  autoPlayInterval: Duration(milliseconds:3000),
                                  initialPage: 0,
                                  enlargeCenterPage: false,
                                  disableCenter: true,
                                  reverse: false,
                                  enableInfiniteScroll: true,
                                  // pauseAutoPlayOnTouch: Duration(seconds: 10),
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (index, reason) {
                                    _currentIndexValueNotifier.value=index;
                                    // setState(
                                    //       () {
                                    //     _currentIndex = index;
                                    //   },
                                    // );
                                  },
                                ),
                                items: homePageData[i]['data'].map <Widget>((img){
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              goDetails(context: context, data:img, mediaType: MediaType.movie);
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(0),
                                              child: CoverContainImage(
                                                borderRadius: 0,
                                                imageUrl:img['url'],

                                                width: MediaQuery.of(context).size.width,
                                                height: 213,
                                              ),
                                            ),
                                          ),
                                          if(img['provider_logo']!=null &&img['provider_logo']!='')
                                          Positioned(
                                            right: 16,
                                            top: 16,
                                            child: GestureDetector(
                                              onTap: (){

                                              },
                                              child: Image.network(img['provider_logo'], height: 40,),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            Positioned(
                              bottom: 10,

                              child: ValueListenableBuilder<int>(
                                valueListenable: _currentIndexValueNotifier,
                                builder: (context,value,child) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    // height: 250,
                                    margin: EdgeInsets.only(top: 10),
                                    child: Center(
                                      child:  AnimatedSmoothIndicator(
                                        activeIndex: value,
                                        count:  homePageData[i]['data'].length,
                                        effect: ExpandingDotsEffect(
                                          // activeStrokeWidth: 2.6,
                                          // activeDotScale: 1.3,
                                          // maxVisibleDots: 5,
                                          radius: 8,
                                          spacing: 6,
                                          dotHeight: 8,
                                          dotWidth: 8,
                                          activeDotColor: MyColors.primaryColor,
                                          dotColor: Color(0xFFf1f1f1),

                                        ),
                                      ),
                                    ),
                                  );
                                }
                              ),
                            ),

                          ],
                        ),
                        vSizedBox2,
                      ]
                  ):
                  (homePageData[i]['slug']=='coming-soon-movie')?
                  Container():
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children:[
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 16),
                  //       child: CachedNetworkImage(imageUrl:contentList[i]['data'][0]['url']),
                  //     ),
                  //     // Add Section
                  //     vSizedBox2,
                  //   ]
                  // ):
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ParagraphText(text: homePageData[i]['title'], fontSize: 16, fontFamily: 'medium',),
                            GestureDetector(
                              onTap: (){

                                push(context: context, screen: SeeAllPage(heading:homePageData[i]['title'], slug:homePageData[i]['slug'], media_type: MediaType.movie,));
                              },
                              child: ParagraphText(
                                text: 'See all',
                                color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',

                              ),
                            )
                          ],
                        ),
                      ),
                      vSizedBox05,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 270,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for(var j=0; j<homePageData[i]['data'].length; j++)
                                MediaBox(
                                  data:homePageData[i]['data'][j],
                                  onTap: () async {
                                    goDetails(context: context, data:homePageData[i]['data'][j], mediaType: MediaType.movie);

                                  },

                                ),

                            ],
                          ),
                        ),
                      ),
                      vSizedBox2,
                    ]
                  ),
                ],
              ),

              vSizedBox2,
            ],
          ),
        ),
      ),
        drawer: get_drawer(context)
    );
  }
}
