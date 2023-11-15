import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/global_data.dart';
import 'package:livestream/constants/image_urls.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/pages/select_streaming_service_page.dart';
import 'package:livestream/widgets/CustomTexts.dart';
import 'package:livestream/widgets/buttons.dart';
import 'package:livestream/widgets/showSnackbar.dart';

import '../constants/auth.dart';
import '../constants/colors.dart';
import '../functions/navigation_functions.dart';
import '../services/webservices.dart';
import '../widgets/appbar.dart';
import '../widgets/select_country_item.dart';

enum SingingCharacter { one, two, three }
class CountryEditPage extends StatefulWidget {

  const CountryEditPage(
      {Key? key, }
  )
      : super(key: key);

  @override
  State<CountryEditPage> createState() => _CountryEditPageState();
}

class _CountryEditPageState extends State<CountryEditPage> {
  String country_code1="";
  String country_id1="";
  bool load=false;
  Map selectedServices = {};

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    country_code1 =country_code;
    country_id1=country_id;
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: appBar(
        context: context,
        title: 'Change Country',
        titleColor: Colors.white,
        appBarColor: Colors.black,
        // actions: [
        //   IconButton(onPressed: (){},
        //     icon: Icon(
        //       Icons.notifications,
        //     ),
        //   )
        // ]
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImages.background_home),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topLeft),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vSizedBox2,
                  ParagraphText(
                    text: 'Shestel will show you services and content available in that country',
                    fontSize: 18,
                    fontFamily: 'medium',
                  ),
                  vSizedBox2,

                    Expanded(
                      child: ListView.builder(
                          itemCount: countries.length,
                          itemBuilder: (context, i) {

                              return SelectCountryBox(
                                  country: countries[i],
                                  checked:(country_id1==countries[i]['id'].toString())?true:false,
                                  onChanged: (bool? value) {
                                    if(value!=null)
                                    setState(() {
                                      country_id1 = countries[i]['id'].toString();
                                      country_code1 = countries[i]['code'];

                                    });

                                  });
                            return Container();
                          }),
                    ),

                  vSizedBox2,



                  Center(
                    child: RoundEdgedButton(
                      text: 'Update',
                      textColor: Colors.white,
                      load:load,
                      color:MyColors.primaryColor,
                      width: MediaQuery.of(context).size.width - 200,
                      onTap: () async{
                        setState(() {
                          load=true;
                        });
                        Map data={
                          "country":{"value":country_id1, "type":"NO", "msg":""},
                        };
                        try{
                          await Webservices.postData('edit-profile', data,null);
                          print("request data----"+data.toString());
                          Map res = await Webservices.getData('user-detail', {"id":{'value':user_id}});
                          if(res['status'].toString()=="1") {
                            print("res data ----"+res['data'].toString());
                            await updateUserDetails(res['data']);
                            showSnackbar('Country updated successfully!');

                            getHomeData();
                            Navigator.pop(context);
                          }

                          setState(() {
                            load=false;
                          });
                        }
                        catch(e){
                          setState(() {
                            load=false;
                          });
                        }

                        // }
                      },
                    ),
                  ),
                  vSizedBox
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  getHomeData() async{
    setState((){
      load = true;
    });
    Map res = await Webservices.getData('home-page-data', {});
    if (res['status'].toString() == "1") { //user is new need to signup
      homePageData = res['data'];
      changed_country=true;
      getAllData();
    }
  }


  getAllData() async {
    Map res = await Webservices.getData('providers-list', {});
    if (res['status'].toString() == "1") {
      freeProviderList = res['data']['free'];
      subscriptionProviderList = res['data']['subscription'];
      purchaseList = res['data']['buy'];
      for (var i = 0; i < res['content'].length; i++) {
        res['content'][i]['checked'] = false;
      }
      contentList = res['content'];
      for (var i = 0; i < res['genres'].length; i++) {
        res['genres'][i]['checked'] = false;
      }
      genreList = res['genres'];
      countries = res['country'];
      mediaCategories = res['media_category'];
      allProviderList = res['all_providers'];
    }
  }
}

bool show = true;
bool hide = false;
bool hideone = false;
bool isSwitched = false;
bool isdone = false;
bool isdone2 = false;
bool isdone3 = false;

var images = [
  MyImages.netflix,
  MyImages.zee,
  MyImages.desney,
  MyImages.primebox
];




