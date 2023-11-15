import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/constans.dart';
import 'package:livestream/constants/image_urls.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/functions/globalFunctions.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/search.dart';
import 'package:livestream/services/api_urls.dart';
import 'package:livestream/widgets/CustomTexts.dart';
import 'package:livestream/widgets/appbar.dart';
import 'package:livestream/widgets/buttons.dart';
import 'package:livestream/widgets/customLoader.dart';
import 'package:livestream/widgets/customtextfield.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:livestream/widgets/showSnackbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/colors.dart';
import '../constants/global_data.dart';
import '../functions/validations.dart';
import '../modals/carousal_item_modal.dart';
import '../services/webservices.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

import '../widgets/CoverContainImage.dart';
import '../widgets/MediaBox.dart';

class Episode_Details_Page extends StatefulWidget {

  Map? details;


  Episode_Details_Page(
      {this.details, Key? key})
      : super(key: key);

  @override
  State<Episode_Details_Page> createState() => _Episode_Details_PageState();
}

class _Episode_Details_PageState extends State<Episode_Details_Page> {
  bool isReadmore = false;
  bool showReadmore = false;

  bool isReadmoreD = false;
  bool showReadmoreD = false;


  bool load = false;
  bool castLoad = true;
  ScrollController scrollController = ScrollController();
  bool loadingLauncher = false;

  double animationBorderRadius = 5;
  double height = 15;
  List allVideos = [];

  List<CarousalItem> carousalItems = [];
  List seasons = [];
  List images = [
    MyImages.vin,
    MyImages.vin2,
    MyImages.vin3,
    MyImages.vin4,
    MyImages.vin,
    MyImages.vin2,
    MyImages.vin3,
    MyImages.vin4,
    MyImages.vin,
    MyImages.vin2,
    MyImages.vin3,
    MyImages.vin4,
  ];
  int _currentIndex = 0;
  TextEditingController search = TextEditingController();
  TextEditingController comment = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    print("check enum--" + widget.details.toString());
    // print("check enum--" + MediaType.movie.name);
    // print("check enum--"+MediaType.movie.);

