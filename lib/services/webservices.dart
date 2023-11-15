import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../constants/global_data.dart';
import '../constants/global_keys.dart';
import '../widgets/showSnackbar.dart';
import 'api_urls.dart';
// https://developers.shestel.com/api/providers-list
const baseUrl = 'https://developers.shestel.com/api/';

class Webservices {
  static Future<Map> getData(String url, Map? data) async {
    var str="?";
    (data as Map<dynamic, dynamic>).forEach((key, value) {
      str=str+key+"="+value['value']+"&";
    });
    str=str+"country_id="+country_id;
    str=str+"&country_code="+country_code;
    str=str+"&m="+DateTime.now().millisecondsSinceEpoch.toString();
    Map response = {"status":"0","message":"Something went wrong"};
    print(baseUrl+url+str);
    // log('called ------'+baseUrl+url+str);
    try {
      Map<String,String> h = {
        "Content-Type": "application/json"
      };
      if(token!=''){
        h={
          'Authorization':"Bearer "+token,
          "Content-Type": "application/json"
        };

      }
      var res = await http.get(
        Uri.parse(baseUrl+url+str), headers: h
      );
      // log("body---"+res.body);
      if(res.statusCode!=200){
        print('The response status for api action $baseUrl$url is ${res.statusCode}');

      }
      else{
        // log('suy in $url : ------ ${res.body}');
        response = jsonDecode(res.body);
      }
      // log(url+"-"+res.body);
    } catch (e) {
      // showSnackbar(context, text)
      // log('Error in $url : ------ $e');
    }
    return response;
  }

  static Future<Map<String, dynamic>> postData(String url, Map? data, Map? files) async {
    var str="?";
    str=str+"m="+DateTime.now().millisecondsSinceEpoch.toString();

    try {
      // log('mizan-check----1');
      var request = new http.MultipartRequest("POST", Uri.parse(baseUrl+url+str));
      // log('mizan-check----2');
      if(data==null){
        data={};
      }
      data['country_id']= {"value":country_id};
      data['country_code']={"value":country_code};
      // log('mizan-check----3');

      (data as Map<dynamic, dynamic>).forEach((key, value) {
        // log('mizan-check----5 --  ${value} ${key}');
        request.fields[key]=value['value'];
      });
      // log("mizan-check1------4-----"+data.toString());

      if (files != null) {
        (files as Map<dynamic, dynamic>).forEach((key, value) async {
          request.files.add(await http.MultipartFile.fromPath(key, value.path));
        });
      }
      Map<String,String>? h =  {
        "Accept":"application/json"
      };
      if(token!='') {
        h['Authorization']="Bearer "+token;
        request.headers.addAll(h);
      }
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      log("mizan-check1------"+response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      // if (jsonResponse['status'] == 200) {
      // } else {
      // }
      return jsonResponse;
      // return response;
    } catch (e) {



      return {'status': 0, 'message': "Please check your internet connection and try again!."};
      // return null;
    }
  }


}
