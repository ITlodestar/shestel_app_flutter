import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:livestream/constants/auth.dart';
import 'package:livestream/pages/lets_start_page.dart';
import 'package:livestream/pages/tabs.dart';

import '../constants/colors.dart';
import '../constants/global_data.dart';
import '../constants/image_urls.dart';
import '../functions/navigation_functions.dart';
import '../functions/onesignal.dart';
import '../services/webservices.dart';
// Toggle this to cause an async error to be thrown during initialization
// and to test that runZonedGuarded() catches the error
const _kShouldTestAsyncErrorOnInit = false;

// Toggle this for testing Crashlytics in your app locally.
const _kTestingCrashlytics = false;

class SplashScreenPage extends StatefulWidget {
  static const String id = "splash";
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    // initOneS
    checkUserLoginStatus();
    _initializeFlutterFire();
    // configLoading();

    // Future.delayed(const Duration(seconds: 3)).then((value) async{
    //
    //
    //
    //
    // });
  }


  Future<void> _initializeFlutterFire() async {
    if (_kTestingCrashlytics) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    }

    if (_kShouldTestAsyncErrorOnInit) {
      await _testAsyncErrorOnInit();
    }
  }

  Future<void> _testAsyncErrorOnInit() async {
    Future<void>.delayed(const Duration(seconds: 2), () {
      final List<int> list = <int>[];
      print(list[100]);
    });
  }



  void configLoading() {
    EasyLoading.instance

      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 60.0
      ..radius = 10.0
      ..backgroundColor = Colors.blue
      ..indicatorColor = MyColors.primaryColor
      ..maskColor = Colors.blue
      ..userInteractions = true
      // ..indicatorType = EasyLoadingIndicatorType.
      ..dismissOnTap = false;
  }

  getHomePageData()async{
    Map res = await Webservices.getData('home-page-data', {});
    if (res['status'].toString() == "1") { //user is new need to signup
      log(res.toString());
      // for (var i = 0; i < res['data'].length; i++) {
      //   res['data'][i]['checked'] = false;
      // }
      homePageData = res['data'];

    }
  }

  checkUserLoginStatus()async{
    if(!kIsWeb)
   await initOneSignal("5c1adaca-ecb1-4d97-a054-b38c8984f358");


    if ((await isUserLoggedIn()) == true) {
      user_data = await getUserDetails();
      if(user_data!['country']!=null){
        country_id = user_data!['country']!['id'].toString();
        country_code = user_data!['country']!['code'].toString();
      }

      print('this is userdata'+user_data.toString());
      token = await getAuthToken();
      user_id = await getCurrentUserId();
      // Map a = Webservices.getData('providers-home', {});
      getAllData();
      getstartp();
      await getHomePageData();
      pushReplacement(context: context, screen: tabs_second_page());
    } else {
      Map a = await Webservices.getData('providers-home', {});
      startProvider = a['data'];
      countries = a['country'];
      print("country----"+a['country'].toString());
      print("current country----"+a['currentCountry'].toString());
      country_id = a['currentCountry']['id'].toString();
      country_code = a['currentCountry']['code'];
      currency_symbol = a['currentCountry']['currency_symbol']??"\$";
      // currentCountry
      getAllData();
      pushReplacement(context: context, screen: Lets_started_Page());
    }
  }
  getstartp() async{
    Map res = await Webservices.getData('providers-home', {});
    startProvider = res['data'];
    countries = res['country'];
    country_id = res['currentCountry']['id'].toString();
    country_code = res['currentCountry']['code'];
    currency_symbol = res['currentCountry']['currency_symbol']??"\$";
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
      // countries = res['country'];
      mediaCategories = res['media_category'];
      allProviderList = res['all_providers'];
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        MyImages.splash,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );
  }



}