    carousalItems.add(CarousalItem(
        imageUrl: widget.details?['url'], mediaType: CarousalMediaType.image));
   getAllData();
    super.initState();
  }

  List castMembers = [];
  List directors = [];
  List videos = [];
  List productionCompanies = [];
  List availableOn = [];
  String directorsString = '';
  String productionCompaniesString = '';
  bool saveToWatchlistLoad = false;
  String starringString = '';

  // getCast() async {
  //   setState(() {
  //     castLoad = true;
  //   });
  //
  //   var request = {
  //     'media_id': {'value': '${widget.details!['id'].toString()}'},
  //     // 'media_id': {'value':'499'},
  //     'media_type': {
  //       'value': widget.mediaType.name,
  //     },
  //   };
  //   var jsonResponse = await Webservices.getData('get-media-others', request);
  //   log('the json response is $jsonResponse');
  //   castMembers = jsonResponse['data']['casts'] ?? [];

  //   videos = jsonResponse['data']['videos'];
  //
  //   for (int i = 0; i < videos.length; i++) {
  //     if (i < 2) {
  //       YoutubePlayerController? controller = null;
  //       if (videos[i]['site'] == 'YouTube') {
  //         // controller = YoutubePlayerController(
  //         //
  //         //     initialVideoId: videos[i]['video_key'],
  //         //     flags: const YoutubePlayerFlags(
  //         //       mute: false,
  //         //       autoPlay: true,
  //         //       disableDragSeek: true,
  //         //     )
  //         // );
  //       }
  //       carousalItems.add(CarousalItem(
  //           imageUrl: videos[i]['video_key'],
  //           controller: controller,
  //           mediaType: videos[i]['site'] == 'YouTube'
  //               ? CarousalMediaType.youtubeVideo
  //               : CarousalMediaType.vimeoVideo));
  //     }
  //   }
  //
  //   for (int i = 0; i < castMembers.length; i++) {
  //     if (i < 3) {
  //       starringString += castMembers[i]['original_name'] + '; ';
  //     }
  //   }
  //   if (starringString.length > 3)
  //     starringString = starringString.substring(0, starringString.length - 2);
  //
  //   for (int i = 0; i < directors.length; i++) {
  //     if (i < 100) {
  //       directorsString += directors[i]['name'] + ', ';
  //     }
  //   }
  //   if (directorsString.length > 3)
  //     directorsString =
  //         directorsString.substring(0, directorsString.length - 2);
  //
  //
  //   if (directorsString != null && directorsString != '') {
  //     final span = TextSpan(text: directorsString);
  //     final tp = TextPainter(
  //         text: span, maxLines: 2, textDirection: TextDirection.ltr);
  //     tp.layout(maxWidth: MediaQuery.of(context).size.width - 32);
  //     if (tp.didExceedMaxLines == true) {
  //       showReadmoreD = true;
  //     }
  //     print('did exceed max lines ---- ' + tp.didExceedMaxLines.toString());
  //   }
  //
  //
  //
  //   for (int i = 0; i < productionCompanies.length; i++) {
  //     if (i < 100) {
  //       productionCompaniesString += productionCompanies[i]['name'] + ', ';
  //     }
  //   }
  //   if (productionCompaniesString.length > 3)
  //     productionCompaniesString = productionCompaniesString.substring(
  //         0, productionCompaniesString.length - 2);
  //
  //   setState(() {
  //     castLoad = false;
  //   });
  // }
  //
  getAllData() async {
    setState(() {
      load = true;
    });
    // log('this is widget id ' + widget.id.toString());


    Map res = await Webservices.getData("episode-detail", {
      "media_id": {'value': widget.details!['media_id'].toString()},
      "episode_id": {'value': widget.details!['id'].toString()}
    });
    try {
      setState(() {
        load = false;
      });
    } catch (e) {
      print('Error in catch block ... set state ignore..... $e');
    }
    if (res['status'].toString() == "1") {
      print('detail----------'+res['data'].toString());
      widget.details = res['data'];
      if (res['data']['overview'] != null && res['data']['overview'] != '') {
        final span = TextSpan(text: res['data']['overview']);
        final tp = TextPainter(
            text: span, maxLines: 3, textDirection: TextDirection.ltr);
        tp.layout(maxWidth: MediaQuery.of(context).size.width - 32);
        if (tp.didExceedMaxLines == true) {
          showReadmore = true;
        }
        print('did exceed max lines ---- ' + tp.didExceedMaxLines.toString());
      }
      productionCompanies = res['data']['productionCompany']??[];
      availableOn = res['data']['streaming']??[];
      castMembers = res['data']['casts']??[];
        directors = res['data']['crews']?? [];

        for (int i = 0; i < castMembers.length; i++) {
          if (i < 3) {
            starringString += castMembers[i]['original_name'] + '; ';
          }
        }
        if (starringString.length > 3)
          starringString = starringString.substring(0, starringString.length - 2);

        for (int i = 0; i < directors.length; i++) {
          if (i < 100) {
            directorsString += directors[i]['name'] + ', ';
          }
        }
        if (directorsString.length > 3)
          directorsString =
              directorsString.substring(0, directorsString.length - 2);


        if (directorsString != null && directorsString != '') {
          final span = TextSpan(text: directorsString);
          final tp = TextPainter(
              text: span, maxLines: 2, textDirection: TextDirection.ltr);
          tp.layout(maxWidth: MediaQuery.of(context).size.width - 32);
          if (tp.didExceedMaxLines == true) {
            showReadmoreD = true;
          }
          print('did exceed max lines ---- ' + tp.didExceedMaxLines.toString());
        }
      // seasons =widget.details!['seasons']??[];

      // log("--------------------------------"+widget.details!['seasons'].toString());
      // getCast();

      setState(() {});
    }
  }

  // listenYoutubeVideo() async {
  //   print('hurrayyyyyyy!');
  // }
  BuildContext? mainContext;
  @override
  Widget build(BuildContext context) {
    mainContext=context;
    // return Container();
    // log('eeeeeeeeeee${widget.id}   ${widget.details!['seasons']}');
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: appBar(
        context: context,
        title: 'Details',
        titleColor: Colors.white,
        // leading: GestureDetector(
        //   onTap: (){
        //     scaffoldKey.currentState?.openDrawer();
        //   },
        //   child: Icon(
        //     Icons.menu_outlined,
        //   ),
        // ),
        // implyLeading: false,
        // actions: [
        //   IconButton(onPressed: (){},
        //       icon: Icon(
        //         Icons.notifications,
        //       ),
        //   )
        // ]
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: MyColors.black
              // image: DecorationImage(
              //     image: AssetImage(MyImages.background_home),
              //     fit: BoxFit.fitWidth,
              //     alignment: Alignment.topLeft
              // ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: (widget.details != null)
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 213,
                            viewportFraction: 1,
                            initialPage: 0,
                            enlargeCenterPage: false,
                            disableCenter: true,
                            reverse: false,
                            enableInfiniteScroll: false,
                            // pauseAutoPlayOnTouch: Duration(seconds: 10),
                            scrollDirection: Axis.horizontal,

                            onPageChanged: (index, reason) {
                              _currentIndex = index;
                              carousalItems[index].controller = null;
                              setState(() {});

                              Future.delayed(Duration(milliseconds: 200))
                                  .then((va) {
                                if (carousalItems[index].mediaType ==
                                    CarousalMediaType.youtubeVideo) {
                                  carousalItems[index].controller =
                                      YoutubePlayerController(
                                          initialVideoId:
                                          carousalItems[index]
                                              .imageUrl,
                                          flags: const YoutubePlayerFlags(
                                            mute: false,
                                            autoPlay: true,
                                            disableDragSeek: true,
                                          ));
                                  setState(() {});
                                }
                              });
                            },
                          ),
                          items: carousalItems.map((img) {
                            return Builder(
                              builder: (BuildContext context) {
                                if (img.mediaType ==
                                    CarousalMediaType.image)
                                  return ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(0),
                                    child:
                                    // Stack(
                                    //   children: [
                                    //

                                    CoverContainImage(
                                      imageUrl:img.imageUrl,
                                      width:MediaQuery.of(context).size.width,
                                      borderRadius:0,
                                      height: 213,
                                    )
                                    ,
                                    // Container(
                                    //   height: 213,
                                    //   decoration: BoxDecoration(
                                    //       image: DecorationImage(
                                    //           image: NetworkImage(
                                    //               img.imageUrl),
                                    //           fit: BoxFit.cover,
                                    //           opacity: 0.4)),
                                    //   child: CachedNetworkImage(
                                    //     // color: Colors.transparent,
                                    //     imageUrl: img.imageUrl,
                                    //     // width:
                                    //     // MediaQuery.of(context).size.width,
                                    //     fit: BoxFit.contain,
                                    //     height: 213,
                                    //   ),
                                    // ),

                                    //   ],
                                    // ),
                                  );

                                return Stack(
                                  children: [
                                    if (img.mediaType ==
                                        CarousalMediaType.youtubeVideo)
                                      Container(
                                        height: 168,
                                        decoration: BoxDecoration(
                                            color: Colors.green),
                                        child: (img.controller == null)
                                            ? null
                                            : YoutubePlayer(
                                          controller:
                                          img.controller!,
                                          showVideoProgressIndicator:
                                          true,

                                          // videoProgressIndicatorColor: Colors.amber,
                                          progressColors:
                                          ProgressBarColors(
                                            playedColor:
                                            Colors.amber,
                                            handleColor:
                                            Colors.amberAccent,
                                          ),
                                          onReady: () {
                                            // img.controller!.
                                            // Future.delayed(Duration(seconds: 1)).then()
                                            // img.controller!.play();
                                            // img.controller!.seekTo(Duration(seconds: 1));
                                            // youtubeController.addListener(listenYoutubeVideo);
                                          },
                                        ),
                                      ),
                                    if (img.mediaType ==
                                        CarousalMediaType.vimeoVideo)
                                      Container(
                                        height: 168,
                                        decoration: BoxDecoration(
                                            color: Colors.green),
                                        child: VimeoPlayer(
                                          videoId: img.imageUrl,
                                        ),
                                      ),
                                    // Positioned(
                                    //   left:0,
                                    //     top:0,
                                    //     right:0,
                                    //     child: GestureDetector(
                                    //       onTap:(){
                                    //         // youtubeController.s
                                    //       },
                                    //       child: Container(
                                    //         height: 168,
                                    //           decoration: BoxDecoration(
                                    //               color: Colors.transparent
                                    //           )
                                    //
                                    // ),
                                    //     ))
                                  ],
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          // height: 250,
                          margin: EdgeInsets.only(top: 10),
                          child: Center(
                            child: AnimatedSmoothIndicator(
                              activeIndex: _currentIndex,
                              count: carousalItems.length,
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
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Image.asset(MyImages.play),
                      // ),
                      // if(widget.details?['provider_logo']!=null &&widget.details?['provider_logo']!='')
                      if (availableOn.length > 0)
                        Positioned(
                          right: 16,
                          top: 16,
                          child: GestureDetector(
                            onTap: () {},
                            // child:  Image.network(widget.details!['provider_logo'], height: 30,),
                            child: Image.network(
                              availableOn[0]['logo_path'],
                              height: 30,
                            ),
                          ),
                        ),
                      // Positioned(
                      //   left: 16,
                      //   top: 16,
                      //   child: GestureDetector(
                      //     onTap: (){
                      //
                      //     },
                      //     child: RoundEdgedButton(
                      //       text: 'Seen',
                      //       textColor: Colors.white,
                      //       width: 40,
                      //       horizontalMargin: 0,
                      //       horizontalPadding: 0,
                      //       verticalPadding: 0,
                      //       height: 20,
                      //       fontSize: 12,
                      //
                      //     )
                      //
                      //     ,
                      //   ),
                      // )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [

                            // Image.asset(MyImages.heart_active, height: 20,color: ),
                            hSizedBox05,

                          ],
                        ),
                        // Row(
                        //   children: [
                        //     ParagraphText(
                        //       text: 'IMDB :',
                        //       fontSize: 14,
                        //       fontFamily: 'bold',
                        //       color: MyColors.yellow,
                        //     ),
                        //     if(widget.details !=null)
                        //       if(widget.details!['imdbRating'] !=null)
                        //     ParagraphText(
                        //       text: (widget.details!['imdbRating'] / 10)
                        //           .toString() +
                        //           '/10',
                        //       fontSize: 13,
                        //       fontFamily: 'regular',
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ParagraphText(
                      text: widget.details!['name'],
                      fontSize: 16,
                      fontFamily: 'bold',
                    ),
                  ),

                  vSizedBox,

                  if (!load)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        vSizedBox,
                        if (widget.details?['overview'] != null &&
                            widget.details?['overview'] != '')
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 2.5),
                            child: Text(
                              widget.details?['overview'],
                              style: TextStyle(
                                  fontFamily: 'light',
                                  fontSize: 13,
                                  color: Colors.white),
                              maxLines: isReadmore ? null : 3,
                              overflow: isReadmore
                                  ? TextOverflow.visible
                                  : TextOverflow.ellipsis,
                            ),
                          ),
                        if (showReadmore == true)
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 16, right: 20),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // toggle the bool variable true or false
                                    isReadmore = !isReadmore;
                                  });
                                },
                                child: Text(
                                  (isReadmore
                                      ? 'Read Less'
                                      : 'Read More'),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                        if (widget.details?['overview'] != null &&
                            widget.details?['overview'] != '')
                          SizedBox(height: 10),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            print('names pressed');
                            scrollController.position.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.linear);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2.5),
                            child: RichText(
                              text: TextSpan(
                                text: 'Starring: ',
                                style: TextStyle(
                                    fontFamily: 'light',
                                    fontSize: 13,
                                    color: Colors.white),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '$starringString (See below)',
                                    style:
                                    TextStyle(fontFamily: 'medium'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 2.5),
                          child: RichText(
                            text: TextSpan(
                              text: 'Release date:',
                              style: TextStyle(
                                  fontFamily: 'light',
                                  fontSize: 13,
                                  color: Colors.white),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                    ' ${widget.details!['air_date']}',
                                    style:
                                    TextStyle(fontFamily: 'medium')),
                              ],
                            ),
                          ),
                        ),
                        if (widget.details?['budget'] != '0' &&
                            widget.details?['budget'] != null)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2.5),
                            child: RichText(
                              text: TextSpan(
                                text: 'Budget: ',
                                style: TextStyle(
                                    fontFamily: 'light',
                                    fontSize: 13,
                                    color: Colors.white),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                      '${widget.details?['budget']}',
                                      style: TextStyle(
                                          fontFamily: 'medium')),
                                ],
                              ),
                            ),
                          ),
                        if (widget.details?['revenue'] != '0' &&
                            widget.details?['revenue'] != null)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2.5),
                            child: RichText(
                              text: TextSpan(
                                text: 'Revenue: ',
                                style: TextStyle(
                                    fontFamily: 'light',
                                    fontSize: 13,
                                    color: Colors.white),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                      ' ${widget.details?['revenue']}',
                                      style: TextStyle(
                                          fontFamily: 'medium')),
                                ],
                              ),
                            ),
                          ),
                        if (directorsString != '')
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2.5),
                            child:  Text(
                                'Directors: '+directorsString,
                                maxLines: isReadmoreD ? null : 2,
                                overflow: isReadmoreD
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'light',
                                    fontSize: 13,
                                    color: Colors.white)
                                // children: <TextSpan>[
                                //   TextSpan(
                                //
                                //       text: '${directorsString}',
                                //       style: TextStyle(
                                //           fontFamily: 'medium')),
                                // ],
                              ),

                          ),
                        if (showReadmoreD == true)
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 16, right: 20),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // toggle the bool variable true or false
                                    isReadmoreD = !isReadmoreD;
                                  });
                                },
                                child: Text(
                                  (isReadmoreD
                                      ? 'Read Less'
                                      : 'Read More'),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                        if (productionCompaniesString != '')
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2.5),
                            child: RichText(
                              text: TextSpan(
                                text: 'Production companies:',
                                style: TextStyle(
                                    fontFamily: 'light',
                                    fontSize: 13,
                                    color: Colors.white),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                      ' ${productionCompaniesString}',
                                      style: TextStyle(
                                          fontFamily: 'medium')),
                                ],
                              ),
                            ),
                          ),

                      ],
                    )
                  else
                    Container(
                      height: 150,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0.0, bottom: 10.0, right: 10),
                            child: SkeletonAnimation(
                              borderRadius: BorderRadius.circular(
                                  animationBorderRadius),
                              shimmerColor: Colors.grey,
                              child: Container(
                                height: height,
                                width: MediaQuery.of(context).size.width *
                                    0.9,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        animationBorderRadius),
                                    color: Colors.grey.withOpacity(0.9)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0.0, bottom: 10.0, right: 10),
                            child: SkeletonAnimation(
                              borderRadius: BorderRadius.circular(
                                  animationBorderRadius),
                              shimmerColor: Colors.grey,
                              child: Container(
                                height: height,
                                width: MediaQuery.of(context).size.width *
                                    0.65,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        animationBorderRadius),
                                    color: Colors.grey.withOpacity(0.9)),
                              ),
                            ),
                          ),
                          vSizedBox05,
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0.0, bottom: 10.0, right: 10),
                            child: SkeletonAnimation(
                              borderRadius: BorderRadius.circular(
                                  animationBorderRadius),
                              shimmerColor: Colors.grey,
                              child: Container(
                                height: height,
                                width: MediaQuery.of(context).size.width *
                                    0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        animationBorderRadius),
                                    color: Colors.grey.withOpacity(0.9)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0.0, bottom: 10.0, right: 10),
                            child: SkeletonAnimation(
                              borderRadius: BorderRadius.circular(
                                  animationBorderRadius),
                              shimmerColor: Colors.grey,
                              child: Container(
                                height: height,
                                width: MediaQuery.of(context).size.width *
                                    0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        animationBorderRadius),
                                    color: Colors.grey.withOpacity(0.9)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0.0, bottom: 0.0, right: 10),
                            child: SkeletonAnimation(
                              borderRadius: BorderRadius.circular(
                                  animationBorderRadius),
                              shimmerColor: Colors.grey,
                              child: Container(
                                height: height,
                                width: MediaQuery.of(context).size.width *
                                    0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        animationBorderRadius),
                                    color: Colors.grey.withOpacity(0.9)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // child: Row(
                      //   children: [
                      //     // Expanded(
                      //     //   child: SkeletonAnimation(
                      //     //     shimmerColor: Colors.grey,
                      //     //     borderRadius: BorderRadius.circular(20),
                      //     //     shimmerDuration: 1000,
                      //     //     child: Container(
                      //     //       decoration: BoxDecoration(
                      //     //         color: Colors.grey[300],
                      //     //         borderRadius: BorderRadius.circular(20),
                      //     //         boxShadow: shadowList,
                      //     //       ),
                      //     //       margin: EdgeInsets.only(top: 40),
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //     Expanded(
                      //       child: Container(
                      //         margin: EdgeInsets.only(top: 60, bottom: 20),
                      //         decoration: BoxDecoration(
                      //           color: Colors.black,
                      //           // boxShadow: shadowList,
                      //           borderRadius: BorderRadius.only(
                      //             topRight: Radius.circular(20),
                      //             bottomRight: Radius.circular(20),
                      //           ),
                      //         ),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           mainAxisSize: MainAxisSize.max,
                      //           children: <Widget>[
                      //             Row(
                      //               children: [
                      //                 Padding(
                      //                   padding:
                      //                   const EdgeInsets.only(left: 0.0, bottom: 5.0, right: 10),
                      //                   child: SkeletonAnimation(
                      //                     borderRadius: BorderRadius.circular(animationBorderRadius),
                      //                     shimmerColor:
                      //                     index % 2 != 0 ? Colors.grey : Colors.white54,
                      //                     child: Container(
                      //                       height: 20,
                      //                       width: MediaQuery.of(context).size.width * 0.25,
                      //                       decoration: BoxDecoration(
                      //                           borderRadius: BorderRadius.circular(animationBorderRadius),
                      //                           color: Colors.grey[300]),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 ParagraphText(text: ': '),
                      //                 Padding(
                      //                   padding:
                      //                   const EdgeInsets.only(left: 0.0, bottom: 5.0, right: 10),
                      //                   child: SkeletonAnimation(
                      //                     borderRadius: BorderRadius.circular(animationBorderRadius),
                      //                     shimmerColor:
                      //                     index % 2 != 0 ? Colors.grey : Colors.white54,
                      //                     child: Container(
                      //                       height: 20,
                      //                       width: MediaQuery.of(context).size.width * 0.25,
                      //                       decoration: BoxDecoration(
                      //                           borderRadius: BorderRadius.circular(animationBorderRadius),
                      //                           color: Colors.grey[300]),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(left: 15.0),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.only(right: 5.0),
                      //                 child: SkeletonAnimation(
                      //                   borderRadius: BorderRadius.circular(10.0),
                      //                   shimmerColor: index % 2 != 0
                      //                       ? Colors.grey
                      //                       : Colors.white54,
                      //                   child: Container(
                      //                     width: 60,
                      //                     height: 30,
                      //                     decoration: BoxDecoration(
                      //                         borderRadius: BorderRadius.circular(10.0),
                      //                         color: Colors.grey[300]),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                  // Container(
                  //   // height: 200,
                  //   child: Column(
                  //     children: [
                  //       for(int i = 0; i<=3;i++ )
                  //
                  //       Container(
                  //         height: 40,
                  //         margin: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                  //         child: SkeletonAnimation(
                  //           shimmerColor: Colors.grey,
                  //           borderRadius: BorderRadius.circular(20),
                  //           shimmerDuration: 1000,
                  //           child: Container(
                  //             decoration: BoxDecoration(
                  //               color: Colors.grey[300],
                  //               borderRadius: BorderRadius.circular(20),
                  //               boxShadow: [
                  //                 BoxShadow(color: Colors.grey[300]!, blurRadius: 30, offset: Offset(0, 10))
                  //               ],
                  //             ),
                  //             margin: EdgeInsets.only(top: 40),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  vSizedBox2,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [

                        hSizedBox,

                      ],
                    ),
                  ),
                  vSizedBox2,
                  if (availableOn.length != 0)
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ParagraphText(
                        text: 'Available on:',
                        color: MyColors.primaryColor,
                        fontFamily: 'medium',
                        fontSize: 20,
                      ),
                    ),
                  vSizedBox05,
                  for (var i = 0; i < availableOn.length; i++)
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border:
                            Border.all(color: MyColors.bordercolor),
                            borderRadius: BorderRadius.circular(4)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 10),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: MyColors.bordercolor),
                                        borderRadius:
                                        BorderRadius.circular(4)),
                                    child: Image.network(
                                      availableOn[i]['logo_path'],
                                      height: 36,
                                      width: 44,
                                    ),
                                  ),
                                ),
                                hSizedBox,
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    ParagraphText(
                                      text: availableOn[i]['platform']
                                          .toString()
                                          .toCapitalize(),
                                      fontSize: 13,
                                      fontFamily: 'light',
                                    ),
                                    ParagraphText(
                                      text:
                                      '${availableOn[i]['amount'] == 0 ? '${availableOn[i]['type'].toString().toCapitalize()}' : '${availableOn[i]['type'].toString().toCapitalize()} (${currency_symbol}${availableOn[i]['amount']})'}',
                                      fontSize: 13,
                                      fontFamily: 'medium',
                                      color: MyColors.primaryColor,
                                    )
                                  ],
                                )
                              ],
                            ),
                            // RoundEdgedButton(
                            //   onTap: () async {
                            //     print('linkurl-' +
                            //         availableOn[i]['link'].toString());
                            //
                            //     var request = {
                            //       'media_id': {
                            //         'value':
                            //         '${widget.details!['id'].toString()}'
                            //       },
                            //       'media_type': {
                            //         'value': widget.mediaType.name,
                            //       },
                            //     };
                            //     loadingLauncher = true;
                            //     setState(() {});
                            //     Webservices.getData(
                            //         'keep-watching', request);
                            //     setState(() {});
                            //     if (await canLaunchUrl(
                            //         Uri.parse(availableOn[i]['link']))) {
                            //       await launchUrl(
                            //           Uri.parse(availableOn[i]['link']),
                            //           mode: LaunchMode
                            //               .externalNonBrowserApplication);
                            //       loadingLauncher = false;
                            //       setState(() {});
                            //     } else {
                            //       log("could not launch");
                            //       loadingLauncher = false;
                            //       setState(() {});
                            //       throw 'Could not launch ';
                            //     }
                            //
                            //     // await launchUrl(Uri(scheme:scheme,host:host,path:path));
                            //   },
                            //
                            //   text: 'Watch',
                            //   textColor: Colors.white,
                            //   width: 51,
                            //   height: 20,
                            //   horizontalPadding: 0,
                            //   fontSize: 12,
                            //   // fontfamily: 'light',
                            //   verticalPadding: 0,
                            // )
                          ],
                        ),
                      ),
                    ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Container(
                  //     margin: EdgeInsets.only(bottom: 8),
                  //     decoration: BoxDecoration(
                  //         color: Colors.black,
                  //         border: Border.all(color: MyColors.bordercolor),
                  //         borderRadius: BorderRadius.circular(4)),
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 9, vertical: 10),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             ClipRRect(
                  //               borderRadius: BorderRadius.circular(4),
                  //               child: Container(
                  //                 decoration: BoxDecoration(
                  //                     border: Border.all(
                  //                         color: MyColors.bordercolor),
                  //                     borderRadius:
                  //                     BorderRadius.circular(4)),
                  //                 child: Image.asset(
                  //                   MyImages.prime,
                  //                   height: 36,
                  //                   width: 44,
                  //                 ),
                  //               ),
                  //             ),
                  //             hSizedBox,
                  //             Column(
                  //               crossAxisAlignment:
                  //               CrossAxisAlignment.start,
                  //               children: [
                  //                 ParagraphText(
                  //                   text: 'Prime video',
                  //                   fontSize: 13,
                  //                   fontFamily: 'light',
                  //                 ),
                  //                 ParagraphText(
                  //                   text: 'Buy/Rent',
                  //                   fontSize: 13,
                  //                   fontFamily: 'medium',
                  //                   color: MyColors.primaryColor,
                  //                 )
                  //               ],
                  //             )
                  //           ],
                  //         ),
                  //         RoundEdgedButton(
                  //           text: 'Watch',
                  //           textColor: Colors.white,
                  //           width: 51,
                  //           height: 20,
                  //           horizontalPadding: 0,
                  //           fontSize: 12,
                  //           // fontfamily: 'light',
                  //           verticalPadding: 0,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Container(
                  //     margin: EdgeInsets.only(bottom: 8),
                  //     decoration: BoxDecoration(
                  //         color: Colors.black,
                  //         border: Border.all(color: MyColors.bordercolor),
                  //         borderRadius: BorderRadius.circular(4)),
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 9, vertical: 10),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             ClipRRect(
                  //               borderRadius: BorderRadius.circular(4),
                  //               child: Container(
                  //                 width: 44,
                  //                 // padding: EdgeInsets.all(5),
                  //                 decoration: BoxDecoration(
                  //                     border: Border.all(
                  //                         color: MyColors.bordercolor),
                  //                     borderRadius:
                  //                     BorderRadius.circular(4)),
                  //                 child: Image.asset(
                  //                   MyImages.tubi,
                  //                   height: 30,
                  //                 ),
                  //               ),
                  //             ),
                  //             hSizedBox,
                  //             Column(
                  //               crossAxisAlignment:
                  //               CrossAxisAlignment.start,
                  //               children: [
                  //                 ParagraphText(
                  //                   text: 'Tubi',
                  //                   fontSize: 13,
                  //                   fontFamily: 'light',
                  //                 ),
                  //                 ParagraphText(
                  //                   text: 'Free',
                  //                   fontSize: 13,
                  //                   fontFamily: 'medium',
                  //                   color: MyColors.primaryColor,
                  //                 )
                  //               ],
                  //             )
                  //           ],
                  //         ),
                  //         RoundEdgedButton(
                  //           text: 'Watch',
                  //           textColor: Colors.white,
                  //           width: 51,
                  //           height: 20,
                  //           horizontalPadding: 0,
                  //           fontSize: 12,
                  //           // fontfamily: 'light',
                  //           verticalPadding: 0,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  vSizedBox2,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ParagraphText(
                      text: 'Cast Members:',
                      color: MyColors.primaryColor,
                      fontFamily: 'medium',
                      fontSize: 20,
                    ),
                  ),
                  vSizedBox,
                  Container(
                    height: 190,
                    child:
                         ListView.builder(
                      itemCount: castMembers.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 16),
                      itemBuilder: (context, i) {
                        return Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 95,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFD9D9D9)
                                      .withOpacity(0.1)),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    castMembers[i]['profile_path'],
                                    height: 129,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.all(3.0),
                                    child: ParagraphText(
                                      text:
                                      '${castMembers[i]['original_name']}',
                                      maxline: 1,
                                      fontSize: 12,
                                      fontFamily: 'semibold',
                                      color: MyColors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.all(3.0),
                                    child: ParagraphText(
                                      text:
                                      '${castMembers[i]['characters']}',
                                      fontSize: 11,
                                      fontFamily: 'regular',
                                      color: MyColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Container(
                  //   height: 180,
                  //   padding: pad_horizontal,
                  //   child: ListView(
                  //     clipBehavior: Clip.none,
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       for(var i=0; i<castMembers.length; i++)
                  //       Container(
                  //         margin: EdgeInsets.only(right: 10),
                  //         width: 95,
                  //         child: ClipRRect(
                  //           borderRadius: BorderRadius.circular(8),
                  //           child: Container(
                  //             decoration: BoxDecoration(
                  //               color: Color(0xFFD9D9D9).withOpacity(0.1)
                  //             ),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Image.network(castMembers[i]['profile_path'],
                  //                   height: 129,
                  //                   width: MediaQuery.of(context).size.width,
                  //                   fit: BoxFit.fitWidth,
                  //                 ),
                  //                 Padding(
                  //                   padding: const EdgeInsets.all(3.0),
                  //                   child: ParagraphText(text: '${castMembers[i]['original_name']}', fontSize: 12, fontFamily: 'semibold', color: MyColors.white,),
                  //                 ),
                  //                 Padding(
                  //                   padding: const EdgeInsets.all(3.0),
                  //                   child: ParagraphText(text: '${castMembers[i]['name']}', fontSize: 11, fontFamily: 'regular', color: MyColors.white,),
                  //                 ),
                  //
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  vSizedBox4,
                ],
              )
                  : Text("no data found"),
            ),
          ),
          if (loadingLauncher == true)
            Container(
                color: Colors.black.withOpacity(0.4),
                child: Center(
                    child: CircularProgressIndicator(
                      color: MyColors.primaryColor,
                      // radius: 24,
                    )))
          // Positioned(
          // left:MediaQuery.of(context).size.width/2 - 20 ,
          //     top:MediaQuery.of(context).size.height/2 - 20,
          //     child: Container(
          //       height:40,
          //       width:40,
          //       child: CircularProgressIndicator(
          //   color:MyColors.primaryColor,
          //
          //   // radius: 18,
          // ),
          //     )
          //
          //
          // ),
        ],
      ),
      // drawer: Drawer(
      //   // Add a ListView to the drawer. This ensures the user can scroll
      //   // through the options in the drawer if there isn't enough vertical
      //   // space to fit everything.
      //   child: ListView(
      //     // Important: Remove any padding from the ListView.
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Text('Drawer Header'),
      //       ),
      //       ListTile(
      //         title: const Text('Item 1'),
      //         onTap: () {
      //           // Update the state of the app.
      //           // ...
      //         },
      //       ),
      //       ListTile(
      //         title: const Text('Item 2'),
      //         onTap: () {
      //           // Update the state of the app.
      //           // ...
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
