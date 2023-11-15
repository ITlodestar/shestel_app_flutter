


import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../constants/global_data.dart';
import 'navigation_functions.dart';

Future<String> createDynamicLink(String dynamicLink, Map params,String? title,String? imageUrl ) async {
  var str="?";
  (params as Map<dynamic, dynamic>).forEach((key, value) {
    str=str+key+"="+value+"&";
  });
  str=str+"m=1";
  print('dynamic-------'+"https://shestel.page.link/"+str);
  print('title-------'+title.toString());
  print('image-------'+imageUrl.toString());
  final dynamicLinkParams = DynamicLinkParameters(
    link: Uri.parse("https://shestel.page.link/"+str),//"+widget.mediaType.name+"&media_id"+widget.id!),
    uriPrefix: "https://shestel.page.link",
    androidParameters: const AndroidParameters(
      packageName: "com.shestel.app",
      // minimumVersion: 30,
    ),
    iosParameters: const IOSParameters(
      bundleId: "com.shestel.app",
      appStoreId: "6444605218",
      // minimumVersion: "1.0.1",
    ),
    socialMetaTagParameters: (title==null && imageUrl==null)?null:SocialMetaTagParameters(
      title: title,
      imageUrl:(imageUrl==null)?null:Uri.parse(imageUrl),
    ),
  );
  final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  print('link created-------'+dynamicLink.shortUrl.toString());
  // final dynamicLink1 = await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
  // print('link created-------'+dynamicLink1.toString());
  return dynamicLink.shortUrl.toString();
  // Share.share(message+" "+dynamicLink.shortUrl.toString());
}

initDynamiclinks(context) async{ //should be called after login (example: tabpage)

  final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  if(initialLink!=null){
    openlink(initialLink,context);

  }
  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    // {media_type: movie, : 84818, m: 1}
    openlink(dynamicLinkData,context);
    // Navigator.pushNamed(context, dynamicLinkData.link.path);
  }).onError((error) {
    // Handle errors
  });
}


openlink(PendingDynamicLinkData dynamiclink, context){
  print('this is dynamic link ------ '+dynamiclink.link.queryParameters.toString());
  Map param = dynamiclink.link.queryParameters;
  notificationHandling(context, param);
  // goDetails(context: context, data:{"media_type":param['media_type'], "id":param['media_id']}, mediaType: MediaType.movie);

}