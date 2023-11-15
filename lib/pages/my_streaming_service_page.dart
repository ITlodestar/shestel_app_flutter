import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/global_data.dart';
import 'package:livestream/constants/image_urls.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/content_preference.dart';
import 'package:livestream/pages/privacy.dart';
import 'package:livestream/pages/terms.dart';
import 'package:livestream/widgets/CustomTexts.dart';
import 'package:livestream/widgets/appbar.dart';
import 'package:livestream/widgets/buttons.dart';
import 'package:livestream/widgets/customtextfield.dart';
import 'package:livestream/widgets/select_provider_item.dart';
import '../constants/auth.dart';
import '../services/webservices.dart';
import '../widgets/showSnackbar.dart';
import 'homepage.dart';

import '../constants/colors.dart';

enum SingingCharacter { one, two, three }

class My_Streaming_service_Page extends StatefulWidget {


  const My_Streaming_service_Page(
      {Key? key})
      : super(key: key);

  @override
  State<My_Streaming_service_Page> createState() =>
      _My_Streaming_service_PageState();
}

class _My_Streaming_service_PageState
    extends State<My_Streaming_service_Page> {
  // List list = [  ];
  String type = "0"; //0-subscription//1-buy//2-free
  int count = 0;
  bool loading=false;
  bool purchase_none = false;
  bool free_none = false;
  bool subscription_none = false;
  bool purchase_all = false;
  bool free_all = false;
  bool subscription_all = false;
  Map selectedServices = {};
  List streamingList = [];
  TextEditingController search = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    streamingList = user_data!['services'];
    autofill();
    getUserData();
    super.initState();
  }


  getUserData() async{


    // print('token-----'+user_data)

    Map res = await Webservices.getData('user-detail', {"id":{'value':user_id}});
    print('user response--'+res.toString());
    if(res['status'].toString()=="1") {
      await updateUserDetails(res['data']);
      streamingList = res['data']['services'];
      autofill();
    }

  }

  autofill(){

    for(int i=0;i<streamingList.length;i++){
      print("---------"+streamingList[i].toString());
       streamingList[i]['selected_plan_id'] = streamingList[i]['provider_plan_id'].toString();

      selectedServices[streamingList[i]['service_type']+"_"+streamingList[i]['provider_id'].toString()]=streamingList[i];

      // selectedServices[selected_Services[i]]['selected_plan_id']
    }
    setState(() {
    });

  }

  getCount() {
    count = selectedServices.keys.toList().length;
    setState(() {});
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: appBar(
        context: context,
        title: 'My services',
        titleColor: Colors.white,
        actions: [
          // IconButton(onPressed: (){},
          //     icon: Icon(
          //       Icons.notifications,
          //     ),
          // )
        ]
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
                  // vSizedBox6,
                  // ParagraphText(
                  //   text: 'Select Your Services and Click "Next"',
                  //   fontSize: 18,
                  //   fontFamily: 'medium',
                  // ),
                  // vSizedBox2,
                  CustomTextField(
                    controller: search,
                    onChange: (e) {
                      setState(() {});
                    },
                    hintText: 'Search for Streaming services ',
                    prefixIcon: MyImages.search,
                  ),
                  vSizedBox2,
                  // ParagraphText(text: 'Select all your streaming services & hit ‘Done’',
                  //   fontSize: 12,),
                  Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.white.withOpacity(0.20)))),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                type = '0';
                                // show = true;
                                // hide = false;
                                // hideone = false;
                              });
                            },
                            child: Column(
                              children: [
                                ParagraphText(
                                  text: 'Subscription',
                                  fontFamily: type == '0' ? 'medium' : 'light',
                                  color: type == '0'
                                      ? MyColors.primaryColor
                                      : Colors.white,
                                  fontSize: 16,
                                ),
                                vSizedBox05,
                                // if(show==true)
                                Container(
                                  height: 1,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: type == '0'
                                          ? MyColors.primaryColor
                                          : Colors.transparent),
                                )
                              ],
                            ),
                          ),
                          hSizedBox4,
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                type = '1';
                                // show = true;
                                // hide = false;
                                // hideone = false;
                              });
                            },
                            child: Column(
                              children: [
                                ParagraphText(
                                  fontFamily: type == '1' ? 'medium' : 'light',
                                  color: type == '1'
                                      ? MyColors.primaryColor
                                      : Colors.white,
                                  fontSize: 16,
                                  text: 'Buy/Rent',
                                ),
                                vSizedBox05,
                                // if(hide==true)
                                Container(
                                  height: 1,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: type == '1'
                                          ? MyColors.primaryColor
                                          : Colors.transparent),
                                )
                              ],
                            ),
                          ),
                          hSizedBox4,
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                type = '2';
                                // show = true;
                                // hide = false;
                                // hideone = false;
                              });
                            },
                            child: Column(
                              children: [
                                ParagraphText(
                                  fontFamily: type == '2' ? 'medium' : 'light',
                                  color: type == '2'
                                      ? MyColors.primaryColor
                                      : Colors.white,
                                  fontSize: 15,
                                  text: 'Free ',
                                ),
                                vSizedBox05,
                                // if(hideone==true)
                                Container(
                                  height: 1,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: type == '2'
                                          ? MyColors.primaryColor
                                          : Colors.transparent),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  vSizedBox,
                  if (type == '2') //free
                    Expanded(
                      child: ListView.builder(
                          itemCount: freeProviderList.length,
                          itemBuilder: (context, i) {
                            if (checkSearch(freeProviderList[i]))
                              return SelectProviderBox(
                                  provider: freeProviderList[i],
                                  checked:selectedServices['free'+"_"+freeProviderList[i]['id'].toString()]!=null?true:false,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        free_none = false;
                                        selectedServices['free'+"_"+freeProviderList[i]['id'].toString()] =freeProviderList[i];
                                      }
                                      else{
                                        selectedServices.remove('free'+"_"+freeProviderList[i]['id'].toString());
                                      }
                                    });



                                    getCount();
                                  });
                            return Container();
                          }),
                    ),
                  if (type == '1') //purchase
                    Expanded(
                      child: ListView.builder(
                          itemCount: purchaseList.length,
                          itemBuilder: (context, i) {
                            if (checkSearch(purchaseList[i]))
                              return SelectProviderBox(
                                  provider: purchaseList[i],
                                  checked:selectedServices['buy'+"_"+purchaseList[i]['id'].toString()]!=null?true:false,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        purchase_none = false;
                                        selectedServices['buy'+"_"+purchaseList[i]['id'].toString()] =purchaseList[i];
                                      }
                                      else{
                                        selectedServices.remove('buy'+"_"+purchaseList[i]['id'].toString());
                                      }
                                    });
                                    getCount();
                                  });
                            return Container();
                          }),
                    ),
                  if (type == '0') //subscription
                    Expanded(
                      child: ListView.builder(
                          itemCount: subscriptionProviderList.length,
                          itemBuilder: (context, i) {
                            if (checkSearch(subscriptionProviderList[i]))
                              return SelectProviderBox(
                                  provider: subscriptionProviderList[i],
                                  checked:selectedServices['subscription'+"_"+subscriptionProviderList[i]['id'].toString()]!=null?true:false,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        subscription_none = false;
                                        selectedServices['subscription'+"_"+subscriptionProviderList[i]['id'].toString()] =subscriptionProviderList[i];
                                        selectedServices['subscription'+"_"+subscriptionProviderList[i]['id'].toString()]['selected_plan_id']="0";
                                      }
                                      else{
                                        selectedServices.remove('subscription'+"_"+subscriptionProviderList[i]['id'].toString());
                                      }
                                    });
                                    print('-----'+subscriptionProviderList[i]['price'].toString());
                                    getCount();
                                    // if(value==true)
                                    if (selectedServices['subscription'+"_"+subscriptionProviderList[i]['id'].toString()]!=null && subscriptionProviderList[i]['price'].length>0 )
                                      showCustomDialogBox(
                                          marginhorizontal: 15,
                                          padleft: 16,
                                          context: context,
                                          child: Column(
                                            children: [
                                              vSizedBox,
                                              ParagraphText(
                                                text:
                                                'Add your expense to your profile, it\'s optional',
                                                textAlign: TextAlign.center,
                                                color: MyColors.black,
                                                fontSize: 20,
                                                fontFamily: 'semibold',
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(16.0),
                                                child: ParagraphText(
                                                  text:
                                                  '(Do you want to track your streaming\nexpenses on your profile?)',
                                                  textAlign: TextAlign.center,
                                                  color: MyColors.blackcolor70,
                                                  fontSize: 13,
                                                  fontFamily: 'semibold',
                                                ),
                                              ),
                                              vSizedBox2,
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  RoundEdgedButton(
                                                    text: 'Yes',
                                                    textColor: MyColors.white,
                                                    minWidth: 100,
                                                    verticalPadding: 0,
                                                    height: 30,
                                                    borderRadius: 30,
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      showDialog<void>(
                                                          context: context,
                                                          builder:
                                                              (context) =>
                                                              SimpleDialog(
                                                                backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                                clipBehavior:
                                                                Clip.antiAliasWithSaveLayer,
                                                                insetPadding:
                                                                EdgeInsets
                                                                    .all(0),
                                                                contentPadding:
                                                                EdgeInsets.all(
                                                                    16),
                                                                // title: Text('Allow Liza to see', textAlign: TextAlign.center,),
                                                                children: [
                                                                  SimpleDialogItem(
                                                                      prices:subscriptionProviderList[i]['price'],
                                                                      selected:selectedServices['subscription'+"_"+subscriptionProviderList[i]['id'].toString()]['selected_plan_id'],
                                                                      onChange:(String? v){
                                                                        print("selected------"+v.toString());
                                                                        selectedServices['subscription'+"_"+subscriptionProviderList[i]['id'].toString()]['selected_plan_id']=v;

                                                                        // setState((){});
                                                                      }

                                                                  ),
                                                                ],
                                                              ));
                                                    },
                                                  ),
                                                  hSizedBox2,
                                                  RoundEdgedButton(
                                                    text: 'No',
                                                    textColor: MyColors.white,
                                                    minWidth: 100,
                                                    height: 30,
                                                    verticalPadding: 0,
                                                    borderRadius: 30,
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                              vSizedBox,
                                            ],
                                          ));
                                  });
                            return Container();
                          }),
                    ),

                  vSizedBox2,



                  Center(
                    child: RoundEdgedButton(
                      text: 'Done',
                      load: loading,
                      textColor: Colors.white,
                      color:MyColors.primaryColor,
                      width: MediaQuery.of(context).size.width - 200,
                      onTap: () async{
                        Map data={};
                        List selected_Services = selectedServices.keys.toList();
                        if(selected_Services.length>0){
                          for(int i=0;i<selected_Services.length;i++){
                            String service_id = selected_Services[i].split("_")[1];
                            String service_type = selected_Services[i].split("_")[0];
                            data['services['+i.toString()+'][service_type]']= {"value":service_type};
                            data['services['+i.toString()+'][provider_id]']={"value":service_id};
                            if(service_type=='subscription'){
                              data['services['+i.toString()+'][provider_plan_id]'] = {"value":selectedServices[selected_Services[i]]['selected_plan_id']};
                              // data['services['+i.toString()+'][provider_plan_id]']="0";
                            }
                            else{
                              data['services['+i.toString()+'][provider_plan_id]']={"value":"0"};;
                            }


                          }



                        }

                        loading= true;
                        setState(() {

                        });
                        await Webservices.postData('edit-profile', data,null);
                        loading = false;
                        showSnackbar("streaming services updated successfully");
                        setState(() {});
                        print("request data----"+data.toString());
                        getUserData();



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

  updateAll(bool checked) {
    if (type == '0') {
      for (var i = 0; i < subscriptionProviderList.length; i++) {
        if (checked == true) {
          selectedServices['subscription' +
              '_' +
              subscriptionProviderList[i]['id'].toString()] = subscriptionProviderList[i];
        } else {
          selectedServices
              .remove('subscription' + '_' + subscriptionProviderList[i]['id'].toString());
        }
      }
    } else if (type == '1') {
      for (var i = 0; i < purchaseList.length; i++) {
        if (checked == true) {
          selectedServices['buy' + '_' + purchaseList[i]['id'].toString()] =
          purchaseList[i];
        } else {
          selectedServices
              .remove('buy' + '_' + purchaseList[i]['id'].toString());
        }
      }
    } else if (type == '2') {
      for (var i = 0; i < freeProviderList.length; i++) {
        if (checked == true) {
          selectedServices['free' + '_' + freeProviderList[i]['id'].toString()] =
          freeProviderList[i];
        } else {
          selectedServices
              .remove('free' + '_' + freeProviderList[i]['id'].toString());
        }
      }
    }

    getCount();
  }

  bool checkSearch(c) {
    // print("check search"+c['name']);
    if (c['provider_name'].toLowerCase().contains(search.text) ||
        search.text == '') {
      return true;
    } else {
      return false;
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

// final SimpleDialog dialog1 =
class SimpleDialogItem extends StatefulWidget {
  final List prices;
  final Function(String?) onChange;
  String selected;
  SimpleDialogItem({
    required this.onChange,
    required this.prices,
    required this.selected,
    Key? key
  }) : super(key: key);

  @override
  State<SimpleDialogItem> createState() => _SimpleDialogItemState();
}

class _SimpleDialogItemState extends State<SimpleDialogItem> {
  // SimpleDialogItem(this.prices);
  TextEditingController codeController = TextEditingController();

  TextEditingController namecontroller = TextEditingController();

  get selectedValue => null;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height - 470,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: MyColors.primaryColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ParagraphText(
              text: 'What is your subscription plan?',
              fontSize: 20,
              fontFamily: 'semibold',
              color: Colors.black,
            ),
            vSizedBox2,
            for(int m=0;m<widget.prices.length;m++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                  margin: EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: MyColors.primaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                            unselectedWidgetColor: MyColors.primaryColor,
                            backgroundColor: Colors.white),
                        child: Radio<String>(
                          value: widget.prices[m]['id'].toString(),
                          activeColor: MyColors.primaryColor,
                          groupValue: widget.selected,
                          onChanged: (String? value) {
                            widget.selected = value!;
                            setState(() {

                            });
                            widget.onChange(value);
                          },
                        ),
                      ),
                      Row(
                        children: [
                          hSizedBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ParagraphText(
                                text: '${currency_symbol}${widget.prices[m]['price']}/${widget.prices[m]['frequency']}',
                                fontSize: 16,
                                fontFamily: 'semibold',
                              ),
                              // ParagraphText(text: '\$15', fontSize: 13, fontFamily: 'medium', color: MyColors.primaryColor,)
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            vSizedBox2,
            Center(
              child: RoundEdgedButton(
                width: 150,
                text: 'Ok',
                textColor: Colors.white,
                fontSize: 16,
                height: 30,
                verticalPadding: 0,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
      // onPressed: onPressed,
    );
  }


}
