import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/widgets/CustomTexts.dart';
import 'package:livestream/widgets/appbar.dart';
import 'package:livestream/widgets/buttons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/colors.dart';
import '../constants/global_data.dart';
import '../modals/carousal_item_modal.dart';
import '../services/webservices.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

import '../widgets/MediaBox.dart';
class Sport_Details_Page extends StatefulWidget {
  final String? id;
  Map? details;
  final MediaType mediaType;


  Sport_Details_Page(

      {this.id, this.details, this.mediaType = MediaType.movie, Key? key})
      : super(key: key);

  @override
  State<Sport_Details_Page> createState() => _Sport_Details_PageState();
}

class _Sport_Details_PageState extends State<Sport_Details_Page> {
  bool load = false;
  ScrollController scrollController = ScrollController();
  bool loadingLauncher=false;

  double animationBorderRadius = 5;
  double height = 15;
  List  allVideos= [];
  List<CarousalItem> carousalItems = [];
  int _currentIndex = 0;
  TextEditingController search = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // carousalItems.add(CarousalItem(imageUrl: '', mediaType: CarousalMediaType.image));
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

  getAllData() async {
    setState(() {
      load = true;
    });
    Map res = await Webservices.getData('sport-detail', {
      "id": {'value': widget.id.toString()}
    });

    if (res['status'].toString() == "1") {
      log(res.toString());
      widget.details = res['data'];
      setState(() {});
    }
    setState(() {
      load = false;
    });
  }





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: appBar(
        context: context,
        title: 'Details',
        titleColor: Colors.white,

      ),
      body: Stack(

        children: [
          Container(
            decoration: BoxDecoration(color: MyColors.black

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

                          ),
                          items: ["assets/images/sportlogo.png"].map((img) {
                            return Builder(
                              builder: (BuildContext context) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(0),
                                    child: Image.asset(
                                       img,

                                      width:
                                      MediaQuery.of(context).size.width,
                                      fit: BoxFit.fitWidth,
                                      height: 168,
                                    ),
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
                            if(!load)
                              GestureDetector(
                                onTap: () {
                                  var request = {
                                    'media_id': {
                                      'value':
                                      '${widget.details!['id'].toString()}'
                                    },
                                    // 'media_id': {'value':'499'},
                                    'media_type': {
                                      'value':widget.mediaType.name,

                                    },
                                  };
                                  Webservices.getData(
                                      widget.details?['is_like'] == 0
                                          ? 'like-media'
                                          : 'unlike-media',
                                      request);
                                  if(widget.details?['is_like']==0){
                                    widget.details?['totalLikes']+=1;
                                  }else{
                                    widget.details?['totalLikes']-=1;
                                  }
                                  widget.details?['is_like'] =
                                  widget.details?['is_like'] == 0 ? 1 : 0;


                                  setState(() {});
                                },
                                child: Icon(
                                  widget.details?['is_like'] == 1
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  color: MyColors.primaryColor,
                                  size: 24,
                                ),
                              ),
                            // Image.asset(MyImages.heart_active, height: 20,color: ),
                            hSizedBox05,
                            if(!load)
                              ParagraphText(
                                text: '${widget.details?['totalLikes']??0}',
                                fontSize: 12,
                                fontFamily: 'light',
                                underlined: true,
                              ),
                          ],
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ParagraphText(
                      text: widget.details!['sport_title'],
                      fontSize: 16,
                      fontFamily: 'bold',
                    ),
                  ),

                  vSizedBox,

                  if(widget.details!['completed'].toString()=="1" && widget.details!['scores'].length>0)
                    vSizedBox
                  else
                    vSizedBox2,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),

                    child: ParagraphText(text: widget.details!['home_team']  ,
                      textAlign: TextAlign.center,
                      fontSize: 19,
                      fontFamily: 'medium',
                      color: Colors.white,
                    ),
                  ),
                  if(widget.details!['completed'].toString()=="1" && widget.details!['scores'].length>0)
                    vSizedBox05
                  else
                    vSizedBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ParagraphText(text: 'VS'  ,
                      fontSize: 25,
                      fontFamily: 'medium',
                      color: Colors.white,
                    ),
                  ),
                  if(widget.details!['completed'].toString()=="1" && widget.details!['scores'].length>0)
                    vSizedBox05
                  else
                    vSizedBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ParagraphText(text: widget.details!['away_team']  ,
                      fontSize: 19,
                      fontFamily: 'medium',
                      textAlign: TextAlign.center,
                      color: Colors.white,
                    ),
                  ),
                  if(widget.details!['completed'].toString()=="1" && widget.details!['scores'].length>0)
                    vSizedBox05
                  else
                    vSizedBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ParagraphText(text: widget.details!['commence_time']  ,
                      fontSize: 12,
                      fontFamily: 'medium',
                      color: Colors.white,
                    ),
                  ),
                  if(widget.details!['completed'].toString()=="1" && widget.details!['scores'].length>0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        vSizedBox,

                        for(int ii=0; ii<widget.details!['scores'].length;ii++)
                          Container(
                            padding: EdgeInsets.only(top:5, left:16, right:16),
                            child: Wrap(


                              children: [
                                Text(widget.details!['scores'][ii]['name']+": ", style: TextStyle(color:Colors.amber, fontWeight: FontWeight.bold, fontSize: 16), ),
                                Text(widget.details!['scores'][ii]['score'], style: TextStyle(color:Colors.white, fontSize: 16),),
                              ],
                            ),
                          )


                      ],
                    ),
                  vSizedBox2,


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RoundEdgedButton(
                      onTap: (){

                        var request = {
                          'media_id': {
                            'value':
                            '${widget.details!['id'].toString()}'
                          },
                          // 'media_id': {'value':'499'},
                          'media_type': {
                            'value':widget.mediaType.name,

                          },
                        };
                        Webservices.getData(
                            widget.details?['is_seen'] == 0
                                ? 'seen-media'
                                : 'unseen-media',
                            request);

                        widget.details?['is_seen'] =
                        widget.details?['is_seen'] == 0 ? 1 : 0;


                        setState(() {});
                      },
                      text: 'Seen',
                      isSolid: widget.details!['is_seen']==0?true:false,
                      textColor: Colors.white,
                      width: 40,
                      horizontalMargin: 0,
                      horizontalPadding: 0,
                      verticalPadding: 0,
                      height: 20,
                      fontSize: 12,
                    ),
                  ),
                  vSizedBox,

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        RoundEdgedButton(
                          text: widget.details?['saved_to_watch'] == 1?'Remove from Watchlist':'Save to Watchlist',
                          textColor: Colors.white,
                          minWidth: widget.details?['saved_to_watch'] == 1?180:150,
                          horizontalPadding: 0,
                          // isSolid: false,
                          bordercolor: Colors.black,
                          color: MyColors.primaryColor,
                          fontSize: 14,
                          height: 31,
                          verticalPadding: 0,
                          onTap: ()async{
                            var request = {
                              'media_id': {
                                'value':
                                '${widget.details!['id'].toString()}'
                              },
                              // 'media_id': {'value':'499'},
                              'media_type': {
                                'value':widget.mediaType.name,
                              },
                            };
                            Webservices.getData(
                                widget.details?['saved_to_watch'] == 0
                                    ? 'add-to-watchlist'
                                    : 'remove-from-watchlist',
                                request);
                            widget.details?['saved_to_watch'] =
                            widget.details?['saved_to_watch'] == 0 ? 1 : 0;
                            setState(() {});
                          },
                        ),
                        hSizedBox,
                        RoundEdgedButton(
                          onTap: () async{
                            String message = "Check out "+widget.details!['sport_title']+" game status on Shestel.";
                            // await Share.shareFiles([widget.details!['url']], text: 'Great picture');
                            Share.share(message);

                          },
                          text: 'Share',
                          textColor: Colors.white,
                          minWidth: 60,
                          horizontalPadding: 0,
                          bordercolor: Colors.black,
                          color: MyColors.primaryColor,
                          fontSize: 14,
                          height: 31,
                          verticalPadding: 0,
                        ),
                      ],
                    ),
                  ),
                  vSizedBox2,
                  if(availableOn.length!=0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ParagraphText(
                        text: 'Available on:',
                        color: MyColors.primaryColor,
                        fontFamily: 'medium',
                        fontSize: 20,
                      ),
                    ),
                  vSizedBox05,
                  for(var i=0; i<availableOn.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: MyColors.bordercolor),
                            borderRadius: BorderRadius.circular(4)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      text: '${availableOn[i]['platform']}',
                                      fontSize: 13,
                                      fontFamily: 'light',
                                    ),
                                    ParagraphText(
                                      text: '${availableOn[i]['amount']==0?'${availableOn[i]['type']}':'${availableOn[i]['type']} (\$${availableOn[i]['amount']})'}',
                                      fontSize: 13,
                                      fontFamily: 'medium',
                                      color: MyColors.primaryColor,
                                    )
                                  ],
                                )
                              ],
                            ),
                            RoundEdgedButton(
                              onTap: ()async{
                                print('linkurl-'+availableOn[i]['link'].toString());

                                var request = {
                                  'media_id': {
                                    'value':
                                    '${widget.details!['id'].toString()}'
                                  },
                                  'media_type': {
                                    'value':widget.mediaType.name,

                                  },
                                };
                                loadingLauncher=true;
                                setState(() {});
                                Webservices.getData('keep-watching' , request);
                                setState(() {});
                                if (await canLaunchUrl(Uri.parse(availableOn[i]['link']))) {

                                  await launchUrl(Uri.parse(availableOn[i]['link']), mode: LaunchMode.externalNonBrowserApplication);
                                  loadingLauncher=false;
                                  setState(() {});
                                } else {
                                  log("could not launch");
                                  loadingLauncher=false;
                                  setState(() {});
                                  throw 'Could not launch ';
                                }

                                // await launchUrl(Uri(scheme:scheme,host:host,path:path));

                              },

                              text: 'Watch',
                              textColor: Colors.white,
                              width: 51,
                              height: 20,
                              horizontalPadding: 0,
                              fontSize: 12,
                              // fontfamily: 'light',
                              verticalPadding: 0,
                            )
                          ],
                        ),
                      ),
                    ),


                  vSizedBox4,
                ],
              )
                  : Text("no data found"),
            ),
          ),
          if(loadingLauncher==true)
            Container(
                color: Colors.black.withOpacity(0.4),
                child: Center(
                    child: CircularProgressIndicator(
                      color:MyColors.primaryColor,
                      // radius: 24,
                    )
                ))


        ],
      ),

    );
  }
}
