import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:livestream/widgets/custom_circular_image.dart';

import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../functions/navigation_functions.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/appbar.dart';
import '../widgets/buttons.dart';
import '../widgets/customtextfield.dart';
import '../widgets/showSnackbar.dart';
import 'chat_detail.dart';
import 'create_new_group.dart';
class LikeList extends StatefulWidget {
  final feed_id;
  LikeList({
    required this.feed_id,
    Key? key}) : super(key: key);

  @override
  State<LikeList> createState() => _LikeListState();
}

class _LikeListState extends State<LikeList> {
  TextEditingController search=TextEditingController();
  ScrollController _controller =
  ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  // int page=1;
  bool loading = false;
  Map searchParams={
    "feed_id":{"value":""},

    "page":{"value":"1"},
  };
  List results=[];
  var list = [
    "John Smith",
    "Ryan Dokidis",
    "Jaylon Saris",
    "Alfonso Herwitz",
    "Jakob Levin"
  ];
  var list2 = [
    "Group Name 1",
    "Group Name 2",
    "Group Name 3",
    "Group Name 4",
    "Group Name 5",
    "Group Name 6",
  ];
  var images = [
    MyImages.chat1,
    MyImages.chat2,
    MyImages.chat3,
    MyImages.chat4,
    MyImages.chat5
  ];


  @override
  void initState() {
    // TODO: implement initState
    _controller.addListener(() {
      var isEnd = _controller.offset == _controller.position.maxScrollExtent;

      if (isEnd) {
        print('object-789');
        // log('reach end - '+page.toString());
        // setState(() {
        if (loading == false) {
          print('object-555');

          getUsers();

          //  get_transactions();
        }

        // });
      }
    });

    getUsers();
    super.initState();
  }




  getUsers() async{
    searchParams["feed_id"]['value']=widget.feed_id;
    loading = true;
    setState(() {});
    bool hasNewData=false;
    if(searchParams['page']['value'] == "1"){
      results=[];
    }
    Map res = await Webservices.getData('feed-like-users', searchParams);
    print('ressl---------'+res["data"]['data'].toString());
    if(res["status"].toString()=='1'){
      loading = false;
      setState(() {});
      if(res["data"].toString()!='null'){

        for(int m=0;m<res["data"]['data'].length;m++){

          hasNewData = true;
          res["data"]["data"][m]['load']=false;
          results.add(res["data"]["data"][m]);
        }


      }

      if(hasNewData==true){
        searchParams['page']['value'] = (int.parse(searchParams['page']['value'])+1).toString();
      }

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
      backgroundColor: Colors.black,
      appBar: appBar(context: context, title: 'Like users list', titleColor: Colors.white),
      body:   ListView(
            controller: _controller,
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    for (var i = 0; i < results.length; i++)
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,

                            padding: EdgeInsets.only(top:8,bottom:8, right:10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1, color: Colors.white30, style: BorderStyle.solid))
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,

                              children: [
                                ClipRRect
                                  (
                                  borderRadius: BorderRadius.circular(50),
                                  child:CustomCircularImage(
                                    imageUrl: results[i]['profile'],
                                    fit: BoxFit.cover,
                                    width:50,
                                    height: 50,
                                  ),
                                ),
                                hSizedBox,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ParagraphText(
                                      text: results[i]['first_name']+" "+results[i]['last_name'],
                                      maxline: 2,
                                      fontSize: 15,
                                      fontFamily: 'medium',
                                      color: MyColors.primaryColor,
                                    ),
                                    //
                                    // ParagraphText(
                                    //   text: '@'+results[i]['username'],
                                    //   fontSize: 14,
                                    //   color: Colors.white,
                                    // ),
                                  ],
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                  ],
                ),
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

          SizedBox(height:10)
            ],
          ),

    );
  }
}
