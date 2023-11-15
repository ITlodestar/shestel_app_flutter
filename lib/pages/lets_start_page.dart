import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:livestream/constants/colors.dart';
import 'package:livestream/constants/image_urls.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/functions/globalFunctions.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/functions/validations.dart';
import 'package:livestream/pages/country_select.dart';
import 'package:livestream/pages/select_streaming_service_page.dart';
import 'package:livestream/pages/tabs.dart';
import 'package:livestream/services/webservices.dart';
import 'package:livestream/widgets/buttons.dart';
import 'package:livestream/widgets/customtextfield.dart';
import 'package:livestream/widgets/provider-box.dart';
import 'package:livestream/widgets/showSnackbar.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../constants/auth.dart';
import '../constants/global_data.dart';
import '../widgets/CustomTexts.dart';
import 'email_confirmation_page.dart';
import 'forgot.dart';
import 'dart:io' show Platform;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Lets_started_Page extends StatefulWidget {
  const Lets_started_Page({Key? key}) : super(key: key);

  @override
  State<Lets_started_Page> createState() => _Lets_started_PageState();
}
final firebaseAuth = FirebaseAuth.instance;
class _Lets_started_PageState extends State<Lets_started_Page> {
  final auth = FacebookAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  // int lastCall=0;
  bool load =false;
  bool socialLoading=false;
  bool showPassword =false;
  
  String title="Let\'s get started!";
  late FocusNode myFocusNode;// = FocusNode();
  //
  // NativeAd? _ad;



  @override
  void initState() {
    // TODO: implement initState


    // email.text="mizannitdgp@gmail.com";
    myFocusNode = FocusNode();
    super.initState();
  }



