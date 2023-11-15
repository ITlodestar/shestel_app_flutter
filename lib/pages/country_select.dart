import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/global_data.dart';
import 'package:livestream/constants/image_urls.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/pages/select_streaming_service_page.dart';
import 'package:livestream/widgets/CustomTexts.dart';
import 'package:livestream/widgets/buttons.dart';

import '../constants/colors.dart';
import '../functions/navigation_functions.dart';
import '../services/webservices.dart';
import '../widgets/select_country_item.dart';

enum SingingCharacter { one, two, three }
class CountrySelectPage extends StatefulWidget {
  final String email;
  final Map? socialData;
  const CountrySelectPage(
      {Key? key, this.socialData, required this.email}
  )
      : super(key: key);

  @override
  State<CountrySelectPage> createState() => _CountrySelectPageState();
}

class _CountrySelectPageState extends State<CountrySelectPage> {

  bool load=false;
  Map selectedServices = {};

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,

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
                  vSizedBox6,
                  ParagraphText(
                    text: 'Shestel will show you services and content available in that country',
                    fontSize: 18,
                    fontFamily: 'medium',
                  ),


                    Expanded(
                      child: ListView.builder(
                          itemCount: countries.length,
                          itemBuilder: (context, i) {

                              return SelectCountryBox(
                                  country: countries[i],
                                  checked:(country_id==countries[i]['id'].toString())?true:false,
                                  onChanged: (bool? value) {
                                    if(value!=null)
                                    setState(() {
                                      country_id = countries[i]['id'].toString();
                                      country_code = countries[i]['code'];
                                      currency_symbol = countries[i]['currency_symbol']??"\$";
                                    });

                                  });
                            return Container();
                          }),
                    ),

                  vSizedBox2,



                  Center(
                    child: RoundEdgedButton(
                      text: 'Next',
                      textColor: Colors.white,
                      load:load,
                      color:MyColors.primaryColor,
                      width: MediaQuery.of(context).size.width - 200,
                      onTap: () async{
                          try{
                            setState(() {load=true;});
                            await getAllData();
                            setState(() {load=false;});
                            push(context: context, screen: Select_Streaming_service_Page(email:widget.email, socialData:widget.socialData));

                          }
                          catch(e){
                            setState(() {load=false;});
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

  Future getAllData() async {
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




