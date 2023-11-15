import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:livestream/constants/auth.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/email_confirmation_page.dart';

import 'package:livestream/pages/privacy.dart';

import 'package:livestream/pages/terms.dart';
import 'package:livestream/widgets/showSnackbar.dart';
import 'package:open_mail_app/open_mail_app.dart';

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

bool is_checked = false;
bool isvisible = true;

final SimpleDialog dialog1 = SimpleDialog(
  backgroundColor: Colors.transparent,
  clipBehavior: Clip.antiAliasWithSaveLayer,
  insetPadding: EdgeInsets.all(0),
  contentPadding: EdgeInsets.all(30),
  // title: Text('Allow Liza to see', textAlign: TextAlign.center,),
  children: [
    SimpleDialogItem(),
  ],
);
class SimpleDialogItem extends StatelessWidget {
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
          borderRadius: BorderRadius.circular(15),
          // border: Border.all(
          //     color: MyColors.primaryColor
          // ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            vSizedBox2,
            Image.asset(MyImages.gmail, height: 56,),
            vSizedBox2,
            ParagraphText(
              text: 'Verify your email address',
              fontSize: 20,fontFamily: 'semibold',
              color: Colors.black,
            ),
            vSizedBox,
            ParagraphText(
              text: 'An email verification was sent the email address you provided when you started the registration process, please verify your email address to continue.',
              fontSize: 14,
              fontFamily: 'regular',
              color: Colors.black,
              textAlign: TextAlign.center,
            ),
            vSizedBox2,
            RoundEdgedButton(
              width: 150,
              text: 'Click to verify',
              textColor: Colors.white,
              fontSize: 16,
              height: 30,
              verticalPadding: 0,
              borderRadius: 10,
              horizontalPadding: 0,
              onTap: (){
                Navigator.pop(context);
                push(context: context, screen: Email_Confirmation_Page());
              },
            )

          ],
        ),
      ),
      // onPressed: onPressed,

    );
  }

  void setState(Null Function() param0) {}
}


class Complete_Profile_Page extends StatefulWidget {
  static const String id="Complete_Profile_Page";
  final String email;
  final String gen;

  final Map selectedServices;
  final Map? socialData;
  final String con;
  const Complete_Profile_Page({Key? key,this.socialData, required this.email, required this.gen, required this.selectedServices, required this.con}) : super(key: key);

  @override
  State<Complete_Profile_Page> createState() => _Complete_Profile_PageState();
}

