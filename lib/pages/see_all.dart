import 'dart:developer';

import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/global_data.dart';
import '../constants/sized_box.dart';
import '../functions/navigation_functions.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/MediaBox.dart';
import '../widgets/appbar.dart';
class SeeAllPage extends StatefulWidget {

  final String slug;
  final String heading;
  final MediaType media_type;

  const SeeAllPage({
    required this.slug,
    required this.media_type,
    required this.heading,
    Key? key
  }) : super(key: key);

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  int page=1;
  List all_items=[];
  ScrollController _controller =
  ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  bool loading = false;

  getAllData() async{


    setState((){
      loading = true;
    });
    if (page == 1) {
      all_items = [];
    }

    Map res = await Webservices.getData('see-all-category', {

      "media_category":{"value":widget.slug},
      "media_type":{"value":widget.media_type.name},
      "page":{"value":page.toString()},
    });
    setState(() {
      loading = false;
    });

    if (res['status'].toString() == "1") { //user is new need to signup
      log('checking ----- '+res.toString());
      if(page==1){
        all_items = [];//res['data']['data'];
      }
      if (res['data']['data'].length > 0) {
        for (var i = 0; i < res['data']['data'].length; i++) {
          all_items.add(res['data']['data'][i]);
          // log('increasing - ' + res['invoice_list'][i].toString());
        }
        page = page + 1;
      }


      // homePageData = res['data'];
      setState((){ });
    }


  }

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
          getAllData();
          //  get_transactions();
        }

        // });
      }
    });


    getAllData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.black,
        appBar:
        appBar(context: context, title: widget.heading, titleColor: Colors.white,
            // leading: GestureDetector(
            //   onTap: (){
            //     scaffoldKey.currentState?.openDrawer();
            //   },
            //   child: Icon(
            //     Icons.menu_outlined,
            //   ),
            // ),
            // implyLeading: false,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                ),
              )
            ]),
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage(MyImages.background_home),
          //       fit: BoxFit.fitWidth,
          //       alignment: Alignment.topLeft),
          // ),
          color: MyColors.black,
          child: ListView(
            controller: _controller,

              children: [


                vSizedBox05,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Wrap(

                    runSpacing: 16,
                    spacing: 8,
                    children: [
                      for(var i = 0; i < all_items.length; i++)
                       MediaBox(
                           marginRight: (i%2==0)?8:0,
                           data:all_items[i],
                           onTap:(){
                             goDetails(context: context, data:all_items[i], mediaType: widget.media_type);

                       }),



                    ],
                  ),
                ),
                if(loading==false)
                SizedBox(height:60),

                if(loading==true && page==1)
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
