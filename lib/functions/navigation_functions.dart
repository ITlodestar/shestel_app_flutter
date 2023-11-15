import 'package:flutter/material.dart';
import 'package:livestream/constants/global_data.dart';
import 'package:livestream/functions/globalFunctions.dart';
import 'package:livestream/pages/detail.dart';
import 'package:livestream/pages/sport_detail.dart';
import 'package:livestream/widgets/showSnackbar.dart';

import '../constants/colors.dart';
import '../pages/chat_detail.dart';
import '../pages/chat_list_page.dart';
import '../pages/see_all.dart';
import '../pages/stream_feed_page.dart';
import '../services/webservices.dart';


Future push({required  BuildContext context, required Widget screen,})async{
  print('presse kjhn d');
  return Navigator.push(context, MaterialPageRoute(builder: (context){
    return screen;
  }));
}

Future goDetails({required  BuildContext context, required Map data, required MediaType mediaType})async{
  // if(mediaId!=null){
  //   return Navigator.push(context, MaterialPageRoute(builder: (context){
  //     // return Details_Page(id:"64", details:data, mediaType: mediaType);//to test vimeo
  //     return Details_Page(id:mediaId, details:null, mediaType: mediaType);
  //   }));
  // }else

    if(data['media_type']==MediaType.movie.name){
    mediaType = MediaType.movie;
  }
  else   if(data['media_type']==MediaType.sport.name){
    mediaType = MediaType.sport;
    return Navigator.push(context, MaterialPageRoute(builder: (context){
      // return Details_Page(id:"64", details:data, mediaType: mediaType);//to test vimeo
      return Sport_Details_Page(id:data['id'].toString(), details:data, mediaType: mediaType);
    }));
  }
  else   if(data['media_type']==MediaType.tv.name){
    mediaType = MediaType.tv;
  }

  return Navigator.push(context, MaterialPageRoute(builder: (context){
    // return Details_Page(id:"64", details:data, mediaType: mediaType);//to test vimeo
    return Details_Page(id:data['id'].toString(), details:data, mediaType: mediaType);
  }));
}




Future pushReplacement({required  BuildContext context, required Widget screen,})async{
  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
    return screen;
  }));
}

Future pushAndRemoveUntil({required  BuildContext context, required Widget screen,})async{
  return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
    return screen;
  }), (route)=>false);
}

Future showCustomDialogBox({
  required BuildContext context,
  required dynamic child,
  Color background = MyColors.white,
  double bottom = 16,
  double padtop = 16,
  double padleft = 16,
  double padright = 16,
  double marginhorizontal = 0,
  bool border = true,
}){
  return showDialog(context: context, builder: (context){
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,

      insetPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      // title: Text('Allow Liza to see', textAlign: TextAlign.center,),
      children: [
        SimpleDialogOption(

            padding: EdgeInsets.symmetric(vertical: 0),
            child: Container(
              padding: EdgeInsets.only(top: padtop, left: padleft, bottom: bottom, right: padright),
              margin: EdgeInsets.symmetric(horizontal: marginhorizontal , vertical: 0),
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height - 470,
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(25),
                border: border? Border.all(
                    color: MyColors.primaryColor
                ) : null,

              ),
              child: child,
            )
        ),
      ],
    );
  });
}



notificationHandling(BuildContext context, Map? data){
  print('this is navigation data--'+data.toString());
  if(data==null){
    return;
  }
  // if({media_id: 1943, media_type: movie, type: movie, notification_id: 3046})
  if(data["notification_id"].toString()!="0"){
    print("this is notification id"+data["notification_id"].toString());
    Webservices.getData('click-notification', {"id":{"value":data["notification_id"].toString()}});
  }


  if(data["type"]=='added-in-group'){
    push(context: context, screen: SingleChat(
        name:data['group_title'].toString().toCapitalize(),
        thread_id: data['group_id'].toString(),
        created_by: "no"
    ));
  }
  else if(data["type"]=='new-friend-request'){
    //nothing
  }
  else if(data["type"]=='accept-friend-request'){
    push(context: context, screen: ChatList_Page());
    
  }
  else if(data["type"]=='reject-friend-request'){

  }
  else if(data["type"]=='comment-at-feed' || data["type"]=='like-feed' || data=='share-feed'){
    push(context: context, screen: StreamFeed_Page(feed_id:data['feed_id'].toString()));
  }
  else if(data["type"]=='movie' || data["type"]=='tv'){
    goDetails(context: context, data:{"media_type":data['media_type'], "id":data['media_id']}, mediaType: MediaType.movie);
    // goDetails(context: context, mediaType: data['media_type']==MediaType.movie.name?MediaType.movie:MediaType.sport);
  }
  else if(data["type"]=='slug' || data["type"]=='latest-movie-reminder'){
    push(context: context, screen: SeeAllPage(heading:data["title"], slug:data["slug"], media_type: MediaType.movie,));
    // goDetails(context: context, data:{"media_type":data['media_type'], "id":data['media_id']}, mediaType: MediaType.movie);
    // goDetails(context: context, mediaType: data['media_type']==MediaType.movie.name?MediaType.movie:MediaType.sport);
  }
  else if(data["type"]=='chat-message' ){
    push(context: context, screen: SingleChat(
    name:data['first_name'].toString().toCapitalize()+" "+data['last_name'].toString().toLowerCase(),
  thread_id: data['thread_id'].toString(),
  id: data["sender_id"].toString(),
  ));
    // push(context: context, screen: SeeAllPage(heading:data["title"], slug:data["slug"], media_type: MediaType.movie,));
    // goDetails(context: context, data:{"media_type":data['media_type'], "id":data['media_id']}, mediaType: MediaType.movie);
    // goDetails(context: context, mediaType: data['media_type']==MediaType.movie.name?MediaType.movie:MediaType.sport);
  }

  // {thread_id: 8_44, receiver_id: 44, message: hi, type: chat-message, sender_id: 8}

}