class _Complete_Profile_PageState extends State<Complete_Profile_Page> {
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String phone_code="1";
  bool load=false;
  bool loadResend=false;
  String message="";
  bool available=false;
  // PhoneNumber number = PhoneNumber(isoCode: 'US', dialCode: '+1');
  @override
  void initState() {
    // TODO: implement initState
    for(int i=0;i<countries.length;i++){
      if(countries[i]['id'].toString() == country_id){
        phone_code = countries[i]['phone_code'].toString();
        break;
      }
    }
    print("complete scree------"+widget.socialData.toString());
    email.text =widget.email;
    if(widget.socialData!=null){
      first_name.text = widget.socialData!['first_name'];
      last_name.text = widget.socialData!['last_name'];
      password.text= DateTime.now().toString();

    }

    setState(() {

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    bool _keyboardVisible = false;

    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      // backgroundColor: MyColors.backcolor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImages.back),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topLeft
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                // height: MediaQuery.of(context).size.height - 100,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSizedBox8,
                    Center(
                      child: Image.asset(
                        MyImages.logo,
                        height: 90,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    vSizedBox4,
                    // for(var i=0; i<10; i++)
                    ParagraphText(
                      text: 'Complete your profile',
                      fontFamily: 'semibold',
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    // vSizedBox,
                    // ParagraphText(
                    //   text: 'Please enter additional personal information to complete your profile',
                    //   color: Colors.white,
                    //   fontFamily: 'light',
                    //   fontSize: 15,),
                    vSizedBox2,
                    // CustomTextField(
                    //     controller: namecontroller,
                    //     hintText: 'Create a username (ex.@theusername) ',
                    // ),
                    // vSizedBox2,
                    CustomTextField(
                        controller: first_name,
                        hintText: 'First name',
                    ),
                    vSizedBox,
                    vSizedBox05,
                    CustomTextField(
                        controller: last_name,
                        hintText: 'Last name',
                    ),
                    vSizedBox,
                    vSizedBox05,
                    CustomTextField(
                      controller: username,
                      hintText: 'Username',
                      onChange: (d) async{
                        if(username.text.length>4){
                          print('a-------'+username.text);
                          Map a = await Webservices.getData('check-username', {'username':{"value":username.text}});
                          if(a['status'].toString()=='0'){
                              message= a['message'];
                              available=false;
                          }
                          else if(a['status'].toString()=='1'){
                            message= a['message'];
                            available=true;
                          }
                          setState(() {

                          });
                          print('a-------'+a.toString());
                          // startProvider = a['data'];
                        // https://developers.shestel.com/api/check-username?username=anil
                        //     Webservices.getData('', data)
                        }
                        print("blurred......");
                      },
                    ),
                    if(username.text.length>4&&message!='' && available==false)
                    Padding(

                      padding:  EdgeInsets.only(left: 12.0, top:6),
                      child: Text(message, style:TextStyle(color:Colors.white),),
                    ),
                    vSizedBox,
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
                    // CustomTextField(
                    //   prefixIcon: "assets/images/1.png",
                    //   controller: phone,
                    //   hintText: 'Phone Number (optional)',
                    // ),
                    vSizedBox,
                    vSizedBox05,
                    CustomTextField(
                        controller: email,
                        hintText: 'Email address',
                    ),
                    vSizedBox,
                    vSizedBox05,
                    if(widget.socialData==null)
                    CustomTextField(
                      obscureText: isvisible,
                      controller: password,
                      hintText: 'Password',
                      suffixIcon:              GestureDetector(

                          onTap:
                              (){
                                setState((){
                                  // visiblity = !visiblity;
                                  isvisible = !isvisible;
                                });
                          },
                          child: Icon(
                            isvisible? Icons.visibility_outlined:
                            Icons.visibility_off_outlined,
                            color: MyColors.primaryColor,
                            size: 18,
                          )
                      )
                      ,
                      issufiximage: false,
                      visiblity: (){
                        setState((){
                            visiblity = !visiblity;
                            isvisible = !isvisible;
                          });
                      },
                    ),
                    vSizedBox2,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: ParagraphText(
                                text: 'By creating an account you consent to having your data collected to be used for generating recommendations, market research, and improving the service.',
                                fontSize: 10,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                              decoration: BoxDecoration(
                                // color: Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(-5 , 0),
                              child: Row(
                                children: [
                                  Theme(
                                    data:  Theme.of(context).copyWith(
                                        unselectedWidgetColor: MyColors.primaryColor,
                                        backgroundColor: Colors.white
                                    ),
                                    child:  Checkbox(
                                      visualDensity: VisualDensity(vertical: -4, horizontal:  -4),
                                      checkColor: Colors.white,
                                      // fillColor: MaterialStateProperty.resolveWith(getColor),
                                      value: is_checked,
                                      activeColor: MyColors.primaryColor,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          is_checked = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  hSizedBox,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                          onTap: (){
                                            push(context: context, screen: Terms_Page());
                                          },
                                          child: ParagraphText(
                                            text: 'Terms & Conditions',
                                            fontFamily: 'semibold',
                                            color: MyColors.primaryColor,
                                            underlined: true,
                                            fontSize: 12,
                                          )
                                      ),
                                      hSizedBox05,
                                      ParagraphText(text: 'and', color: Colors.white, fontSize: 12,),
                                      hSizedBox05,
                                      GestureDetector(
                                          onTap: (){
                                            push(context: context, screen: Privacy_Page());
                                          },
                                          child: ParagraphText(
                                            text: 'Privacy Policy',
                                            color: MyColors.primaryColor,
                                            fontFamily: 'semibold',
                                            underlined: true,
                                            fontSize: 12,
                                          )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            vSizedBox,

                          ],
                        ),
                        RoundEdgedButton(
                          text: 'Complete',
                          textColor: Colors.white,
                          fontSize: 20,
                          load: load,
                          horizontalPadding: 0,
                          width: MediaQuery.of(context).size.width - 200,
                          onTap: ()async{
                            // print('hellooooooooooooooo --- '+number.dialCode.toString());
                            FocusScope.of(context).requestFocus(new FocusNode());
                                                   Map data={
                              "first_name":{"value":first_name.text, "type":"NO", "msg":"Enter valid first name!"},
                              "last_name":{"value":last_name.text, "type":"NO", "msg":"Enter valid last name!"},
                              "username":{"value":username.text, "type":"USERNAME", "msg":"Please enter valid username!"},
                              "phone":{"value":phone.text, "type":"NO", "msg":""},
                              "phone_code":{"value":phone_code, "type":"NO", "msg":""},
                              // "iso_code":{"value":number.isoCode.toString(), "type":"NO", "msg":""},
                              "email":{"value":email.text, "type":"EMAIL", "msg":"Please enter valid email!"},
                              "password":{"value":password.text, "type":"NO", "msg":"Please enter password!"},
                              "content_ids":{"value":widget.con, "type":"NO", "msg":""},
                              "genres_ids":{"value":widget.gen, "type":"NO", "msg":""},
                            };
                            // data.addAll(widget.sub);
                            data['country']={"value":country_id};
                            if(validateMap(data)==1){

                              if(widget.socialData!=null){
                                if(widget.socialData!['gmail_id']!=null){
                                  data['gmail_id']={"value":widget.socialData!['gmail_id']};

                                }
                                else if(widget.socialData!['facebook_id']!=null){
                                  data['facebook_id']={"value":widget.socialData!['facebook_id']};
                                }
                                  else if(widget.socialData!['apple_id']!=null){
                                  data['apple_id']={"value":widget.socialData!['apple_id']};
                                }
                              }

                             if(is_checked==true){
                                print("success-----" + data.toString());
                                List selectedServices = widget.selectedServices.keys.toList();
                                if(selectedServices.length>0){
                                  for(int i=0;i<selectedServices.length;i++){
                                    String service_id = selectedServices[i].split("_")[1];
                                    String service_type = selectedServices[i].split("_")[0];
                                    data['services['+i.toString()+'][service_type]']= {"value":service_type};
                                    data['services['+i.toString()+'][provider_id]']={"value":service_id};
                                    if(service_type=='subscription'){
                                      data['services['+i.toString()+'][provider_plan_id]'] = {"value":widget.selectedServices[selectedServices[i]]['selected_plan_id']??'0'};
                                      // data['services['+i.toString()+'][provider_plan_id]']="0";
                                    }
                                    else{
                                      data['services['+i.toString()+'][provider_plan_id]']={"value":"0"};;
                                    }

                                    print("------s"+service_id+"-"+service_type);
                                  }

                                  print("post data-------"+data.toString());

                                }

                                // return;


                                load = true;
                                setState(() {});
                                print("------------data-------------"+data.toString());


                                Map res = await Webservices.postData('register', data, null);
                                print("success res-----" + res.toString());
                                load =false;
                                setState(() {});
                                if(res['status'].toString()=="1"){
                                  token = res['data']['token'];
                                  user_id = res['data']['id'].toString();
                                  if(widget.socialData==null){
                                    verifyEmail();
                                  }
                                  else{
                                    updateToken(token);
                                    await updateUserDetails(res['data']);

                                    pushAndRemoveUntil(context: context, screen: Email_Confirmation_Page());
                                  }



                                  // pushAndRemoveUntil(context: context, screen: Email_Confirmation_Page());
                                }
                                else{
                                  showSnackbar(res['message']);
                                }
                                // setState(() {
                                //
                                // });
                                // print(res.toString());
                              }
                              else{
                                showSnackbar('Please accept terms and conditions');
                              }
                              setState(() {

                              });

                            }

                            // push(context: context, screen: Home_Page());
                            // showDialog<void>(context: context, builder: (context) => dialog1);
                          },
                        ),
                      ],
                    ),
                    vSizedBox2,
                    // CustomTextField(
                    //     controller: namecontroller,
                    //     hintText: 'Zip code',
                    // ),
                    // vSizedBox2,
                  ],
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
            //     child:
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  getUserData(Timer timer) async{
    Map res = await Webservices.getData('user-detail', {"id":{'value':user_id}});
    print('user response--'+res.toString());
    if(res['status'].toString()=="1") {
        if(res['data']['email_verified'].toString()=="1"){
           timer.cancel();
           Navigator.pop(context);
           updateToken(token);
           await updateUserDetails(res['data']);
           pushAndRemoveUntil(context: context, screen: Email_Confirmation_Page());
        }
    }


  }

  resendVerificationMail(setState,context) async{

    setState(() { loadResend = true; });
    Map res = await Webservices.postData('resent-verification-link', {"id":{'value':user_id}},null);
    setState(() { loadResend = false; });
    print('user response--'+res.toString());
    if(res['status'].toString()=="1") {

      showSnackbar(res['message']);
    }
  }

  verifyEmail() async{
    int i=0;
    Timer.periodic(
        Duration(seconds: 5),
        (timer){
          getUserData(timer);
          // timer.cancel();
        }
    );
    await showCustomDialogBox(
        marginhorizontal: 35,
        padtop: 24,
        bottom: 30,
        border: false,
        context: context,
        child: Column(
          children: [
            Image.asset(MyImages.gmail, height: 56,),
            vSizedBox,
            vSizedBox05,
            MainHeadingText(text: 'Verify your email address'),
            vSizedBox,
            vSizedBox05,
            RoundEdgedButton(
              onTap: () async{
                var result = await OpenMailApp.openMailApp(
                  nativePickerTitle: 'Select email app to open',
                );
              },
              text: 'Verify',
              textColor: MyColors.white,
              horizontalPadding: 0,
              minWidth: 150,
              height: 30,
              fontSize: 15,
              verticalPadding: 0,

            ),
            vSizedBox,

            StatefulBuilder(
              builder: (context,setState) {
                return GestureDetector(child: loadResend==true?Container(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator()):Text("Resend Email"),onTap: (){
                  resendVerificationMail(setState, context);
                },);
              }
            )
          ],
        )
    );


  }
}
