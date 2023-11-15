import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:livestream/functions/globalFunctions.dart';
import 'package:livestream/widgets/custom_circular_image.dart';

import '../constants/colors.dart';
import '../constants/global_data.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../functions/navigation_functions.dart';
import '../functions/validations.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/appbar.dart';
import '../widgets/buttons.dart';
import '../widgets/customtextfield.dart';
import '../widgets/showSnackbar.dart';
import 'chat_detail.dart';
import 'create_new_group.dart';
class CommentList extends StatefulWidget {
  final feed_id;
  final Function(String,Map) commentUpdate;
  CommentList({
    required this.commentUpdate,
    required this.feed_id,
    Key? key}) : super(key: key);

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  TextEditingController search=TextEditingController();
  TextEditingController comment=TextEditingController();

  bool load = false;
  ScrollController _controller =
  ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  // int page=1;
  bool loading = false;
  bool loadComment =false;
  bool isUpdated= false;
  Map? lastComment;
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

          getComments();

          //  get_transactions();
        }

        // });
      }
    });

    getComments();
    super.initState();
  }




  getComments() async{
    searchParams["feed_id"]['value']=widget.feed_id;
    loading = true;
    setState(() {});
    bool hasNewData=false;
    if(searchParams['page']['value'] == "1"){
      results=[];
    }
    Map res = await Webservices.getData('feed-comment-users', searchParams);
    print('checking---'+res["data"].toString());
    if(res["status"].toString()=='1'){
      loading = false;
      setState(() {});
      if(res["data"].toString()!='null'){
        for(int m=0;m<res["data"]['data'].length;m++){
          // print('ressl---------'+res["data"]['data'][m]);
          hasNewData = true;
          res["data"]["data"][m]['load']=false;
          results.add(res["data"]["data"][m]);
        }

        widget.commentUpdate(results.length.toString(), results[results.length-1]);
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
      appBar: appBar(context: context, title: 'Comments', titleColor: Colors.white),
      body:   Stack(
        children: [
          ListView(
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
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ParagraphText(
                                                text: results[i]['first_name'].toString().toCapitalize()+" "+results[i]['last_name'],
                                                maxline: 2,
                                                fontSize: 15,
                                                fontFamily: 'medium',
                                                color: MyColors.primaryColor,
                                              ),
                                              if(results[i]['id'].toString().toCapitalize() == user_id!.toString())
                                                GestureDetector(
                                                    onTap:() async{
                                                      print(results[i]);


                                                      comment.text = results[i]['comment'];
                                                      await showCustomDialogBox(
                                                          marginhorizontal:
                                                          24,
                                                          border: false,
                                                          context:
                                                          context,
                                                          child: StatefulBuilder(
                                                              builder: (context, setState) {
                                                                return Column(
                                                                  children: [
                                                                    vSizedBox2,
                                                                    MainHeadingText(
                                                                      text:
                                                                      'Edit comment',
                                                                      fontSize:
                                                                      20,
                                                                    ),
                                                                    vSizedBox2,
                                                                    CustomTextField(
                                                                      controller:
                                                                      comment,
                                                                      hintText:
                                                                      'Add Comment',
                                                                      maxLines:
                                                                      7,
                                                                      height:
                                                                      150,
                                                                      border: Border.all(
                                                                          color:
                                                                          MyColors.primaryColor),
                                                                      borderradius:
                                                                      12,
                                                                    ),
                                                                    vSizedBox2,
                                                                    RoundEdgedButton(
                                                                      load: load,
                                                                      text:
                                                                      'Update',
                                                                      textColor:
                                                                      MyColors
                                                                          .white,
                                                                      verticalPadding:
                                                                      0,
                                                                      horizontalPadding:
                                                                      0,
                                                                      height:
                                                                      29,
                                                                      minWidth:
                                                                      120,
                                                                      onTap:
                                                                          () async{

                                                                        Map<dynamic,dynamic> request =
                                                                        {
                                                                          'id':
                                                                          {
                                                                            'value': '${ results[i]['comment_id'].toString()}',"type":"NO", "msg":""
                                                                          },
                                                                          'comment':
                                                                          {
                                                                            'value': '${comment.text}',"type":"NO", "msg":"Please enter comment."
                                                                          },
                                                                        };
                                                                        print(
                                                                            '------------request------------${request}');
                                                                        if(validateMap(request)==1){
                                                                          load =
                                                                          true;
                                                                          setState(
                                                                                  () {});
                                                                          var res = await Webservices.postData(
                                                                              'edit-feed-comment',
                                                                              request,null);
                                                                          isUpdated = true;
                                                                          load =
                                                                          false;
                                                                          Navigator.pop(context);
                                                                          // print(
                                                                          //     '----------res-------${res}');

                                                                          showSnackbar('${res['message']}');

                                                                          setState(
                                                                                  () {});
                                                                          // Navigator.pop(
                                                                          // context);
                                                                        }
                                                                      },
                                                                    ),
                                                                    vSizedBox2,
                                                                  ],
                                                                );
                                                              }
                                                          ));
                                                      print("updated-------------------");
                                                      searchParams['page']['value']='1';
                                                      getComments();

                                                    },
                                                    child: Icon(Icons.create, color: Colors.white, size: 20,)
                                                )
                                            ],
                                          ),

                                          ParagraphText(
                                            text: results[i]['comment'],
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                          ParagraphText(
                                            text: results[i]['time_ago'],
                                            fontSize: 12,
                                            color: Colors.white60,
                                          ),



                                        ],
                                      ),
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
          Positioned(
            bottom:10,
            left:10,
            right:10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RoundEdgedButton(
                text:"Add Comment",
                textColor: Colors.white,
                onTap: () async{




                  // print(results[i]);


                  comment.text = "";
                  await showCustomDialogBox(
                      marginhorizontal:
                      24,
                      border: false,
                      context:
                      context,
                      child: StatefulBuilder(
                          builder: (context, setState) {
                            return Column(
                              children: [
                                vSizedBox2,
                                MainHeadingText(
                                  text:
                                  'Add comment',
                                  fontSize:
                                  20,
                                ),
                                vSizedBox2,
                                CustomTextField(
                                  controller:
                                  comment,
                                  hintText:
                                  'Add Comment',
                                  maxLines:
                                  7,
                                  height:
                                  150,
                                  border: Border.all(
                                      color:
                                      MyColors.primaryColor),
                                  borderradius:
                                  12,
                                ),
                                vSizedBox2,
                                RoundEdgedButton(
                                  load: load,
                                  text:
                                  'Submit',
                                  textColor:
                                  MyColors
                                      .white,
                                  verticalPadding:
                                  0,
                                  horizontalPadding:
                                  0,
                                  height:
                                  29,
                                  minWidth:
                                  120,
                                  onTap:
                                      () async{

                                    Map<dynamic,dynamic> request =
                                    {
                                      'feed_id':
                                      {
                                        'value': '${ widget.feed_id.toString()}',"type":"NO", "msg":""
                                      },
                                      'comment':
                                      {
                                        'value': '${comment.text}',"type":"NO", "msg":"Please enter comment."
                                      },
                                    };




                                    print(
                                        '------------request------------${request}');
                                    if(validateMap(request)==1){
                                      load =
                                      true;
                                      setState(
                                              () {});
                                      var res = await Webservices.getData(
                                          'add-feed-comment',
                                          request);
                                      isUpdated = true;
                                      load =
                                      false;
                                      Navigator.pop(context);
                                      // print(
                                      //     '----------res-------${res}');

                                      showSnackbar('${res['message']}');

                                      setState(
                                              () {});



                                      //
                                      // loadComment = true;
                                      // setState(() {   });
                                      // print("clickeddddd----");
                                      // Map param={
                                      //   "feed_id":{"value":widget.feed_id},
                                      //
                                      //   "comment":{"value":search.text},
                                      // };
                                      // Map res = await Webservices.getData('add-feed-comment', param);
                                      // loadComment = false;
                                      // setState(() {   });
                                      // if(res["status"].toString()=="1"){
                                      //   isUpdated = true;
                                      //   search.text="";
                                      //   searchParams['page']['value']='1';
                                      //   getComments();
                                      // }
                                      // Navigator.pop(
                                      // context);
                                    }
                                  },
                                ),
                                vSizedBox2,
                              ],
                            );
                          }
                      ));
                  print("created-------------------");
                  searchParams['page']['value']='1';
                  getComments();







                },
                // child:loadComment?Container(
                //   height:20,
                //   width:20 ,
                //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                //   child: CircularProgressIndicator(
                //     color:MyColors.primaryColor,
                //     // value: 1,
                //
                //     // radius: 18,
                //   ),
                // ):Icon(Icons.send, color: MyColors.primaryColor,),
              )




              // Container(
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(30
              //     ),
              //     child: Row(
              //       children: [
              //         Expanded(
              //           child: CustomTextField(
              //             // textInputAction: TextInputAction.,
              //             controller: search,
              //             onChange: (value){
              //               if(value==null || value ==''){
              //                 searchParams["keywords"]["value"]="";
              //
              //                 searchParams['page']['value']="1";
              //
              //
              //               }
              //
              //             },
              //             onSubmitted: (value){
              //               searchParams["keywords"]["value"]=search.text;
              //
              //               searchParams['page']['value']="1";
              //               search.text = value;
              //
              //
              //               setState(() {
              //
              //               });
              //
              //             },
              //             hintText: 'Add your comment',
              //             maxLines: 3,
              //             suffixIcon: GestureDetector(
              //               onTap: () async{
              //
              //                 loadComment = true;
              //                 setState(() {   });
              //                 print("clickeddddd----");
              //                 Map param={
              //                   "feed_id":{"value":widget.feed_id},
              //
              //                   "comment":{"value":search.text},
              //                 };
              //                 Map res = await Webservices.getData('add-feed-comment', param);
              //                 loadComment = false;
              //                 setState(() {   });
              //                 if(res["status"].toString()=="1"){
              //                   isUpdated = true;
              //                   search.text="";
              //                   searchParams['page']['value']='1';
              //                   getComments();
              //                 }
              //
              //               },
              //                 child:loadComment?Container(
              //                   height:20,
              //                   width:20 ,
              //                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              //                   child: CircularProgressIndicator(
              //                     color:MyColors.primaryColor,
              //                     // value: 1,
              //
              //                     // radius: 18,
              //                   ),
              //                 ):Icon(Icons.send, color: MyColors.primaryColor,),
              //             ),
              //             // prefixIcon: MyImages.search,
              //             borderradius: 0,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ),
          ),
        ],
      ),

    );
  }


  deleteComment(){
    // delete-feed-comment

    // method : get
    // param : id
  }
}
