import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/forgot.dart';
import 'package:livestream/pages/homepage.dart';
import 'package:livestream/pages/signup.dart';
import 'package:livestream/widgets/appbar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:livestream/widgets/customLoader.dart';
import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/buttons.dart';
import '../widgets/customtextfield.dart';

class Privacy_Page extends StatefulWidget {
  static const String id="Privacy_Page";
  const Privacy_Page({Key? key}) : super(key: key);

  @override
  State<Privacy_Page> createState() => _Privacy_PageState();
}

class _Privacy_PageState extends State<Privacy_Page> {
  String htmlData='';
  bool load = false;
@override
  void initState() {
    // TODO: implement initState
  getPrivacy();
    super.initState();
  }
  getPrivacy() async{
    load  =  true;
    setState(() {

    });
    Map res = await Webservices.getData('privacy', {});
    if (res['status'].toString() == "1") { //user is new need to signup
      htmlData = res['data'];
      load=false;
      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    bool _keyboardVisible = false;
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: appBar(
        context: context,
        title: 'Privacy Policy',
        titleColor: Colors.white,
        appBarColor: Colors.transparent,
        // actions: [
        //   IconButton(onPressed: (){},
        //     icon: Icon(
        //       Icons.notifications,
        //     ),
        //   )
        // ]
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImages.background_home),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topLeft
          ),
        ),
        child: load==true?CustomLoader() :Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSizedBox4,
              vSizedBox8,
              Container(
                height: MediaQuery.of(context).size.height - 110,
                child: SingleChildScrollView(
                  child: Html(data:htmlData,
                      style: {
                    "body": Style(
                      fontSize: FontSize(15.0),
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                    ),
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
