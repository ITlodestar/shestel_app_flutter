import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:livestream/functions/image_picker.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/forgot.dart';
import 'package:livestream/pages/homepage.dart';
import 'package:livestream/pages/signup.dart';
import 'package:livestream/widgets/appbar.dart';

import '../constants/auth.dart';
import '../constants/colors.dart';
import '../constants/global_data.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../functions/validations.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/buttons.dart';
import '../widgets/custom_phone_number_input.dart';
import '../widgets/customtextfield.dart';
import '../widgets/showSnackbar.dart';

class Account_detail_PAge extends StatefulWidget {
  static const String id="Account_detail_PAge";
  const Account_detail_PAge({Key? key}) : super(key: key);

  @override
  State<Account_detail_PAge> createState() => _Account_detail_PAgeState();
}

class _Account_detail_PAgeState extends State<Account_detail_PAge> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController address = TextEditingController();
  // PhoneNumber number = PhoneNumber(dialCode: '+1');
  String phone_code = "";
  Image? profile;
  bool load=false;
  File? prfl;
  @override
  void initState() {
    // TODO: implement initState
    print(user_data.toString());
    name.text = user_data!['first_name'] +" "+ user_data!['last_name'];
    email.text = user_data!['email'].toString();
    username.text = user_data!['username'].toString();
    autoFill();
    super.initState();
  }
  autoFill(){
    if(user_data!['phone']==null || user_data!['phone']==''){
      // number = PhoneNumber(dialCode: '+1', isoCode: 'US');
      phone.text='';
    }
    else{
      // number = PhoneNumber(dialCode: user_data!['phone_code'], isoCode:user_data!['iso_code'] );
      phone.text = user_data!['phone'];
      phone_code = user_data!['phone_code'];
    }


    address.text = user_data!['address']??'';
    if(user_data!['profile']!=null)
    profile = Image.network(user_data!['profile'], height: 70, width: 70, fit: BoxFit.cover,);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    bool _keyboardVisible = false;
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(
          context: context,
          title: 'Account Details',
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(MyImages.background_home),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topLeft
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vSizedBox2,
                  vSizedBox8,
                  vSizedBox4,
                  GestureDetector(
                    onTap: () async{

                       prfl = await openImagePicker(context,shouldCrop: true);
                      // prfl = await pickImage(shouldCrop:true);
                      if(prfl!=null){
                        profile = Image.file(prfl!, height: 70, width: 70, fit: BoxFit.cover,);
                      }
                      setState(() {

                      });
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: profile,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: MyColors.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Image.asset('assets/images/camera.png',
                              height: 8, width: 8, fit: BoxFit.fitHeight,),
                          ),
                        )
                      ],
                    ),
                  ),
                  vSizedBox2,
                  Row(
                    children: [
                      ParagraphText(
                        text: 'Username',
                        color: Colors.white,
                        fontFamily: 'light',
                        fontSize: 14,),
                      ParagraphText(
                        text: ' (Can’t edit)',
                        color: Colors.white.withOpacity(0.30),
                        fontFamily: 'light',
                        fontSize: 14,),
                    ],
                  ),
                  vSizedBox05,
                  CustomTextField(
                    controller: username,
                    hintText: '@john_peter',
                    enabled: false,
                  ),
                  vSizedBox2,
                  Row(
                    children: [
                      ParagraphText(
                        text: 'Name',
                        color: Colors.white,
                        fontFamily: 'light',
                        fontSize: 14,),
                      ParagraphText(
                        text: ' (Can’t edit)',
                        color: Colors.white.withOpacity(0.30),
                        fontFamily: 'light',
                        fontSize: 14,),
                    ],
                  ),
                  vSizedBox05,
                  CustomTextField(
                    enabled: false,
                      controller: name,
                      hintText: 'John Doe',
                  ),
                  vSizedBox2,

                  ParagraphText(
                    text: 'Phone Number',
                    color: Colors.white,
                    fontFamily: 'light',
                    fontSize: 14,),
                  vSizedBox05,
                  CustomPhoneNumberInput(
                    controller:phone,
                    phone_code:phone_code,
                    onChange: (String? v){
                      if(v!=null){
                        phone_code=v;
                        setState(() {

                        });
                      }

                    },
                    context:context,
                    hintText: 'Phone Number (optional)',
                  ),
                  // CustomPhoneNumberInput(
                  //   context: context,
                  //   // initialNumber: number,
                  //   controller: phone,
                  //   hintText: 'Phone Number (optional)',
                  //   // onInputChanged: (v){
                  //   //   number=v;
                  //   //   setState(() {
                  //   //
                  //   //   });
                  //   // },
                  //   // onInputValidated: (v){},
                  // ),
                  // CustomTextField(
                  //     controller: phone,
                  //     // prefixText: "+1",
                  //     prefixIcon: "assets/images/1.png",
                  //     hintText: '565454968',
                  // ),
                  vSizedBox2,
                  ParagraphText(
                    text: 'Address',
                    color: Colors.white,
                    fontFamily: 'light',
                    fontSize: 14,),
                  vSizedBox05,
                  CustomTextField(
                    controller: address,
                    hintText: '3564 Lowes Alley, Bowerston, United States',
                  ),
                  vSizedBox2,
                  Row(
                    children: [
                      ParagraphText(
                        text: 'Email',
                        color: Colors.white,

                        fontFamily: 'light',
                        fontSize: 14,),
                      ParagraphText(
                        text: ' (Can’t edit)',
                        color: Colors.white.withOpacity(0.30),
                        fontFamily: 'light',
                        fontSize: 14,),
                    ],
                  ),
                  vSizedBox05,
                  CustomTextField(
                    enabled: false,
                      controller: email,
                      hintText: 'xyz@email.com',
                  ),
                  vSizedBox4,

                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RoundEdgedButton(
                text: 'Update',
                load: load,
                textColor: Colors.white,
                width: MediaQuery.of(context).size.width - 200,
                onTap: () async{

                  Map data={
                    "first_name":{"value":user_data!['first_name'], "type":"NO", "msg":""},
                    "last_name":{"value":user_data!['last_name'], "type":"NO", "msg":""},
                  };
                  if(phone.text!=''){
                    data["phone"]={"value":phone.text.toString(), "type":"NO", "msg":""};
                    data["phone_code"]={"value":phone_code, "type":"NO", "msg":""};
                    // data["iso_code"]={"value":number.isoCode.toString(), "type":"NO", "msg":""};
                  }
                  if(address.text!=''){
                    data["address"]={"value":address.text.toString(), "type":"NO", "msg":""};
                  }

                  if(validateMap(data)==1){
                      Map<dynamic,dynamic>? files= null;
                      if(prfl!=null){
                        files={
                          "profile":prfl
                        };
                      }

                      // print("success-----" + data.toString());

                      load = true;
                      setState(() {});

                      Map res = await Webservices.postData('edit-profile', data,files);
                      print("success res-----" + res.toString());
                      load =false;
                      setState(() {});
                      if(res['status'].toString()=="1"){

                        showSnackbar(res['message']);
                        getUserData();

                      }
                      else{
                        showSnackbar(res['message']);
                      }



                  }



                },
              ),
            ),
          )
          // if(_keyboardVisible==false)
          // Positioned(
          //   bottom: 80,
          //   child:RoundEdgedButton(
          //   text: 'Skip',
          //   textColor: Colors.white,
          //   height: 35,
          //   width: 70,
          //   horizontalPadding: 0,
          //   ),
          // )
        ],
      ),
    );
  }


  getUserData() async{
    print('user response--'+user_id.toString());
    Map res = await Webservices.getData('user-detail', {"id":{'value':user_id}});

    if(res['status'].toString()=="1") {
        // user_data = res['data'];
        await updateUserDetails(res['data']);
        autoFill();

    }


  }
}
