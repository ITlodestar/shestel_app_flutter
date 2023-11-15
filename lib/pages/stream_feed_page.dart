import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:livestream/constants/colors.dart';
import 'package:livestream/constants/image_urls.dart';
import 'package:livestream/functions/globalFunctions.dart';
import 'package:livestream/pages/chat_list_page.dart';
import 'package:livestream/widgets/custom_circular_image.dart';
import '../constants/global_data.dart';
import '../constants/sized_box.dart';
import '../functions/ad_helper.dart';
import '../functions/dynamiclink.dart';
import '../functions/navigation_functions.dart';
import '../services/webservices.dart';
import '../widgets/CoverContainImage.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/appbar.dart';
import '../widgets/showSnackbar.dart';

import 'package:share_plus/share_plus.dart';

import '../widgets/unreadCountCircle.dart';
import 'comments.dart';
import 'like-lists.dart';


class StreamFeed_Page extends StatefulWidget {
  final String? feed_id;
  StreamFeed_Page({
    this.feed_id,
    Key? key}) : super(key: key);

  @override
  State<StreamFeed_Page> createState() => _StreamFeed_PageState();
}
var scaffoldKey = GlobalKey<ScaffoldState>();
class _StreamFeed_PageState extends State<StreamFeed_Page> {
  TextEditingController search=TextEditingController();
  NativeAd? _ad;
  ScrollController _controller =
  ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  bool loading = false;
  List results=[];
  Map searchParams={
    "page":{"value":"1"},
  };
  @override
  void initState() {
    // TODO: implement initState

    NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as NativeAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');       },
      ),
    ).load();


    _controller.addListener(() {
      var isEnd = _controller.offset == _controller.position.maxScrollExtent;

      if (isEnd) {
        print('object-789');
        // log('reach end - '+page.toString());
        // setState(() {
        if (loading == false) {
          print('   object-555');
          getFeeds();
        }

        // });
      }
    });

    getFeeds();
    super.initState();
  }
  getFeeds() async{
    loading = true;
    setState(() {});
    bool hasNewData=false;
    if(widget.feed_id!=null){
      searchParams['feed_id']={'value':widget.feed_id};
    }
    if(searchParams['page']['value']=="1"){
      results=[];
    }
    Map res = await Webservices.getData('feeds', searchParams);
    if(res["status"].toString()=='1'){
      loading = false;
      setState(() {});
      if(res["data"].toString()!='null'){

        for(int m=0;m<res["data"]['data'].length;m++){
          print('res---------'+res["data"]["data"][m].toString());
          hasNewData = true;
          res["data"]["data"][m]['load']=false;
          results.add(res["data"]["data"][m]);
        }


      }

      if(hasNewData==true){
        searchParams['page']['value']= (int.parse(searchParams['page']['value'])+1).toString();
      }
      print("result-----------------${results.length}");

      setState(() {

      });
    }
    else{

      showSnackbar(res['message']);
      loading = false;
      setState(() {      });
    }
    log("this is response"+res.toString());

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        appBar: appBar(
            context: context,
            title: 'My Feed',
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
            implyLeading: true,
            actions: [
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
              // IconButton(onPressed: (){},
              //   visualDensity: VisualDensity(horizontal: -4),
              //   padding: EdgeInsets.symmetric(horizontal: 5),
              //   constraints: BoxConstraints(),
              //   icon: Icon(
              //     Icons.notifications,
              //   ),
              // ),
            ]
        ),
        body: ListView(
          controller: _controller,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSizedBox2,

            if(results.length>0)
              for(var i=0; i<results.length; i++)
                Column(
                  children: [
                    if (i==1 && _ad!=null)
                      Padding(
                        padding: const EdgeInsets.only(left:12.0, right:12.0, bottom: 20.0),
                        child: Container(
                            clipBehavior: Clip.hardEdge,

                            height:60,

                            decoration: BoxDecoration(color: Colors.white,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            // width: MediaQuery.of(context).size.width,
                            child: AdWidget(ad: _ad!)),
                      ),
                    Container(
                      padding: EdgeInsets.only(bottom: 16),
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: MyColors.primaryColor.withOpacity(0.15),
                                  width: 5
                              )
                          )
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomCircularImage(imageUrl:results[i]['create_by']['profile'], height: 40,width: 40),
                                hSizedBox2,
                                Expanded(
                                  // width: MediaQuery.of(context).size.width - 100,
                                  child: RichText(
                                    // softWrap: false,
                                    overflow: TextOverflow.visible,
                                    text: TextSpan(
                                      text: results[i]['create_by']['name'].toString().toCapitalize() ,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,

                                          fontFamily: 'bold'
                                      ),
                                      children: <TextSpan>[
                                        if(int.parse(results[i]['comment_count'].toString())>1)
                                        TextSpan(text: ' and',
                                            style: TextStyle(fontFamily: 'light')),
                                        if(int.parse(results[i]['comment_count'].toString())>1)
                                        TextSpan(text: ' ${ (int.parse(results[i]['comment_count'].toString())-1).toString()} others'),
                                        // if(int.parse(results[i]['comment_count'].toString())>1)
                                        TextSpan(text: ' commented on this',style: TextStyle(fontFamily: 'light')),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          vSizedBox,
                          vSizedBox05,
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CoverContainImage(
                                imageUrl:results[i]['url'],
                                borderRadius: 0,
                                height: 190,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              GestureDetector(
                                onTap: (){
                                  // print(results[i].toString());
                                  results[i]['id']=results[i]['media_id'];
                                  goDetails(context: context, data:results[i], mediaType: MediaType.movie);
                                },
                                child: Image.asset(MyImages.play),
                              ),
                              Positioned(
                                right: 16,
                                bottom: 16,
                                child: GestureDetector(
                                  onTap: (){

                                  },
                                  child: (results[i]['provider_logo']=='')?Container():Image.network(results[i]['provider_logo'], height:20),
                                ),
                              )
                            ],
                          ),
                          vSizedBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    var request = {
                                      'feed_id': {
                                        'value':
                                        '${results[i]['feed_id'].toString()}'
                                      },
                                      // 'media_id': {'value':'499'},
                                      'media_type': {
                                        'value': results[i]['media_type'],
                                      },
                                    };
                                    Webservices.getData(
                                        results[i]['is_like'] == 0
                                            ? 'like-feed'
                                            : 'unlike-feed',
                                        request);
                                    if (results[i]['is_like'] == 0) {
                                      results[i]['like_count'] += 1;
                                    } else {
                                      results[i]['like_count'] -= 1;
                                    }
                                    results[i]['is_like'] =
                                    results[i]['is_like'] == 0
                                        ? 1
                                        : 0;

                                    setState(() {});
                                  },
                                    child: Icon(
                                      results[i]['is_like'] == 1
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_border_rounded,
                                      color: MyColors.primaryColor,
                                      size: 24,
                                    )),



                                GestureDetector(
                                  onTap: (){
                                    if(results[i]['like_count']!=0){
                                      push(context: context, screen: LikeList(feed_id:'${results[i]['feed_id']}'));
                                    }

                                    // LikeList(feed_id:'${results[i]['feed_id']}');
                                  },
                                  child:
                                  Row(children: [
                                  hSizedBox05,
                               ParagraphText(text: '${results[i]['like_count']}', fontSize: 12, fontFamily: 'light', underlined: true,),
                                  hSizedBox2,
                                ])
                                ),
                                GestureDetector(
                                  onTap: () async{
                                    if(results[i]['comment_count'].toString()!='0'){
                                      await push(context: context, screen: CommentList(
                                          feed_id:'${results[i]['feed_id']}',
                                          commentUpdate:(String count, Map comment){
                                            print('comment updated');
                                            print(count);
                                            print(comment);

                                            results[i]['comments']['create_by']['profile'] = comment["profile"];
                                            results[i]['comments']['create_by']['name'] = comment["first_name"]+' '+ comment["last_name"];
                                            results[i]['comments']['comment'] = comment["comment"];
                                            results[i]['comment_count'] = count;
                                            setState(() {

                                            });
                                          }
                                      )
                                      );
                                      // searchParams['page']['value'] ="1";
                                      // getFeeds();
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(MyImages.chat_active, height: 20,),
                                      hSizedBox05,

                                      ParagraphText(text: '${results[i]['comment_count'].toString()} comment'+((int.parse(results[i]['comment_count'].toString())>1)?'s':''), fontSize: 12, fontFamily: 'light', underlined: true,),
                                      hSizedBox2,
                                    ],
                                  ),
                                ),

                                GestureDetector(
                                  onTap:() async{
                                    String message = "Check out '" +
                                        results[i]!['title'] +
                                        "' on Shestel.";
                                    // Share.share(message);


                                    try{
                                      // _isCreatingLink=true;

                                      setState(() { });
                                      String link = await createDynamicLink("https://shestel.page.link",{"media_type":results[i]['media_type'],"media_id":results[i]['media_id'].toString(), "type":results[i]['media_type'], "notification_id":"0"},results[i]!['title'],results[i]['url']);
                                      // _isCreatingLink=false;
                                      setState(() { });
                                      Share.share(message+" "+link);
                                    }
                                    catch(e){
                                      // _isCreatingLink=false;
                                      setState(() { });
                                    }

                                  },
                                  child: Row(children:[
                                    Image.asset(MyImages.share, height: 20,),
                                    hSizedBox05,
                                    ParagraphText(text: 'Share ', fontSize: 12, fontFamily: 'light', underlined: true,),]
                                  ),
                                )

                              ],
                            ),
                          ),
                          vSizedBox,
                          // for(var j=0;j<results[i]['comments'].length;j++)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0 ),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [


                                  CustomCircularImage(imageUrl: '${results[i]['comments']['create_by']['profile']}', height: 30,width: 30), hSizedBox,

                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.33),
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ParagraphText(text: '${results[i]['comments']['create_by']['name'].toString().toCapitalize()}', fontSize: 13, fontFamily: 'semibold',),
                                          ParagraphText(text: '${results[i]['comments']['comment']}', fontSize: 12, fontFamily: 'regular',),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            if(loading==false)
              SizedBox(height:60),
            if(loading==false && results.length==0)
              Center(child: Padding(
                padding: const EdgeInsets.only(top:100),
                child: ParagraphText(text: "No data found", color: Colors.white,),
              )),

            if(loading==true && searchParams['page']['value'] =="1")
              SizedBox(height:100),


            if(loading==true)
              Center(
                child: Container(
                  margin: EdgeInsets.only(top:30),
                  height:30,
                  width:30,
                  child: CircularProgressIndicator(
                    color:MyColors.primaryColor,

                    // radius: 18,
                  ),
                ),
              ),

            SizedBox(height:10),

          ],
        ),
    );
  }
}