  // Future<InitializationStatus> _initGoogleMobileAds() {
  //   // TODO: Initialize Google Mobile Ads SDK
  //   return MobileAds.instance.initialize();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(MyImages.back),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topLeft
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  vSizedBox4,
                  vSizedBox8,
                  Image.asset(MyImages.single_logo,
                  height: 68,
                  ),
                  vSizedBox,
                  ParagraphText(text: title, fontSize: 30, fontFamily: 'semibold',),
                  vSizedBox4,
                  // Image.asset(MyImages.lets_start_img),
                  // Container(
                  //   height: 165,
                  //   child: ListView(
                  //     scrollDirection: Axis.horizontal,
                  //     padding: EdgeInsets.symmetric(horizontal: 16),
                  //     children: [
                  //       for(int i=0;i<startProvider.length;i++)
                  //       ProviderBox(img: startProvider[i]['logo_path']),
                  //
                  //     ],
                  //   ),
                  // ),
                  Container(
                    height:165,
                    // padding: EdgeInsets.only(),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 165,
                        autoPlay:true,
                        viewportFraction: 0.34,
                        autoPlayInterval: Duration(milliseconds:3000),
                        initialPage: 0,
                        enlargeCenterPage: false,
                        // disableCenter: true,
                        reverse: false,
                        enableInfiniteScroll: true,

                        // pauseAutoPlayOnTouch: Duration(seconds: 10),
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          setState(
                                () {
                              // _currentIndex = index;
                            },
                          );
                        },
                      ),
                      items: startProvider.map <Widget>((img){
                        return Builder(
                          builder: (BuildContext context) {
                            return

                              ProviderBox(img: img['logo_path']);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  vSizedBox4,


                  // Container(child:Text('My Testing', style:TextStyle(color:Colors.white))),


                  if(socialLoading==false)
                  Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomTextField(

                          // focusNode: myFocusNode,
                          // suffixIcon:
                          focusNode: myFocusNode,
                          controller: email,
                          enabled: (showPassword==false),
                          hintText: 'Enter your email address',
                          border: Border.all(
                            color: MyColors.primaryColor,
                          ),
                          borderradius: 30,

                        ),

                      ),
                      if(showPassword==true)
                        Container(
                          width:double.infinity,
                          padding: EdgeInsets.only(top:5,right:20),
                          child:GestureDetector(
                              onTap: (){
                                print("hello");
                                showPassword=false;
                                title="Let\'s get started!";
                                setState(() {

                                });
                                myFocusNode.requestFocus();
                              },
                              child: Text(

                                "Change Email?", textAlign: TextAlign.end, style:TextStyle(color:Colors.white, fontSize: 12),)
                          ),
                        ),

                      vSizedBox2,
                      if(showPassword==true)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomTextField(
                            controller: password,
                            hintText: 'Password',
                            obscureText: true,
                            border: Border.all(
                              color: MyColors.primaryColor,
                            ),
                            borderradius: 30,

                          ),
                        ),

                      if(showPassword==true)
                        vSizedBox4,
                      RoundEdgedButton(
                        text: 'Continue',
                        load:load,
                        textColor: Colors.white,
                        width: MediaQuery.of(context).size.width - 200,
                        borderRadius: 8,
                        onTap: (){
                          check_email();
                          //p ush(context: context, screen: Select_Streaming_service_Page());
                        },
                      ),
                      vSizedBox,
                      if(showPassword==true)
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: ParagraphText(
                                  text: 'Forgot Password?',
                                  color:Colors.white,
                                  fontFamily: 'light', fontSize: 14,),
                                onTap: (){
                                  push(context: context, screen: ForgotPage());
                                },
                              )
                            ],
                          ),
                        ),
                      vSizedBox2,

                      if(showPassword==false)
                        ParagraphText(text: 'Or continue with'),
                      vSizedBox,
                      if(showPassword==false)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                   if (Platform.isIOS)
                            Container(
                              margin:EdgeInsets.only(right:20),
                              height:48,
                              width:48,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: GestureDetector(
                                  child: Image.asset(MyImages.apple, height: 45, width: 45,),
                                  onTap: ()async{
                                    _signInWithApple();
                              
           
                                  }
                              ),
                            ),
                            Container(

                              height:48,
                              width:48,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: GestureDetector(
                                  child: Image.asset(MyImages.google, height: 45, width: 45,),
                                  onTap: (){
                                    _signInWithGoogle();
                                  }
                              ),
                            ),
                              // if (Platform.isAndroid)
                            hSizedBox2,
                             // if (Platform.isAndroid )
                            Container(
                              height:48,
                              width:48,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: GestureDetector(
                                child: Image.asset(MyImages.fb, height: 55, width: 55,),
                                onTap: (){
                                  print("facebook login clicke");
                                  _facebookLogin();
                                  // showSnackbar("Coming soon!");
                                },
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  if(socialLoading==true)
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


                  // NativeAd(
                  //   adUnitId: AdHelper.nativeAdUnitId,
                  //   factoryId: 'listTile',
                  //   request: AdRequest(),
                  //   listener: NativeAdListener(
                  //     onAdLoaded: (ad) {
                  //       setState(() {
                  //         _ad = ad as NativeAd;
                  //       });
                  //     },
                  //     onAdFailedToLoad: (ad, error) {
                  //       // Releases an ad resource when it fails to load
                  //       ad.dispose();
                  //       print('Ad load failed (code=${error.code} message=${error.message})');       },
                  //   ),
                  // )


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  check_email() async{
   if(showPassword==false){
     Map data={
       "email":{"value":email.text, "type":"EMAIL", "msg":"Please enter valid email"}
     };

     if(validateMap(data)==1){
       load = true;
       setState(() {

       });
       Map res = await Webservices.getData('check-email', data);
       load =false;
       setState(() {

       });
       print(res.toString());
       if(res['status'].toString()=="1"){ //user is new need to signup
         // push(context: context, screen: CountrySelectPage(email:email.text));
         push(context: context, screen: Select_Streaming_service_Page(email:email.text));
       }
       else{//user is existing need to login
         String name = res['data']['first_name'];
         // name[0]=name[0].toUpperCase();
         title = "Welcome Back, "+name.toCapitalize()+"!";
         showPassword = true;


         setState(() {

         });
       }
     }

   }
   else{
     Map data={

       "email":{"value":email.text, "type":"EMAIL", "msg":"Please enter valid email"},
       "password":{"value":password.text, "type":"NO", "msg":"Please enter password"},

     };

     if(validateMap(data)==1){

         print("success-----" + data.toString());
         load = true;
         setState(() {});
         Map res = await Webservices.postData('login', data,null);
         print("success res-----" + res.toString());
         load =false;
         setState(() {});
         if(res['status'].toString()=="1"){
           token = res['data']['token'];
           user_id = res['data']['id'].toString();
           if(res['data']['email_verified'].toString()=="1") {
             updateToken(token);
             print(res['data']);
             await updateUserDetails(res['data']);


             pushAndRemoveUntil(context: context, screen: tabs_second_page());
             // p ushA ndRemoveUntil(context: context, screen: Email_Confirmation_Page());
           }
           else{
             verifyEmail();
           }




         }
         else{
           showSnackbar(res['message']);
         }
       }

       setState(() {

       });

     }
   }
  verifyEmail(){
    int i=0;
    Timer.periodic(
        Duration(seconds: 5),
            (timer){
          getUserData(timer);
          // timer.cancel();
        }
    );
    showCustomDialogBox(
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

            )
          ],
        )
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

  void _signInWithApple() async {
    setState(() {     socialLoading =true;  });



          try {
                         final credential = await SignInWithApple.getAppleIDCredential(
                            scopes: [
                            AppleIDAuthorizationScopes.email,
                            AppleIDAuthorizationScopes.fullName,
                            ],
                            );


                            //  showSnackbar('try chala--'+credential.email.toString());


   if(credential.userIdentifier==null){
     
     socialLoading=false;
     setState(() {
       
     });
     return;
   }
   Map dataa={
        "apple_id":{"value":credential.userIdentifier}
      };
      if(credential.email !=null){
        dataa['email']={"value":credential.email};
      }
      Map ress = await Webservices.postData('social-login', dataa,null);
      if(ress['status'].toString()=="1"){
                // showSnackbar('already user');
        token = ress['data']['token'];
        user_id = ress['data']['id'].toString();
          updateToken(token);
          await updateUserDetails(ress['data']);
        setState(() {     socialLoading =false;  });
          pushAndRemoveUntil(context: context, screen: tabs_second_page());
      }
      else if (ress['status'].toString()=="2"){
        // showSnackbar('new user');
        print("2222222222222222222222222");
        print('the user data is ');
        String first_name = credential.givenName.toString();
        String last_name = credential.familyName.toString();
      



        Map<String, dynamic> data = {
          'apple_id': credential.userIdentifier,
          'first_name':first_name,
          'last_name':last_name,
        };
        setState(() {     socialLoading =false;  });
        // push(context: context, screen: Select_Streaming_service_Page(email:credential.email??"", socialData:data));
        push(context: context, screen: Select_Streaming_service_Page(email:credential.email??"", socialData:data));
        // push(context: context, screen: CountrySelectPage(email:credential.email??"", socialData:data));
        print(data);
      }



      // return _userFromFirebase(authResult.user);


    } 
    
                                  
    catch(e){
          setState(() {     socialLoading =true;  });
                                      print(e);
                                      
                                      showSnackbar(e.toString());
     }





    // GoogleSignIn googleSignIn = GoogleSignIn();
    // GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
    // if (googleAccount != null) {
    //   GoogleSignInAuthentication googleAuth =
    //   await googleAccount.authentication;
    //   final authResult = await firebaseAuth.signInWithCredential(
    //     AppleAuthProvider.credential("h"
    //       // idToken: credential.idToken,
    //       // rawNonce: googleAuth.accessToken,
    //     ),
    //   );

   
  }


  void _signInWithGoogle() async {
    setState(() {     socialLoading =true;  });
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      GoogleSignInAuthentication googleAuth =
      await googleAccount.authentication;
      final authResult = await firebaseAuth.signInWithCredential(
        GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ),
      );

      Map dataa={
        "gmail_id":{"value":authResult.user?.uid},
        "email":{"value":authResult.user?.email}
      };
      Map ress = await Webservices.postData('social-login', dataa,null);
      if(ress['status'].toString()=="1"){
        token = ress['data']['token'];
        user_id = ress['data']['id'].toString();
          updateToken(token);
          await updateUserDetails(ress['data']);
        setState(() {     socialLoading =false;  });
          pushAndRemoveUntil(context: context, screen: tabs_second_page());
      }
      else if (ress['status'].toString()=="2"){
        print("2222222222222222222222222");
        print('the user data is ');
        String first_name = "";
        String last_name = "";
        String? name = authResult.user?.displayName;
        if(name!=null){
          List sn = name.split(" ");
          first_name = sn[0];
          sn.removeAt(0);
          last_name = sn.join(" ");
        }


        Map<String, dynamic> data = {
          'gmail_id': authResult.user?.uid,
          'first_name':first_name,
          'last_name':last_name,
        };
        setState(() {     socialLoading =false;  });
        // push(context: context, screen: CountrySelectPage(email:authResult.user?.email??"", socialData:data));
        push(context: context, screen: Select_Streaming_service_Page(email:authResult.user?.email??"", socialData:data));
        print(data);
      }



      // return _userFromFirebase(authResult.user);


    } else {
      setState(() {     socialLoading =false;  });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something Wrong happened!!')));
    }
  }

  _facebookLogin() async{
    print("facebook login clicked");
    try{
      setState(() {     socialLoading =true;  });
      // EasyLoading.show(status: '');
      var result = await auth.login();
      if(result.status.name=='success'){
          String? uid = result.accessToken?.userId;
          print('user....idd--'+uid.toString());
          // 104886695775849
          // 104886695775849
          var r = await auth.getUserData();
          Map dataa={
            "facebook_id":{"value":uid??''},
            "email":{"value":r['email']}
          };
          Map ress = await Webservices.postData('social-login', dataa,null);
          if(ress['status'].toString()=="1"){
            token = ress['data']['token'];
            user_id = ress['data']['id'].toString();
            updateToken(token);
            await updateUserDetails(ress['data']);
            setState(() {     socialLoading =false;  });
    
            pushAndRemoveUntil(context: context, screen: tabs_second_page());
          }
          else if (ress['status'].toString()=="2"){
            print("2222222222222222222222222");
            print('the user data is ');
            String first_name = "";
            String last_name = "";
            String? name = r['name'];//displayName;
            if(name!=null){
              List sn = name.split(" ");
              first_name = sn[0];
              sn.removeAt(0);
              last_name = sn.join(" ");
            }
    
    
            Map<String, dynamic> data = {
              'facebook_id': uid,
              'first_name':first_name,
              'last_name':last_name,
            };
            setState(() {     socialLoading =false;  });
    
            push(context: context, screen: CountrySelectPage(email:r['email'], socialData:data));
            print(data);
          }
          print('aaa------'+r['name']);
      }
      else{
        setState(() {     socialLoading =false;  });
      }
    
    }
    catch(e){
      setState(() {     socialLoading =false;  });
      // EasyLoading.dismiss();
      print('facemier'+e.toString());
    }



  }

}
