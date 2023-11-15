import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/functions/globalFunctions.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/stream_feed_page.dart';
import 'package:livestream/widgets/appbar.dart';
import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/notification_box.dart';
import '../widgets/showSnackbar.dart';
import 'chat_detail.dart';
import 'chat_list_page.dart';
bool active = false;
class Notifications_Page extends StatefulWidget {
  static const String id="Notifications_Page";
  const Notifications_Page({Key? key}) : super(key: key);

  @override
  State<Notifications_Page> createState() => _Notifications_PageState();
}

class _Notifications_PageState extends State<Notifications_Page> {
  TextEditingController namecontroller = TextEditingController();
  ScrollController _controller =
  ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  // int page=1;
  bool loading = false;
  Map searchParams={
    "keywords":{"value":""},
    "page":{"value":"1"},
  };
  List results=[];
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
          getNotifications();
        }

        // });
      }
    });

    getNotifications();
    super.initState();
  }

  Future<bool>accept(String id) async
  {
      Map res =  await Webservices.getData('accept-invitation', {"invitation_id":{"value":id}});
      if(res['status'].toString()=="1"){
        showSnackbar(res['message']);
        return true;
      }
      return false;
  }
  Future<bool>reject(String id) async
  {
    Map res =  await Webservices.getData('reject-invitation', {"invitation_id":{"value":id}});
    if(res['status'].toString()=="1"){
      showSnackbar(res['message']);
      return true;
    }
    return false;
  }
  getNotifications() async{
    loading = true;
    setState(() {});
    bool hasNewData=false;
    if(searchParams['page']['value'] == "1"){
      results=[];
    }
    Map res = await Webservices.getData('notifications', searchParams);
    if(res["status"].toString()=='1'){
      loading = false;
      setState(() {});
      if(res["data"].toString()!='null'){

        for(int m=0;m<res["data"]['data'].length;m++){
          hasNewData = true;
          res["data"]["data"][m]['loadA']=false;
          res["data"]["data"][m]['loadR']=false;
          results.add(res["data"]["data"][m]);
        }


      }

      if(hasNewData==true){
        searchParams['page']['value'] = (int.parse(searchParams['page']['value'])+1).toString();
        // page = page + 1;
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
    List Text=
    [
    'watch Now',
    'Live on',
    'Only on Hulu',
    'Netflix',
    'Prime Video'
    ];

    bool _keyboardVisible = false;
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: appBar(
          context: context,
          title: 'Notifications',
          titleColor: Colors.white,
          appBarColor: Colors.transparent,

      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImages.background_home),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topLeft
          ),
        ),
        child: ListView(
            controller: _controller,
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSizedBox,
            // vSizedBox4,
            // vSizedBox8,
            for(int i=0;i<results.length;i++)
              NotificationBox(
                  data:results[i],
                  onTap: (){
                    print("clicked-----"+results[i].toString());
                    notificationHandling(context,results[i]['other_data']);




                    // else if()
                  },
                onAccept: (String id) async{
                    print('idasdfasdfasdf'+id);
                    results[i]['loadA']=true;
                    setState(() {});
                    bool res = await accept(id);

                    if(res==true){
                      results[i]['firend_data']['status']='1';
                    }
                    results[i]['loadA']=false;
                    setState(() {});
                },
                onReject: (String id) async{
                  print('id'+id);
                  results[i]['loadR']=true;
                  setState(() {});
                  bool res = await reject(id);
                  results[i]['loadR']=false;

                  if(res==true){
                    results[i].remove('firend_data');

                    // results[i]['firend_data']['status']='1';
                  }
                  setState(() {});
                },

              ),

            if(loading==false)
              SizedBox(height:60),
            if(loading==false && results.length==0)
              Center(child: Padding(
                padding: const EdgeInsets.only(top:100),
                child: ParagraphText(text: "No data found", color: Colors.white,),
              )),

            if(loading==true && searchParams['page']['value'] == "1")
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
      ),
    );
  }
}
