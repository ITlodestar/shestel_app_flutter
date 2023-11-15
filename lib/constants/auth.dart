import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import 'global_data.dart';

Future updateUserDetails(details) async{
  SharedPreferences sharedUser = await SharedPreferences.getInstance();
  user_id = details['id'].toString();
  user_data = details;
  String user = jsonEncode(details);
  sharedUser.setString('user_details', user);
  if(user_data!['country']!=null){
    country_id = user_data!['country']!['id'].toString();
    country_code = user_data!['country']!['code'].toString();
    currency_symbol = user_data!['country']!['currency_symbol'].toString();

  }
}

void updateToken(String token) async{
  token = token;

  SharedPreferences shared_User = await SharedPreferences.getInstance();
  shared_User.setString('auth_token', token);
}
Future  getAuthToken() async{
  SharedPreferences shared_User = await SharedPreferences.getInstance();

  String? auth_token = await shared_User.getString('auth_token');
  if(auth_token==null){
    return "0";
  }
  else{
    return auth_token.toString();
  }
  //return auth_token!;//.toString();
}


Future getUserDetails() async{
  SharedPreferences shared_User = await SharedPreferences.getInstance();
  String userMap = await shared_User.getString('user_details')!;
  String userS = (userMap==null)?'':userMap;
  // log('this is uer'+userMap!);
  // if(userMap==null){
  //     return 0.toString();
  // }
  // else{
  // userMap;
  //  log('this is one '+userS);
  Map<String , dynamic> user = jsonDecode(userS) as  Map<String, dynamic>;
  // log('this is '+user['user_id']);
  return user;//.toString();
  // }
}

Future getCurrentUserId() async{
  SharedPreferences shared_User = await SharedPreferences.getInstance();
  String? userMap = await shared_User.getString('user_details');
  String userS = (userMap==null)?'':userMap;
  // log('this is uer'+userMap!);
  // if(userMap==null){
  //     return 0.toString();
  // }
  // else{
  // userMap;
  //  log('this is one '+userS);
  Map<String , dynamic> user = jsonDecode(userS) as  Map<String, dynamic>;
  // log('this is '+user['user_id']);
  return user['id'].toString();//.toString();
  // }
}
void updateUserId(id) async{
  // await FlutterSession().set("user_id", id);
}

Future isUserLoggedIn() async{
  SharedPreferences shared_User = await SharedPreferences.getInstance();
  String? user = shared_User.getString('user_details');
  // var d = jsonDecode(user);
  if(user==null){
    return false;
  }
  else{
    return true;
   // log('user is already logged in '+user);
  }
  // await FlutterSession().get("user_details", details);
}

Future logout() async{
  SharedPreferences shared_User = await SharedPreferences.getInstance();
  String? currentUserLanguage = shared_User.getString('currentLanguage');
  await shared_User.clear();
  if(currentUserLanguage!=null)
    shared_User.setString('currentLanguage', currentUserLanguage);
  print('the selected language is $currentUserLanguage');
  return true;
}

