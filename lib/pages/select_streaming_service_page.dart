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
import '../services/webservices.dart';
import 'homepage.dart';

import '../constants/colors.dart';

enum SingingCharacter { one, two, three }

class Select_Streaming_service_Page extends StatefulWidget {
  final String email;
  final Map? socialData;

  const Select_Streaming_service_Page(
      {Key? key, this.socialData, required this.email}
      )
      : super(key: key);

  @override
  State<Select_Streaming_service_Page> createState() =>
      _Select_Streaming_service_PageState();
}

class _Select_Streaming_service_PageState
    extends State<Select_Streaming_service_Page> {
  // List list = [  ];
  String type = "0"; //0-subscription//1-buy//2-free
  int count = 0;
  bool purchase_none = false;
  bool free_none = false;
  bool subscription_none = false;
  bool purchase_all = false;
  bool free_all = false;
  bool subscription_all = false;
  Map selectedServices = {};

  TextEditingController search = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getCount() {
    count = selectedServices.keys.toList().length;
    // for(var i=0;i<purchaseList.length;i++){
    //   if(purchaseList[i]['checked']==true){
    //     count=count+1;
    //   }
    // }
    // for(var i=0;i<subscriptionProviderList.length;i++){
    //   if(subscriptionProviderList[i]['checked']==true){
    //     count=count+1;
    //   }
    // }
    // for(var i=0;i<freeProviderList.length;i++){
    //   if(freeProviderList[i]['checked']==true){
    //     count=count+1;
    //   }
    // }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      // appBar: appBar(
      //   context: context,
      //   title: 'Streaming services ',
      //   titleColor: Colors.white,
      //   actions: [
      //     IconButton(onPressed: (){},
      //         icon: Icon(
      //           Icons.notifications,
      //         ),
      //     )
      //   ]
      // ),
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
                    text: 'Select Your Services and Click "Next"',
                    fontSize: 18,
                    fontFamily: 'medium',
                  ),
                  vSizedBox2,
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
                          if(freeProviderList.length>0)
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
                  if (type == '0')
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ParagraphText(
                            text: 'None of the above',
                            fontFamily: 'semibold',
                            fontSize: 18,
                            color: MyColors.primaryColor,
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                                unselectedWidgetColor: MyColors.primaryColor,
                                backgroundColor: Colors.white),
                            child: Checkbox(
                              checkColor: Colors.white,
                              // fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: subscription_none,
                              activeColor: MyColors.primaryColor,
                              onChanged: (bool? value) {
                                print('hellooooooooooooooo');
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  subscription_none = value!;
                                  subscription_all = false;
                                  if (value == true) {
                                    updateAll(false);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (type == '1')
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ParagraphText(
                            text: 'None of the above',
                            fontFamily: 'semibold',
                            fontSize: 18,
                            color: MyColors.primaryColor,
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                                unselectedWidgetColor: MyColors.primaryColor,
                                backgroundColor: Colors.white),
                            child: Checkbox(
                              checkColor: Colors.white,
                              // fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: purchase_none,
                              activeColor: MyColors.primaryColor,
                              onChanged: (bool? value) {
                                print('hellooooooooooooooo');
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  purchase_none = value!;
                                  purchase_all = false;

                                  if (value == true) {
                                    updateAll(false);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (type == '2')
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ParagraphText(
                            text: 'None of the above',
                            fontFamily: 'semibold',
                            fontSize: 18,
                            color: MyColors.primaryColor,
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                                unselectedWidgetColor: MyColors.primaryColor,
                                backgroundColor: Colors.white),
                            child: Checkbox(
                              checkColor: Colors.white,
                              // fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: free_none,
                              activeColor: MyColors.primaryColor,
                              onChanged: (bool? value) {
                                print('hellooooooooooooooo');
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  free_none = value!;
                                  free_all = false;
                                  if (value == true) {
                                    updateAll(false);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (type == '0')
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ParagraphText(
                            text: 'Select All',
                            fontFamily: 'semibold',
                            fontSize: 18,
                            color: MyColors.primaryColor,
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                                unselectedWidgetColor: MyColors.primaryColor,
                                backgroundColor: Colors.white),
                            child: Checkbox(
                              checkColor: Colors.white,
                              // fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: subscription_all,
                              activeColor: MyColors.primaryColor,
                              onChanged: (bool? value) {
                                print('hellooooooooooooooo');
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  subscription_all = value!;
                                  subscription_none = false;
                                  if (value == true) {
                                    updateAll(true);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (type == '1')
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ParagraphText(
                            text: 'Select All',
                            fontFamily: 'semibold',
                            fontSize: 18,
                            color: MyColors.primaryColor,
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                                unselectedWidgetColor: MyColors.primaryColor,
                                backgroundColor: Colors.white),
                            child: Checkbox(
                              checkColor: Colors.white,
                              // fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: purchase_all,
                              activeColor: MyColors.primaryColor,
                              onChanged: (bool? value) {
                                print('hellooooooooooooooo');
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  purchase_all = value!;
                                  purchase_none = false;
                                  if (value == true) {
                                    updateAll(true);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (type == '2')
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ParagraphText(
                            text: 'Select All',
                            fontFamily: 'semibold',
                            fontSize: 18,
                            color: MyColors.primaryColor,
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                                unselectedWidgetColor: MyColors.primaryColor,
                                backgroundColor: Colors.white),
                            child: Checkbox(
                              checkColor: Colors.white,
                              // fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: free_all,
                              activeColor: MyColors.primaryColor,
                              onChanged: (bool? value) {
                                print('hellooooooooooooooo');
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  free_all = value!;
                                  free_none = false;
                                  if (value == true) {
                                    updateAll(true);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                  Center(
                    child: RoundEdgedButton(
                      text: 'Next',
                      textColor: Colors.white,
                      color: (count > 0 ||
                              subscription_none == true ||
                              free_none == true ||
                              purchase_none == true)
                          ? MyColors.primaryColor
                          : MyColors.disable,
                      width: MediaQuery.of(context).size.width - 200,
                      onTap: () {
                        // if( isdone3 == true){
                        if (count > 0 ||
                            subscription_none == true ||
                            free_none == true ||
                            purchase_none == true) {
                            // print('---------s----'+selectedServices.toString());
                          List g = [];
                          // for(var i=0; i<providerList.length;i++){
                          //   if(providerList[i]['checked']==true){
                          //     g.add(providerList[i]['id'].toString());
                          //   }
                          // }
                          push(
                              context: context,
                              screen: Content_Preference_Page(
                                  email: widget.email,
                                  selectedServices: selectedServices,
                                  socialData: widget.socialData));
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
