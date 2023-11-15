// import 'dart:developer';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:livestream/constants/global_data.dart';
// import 'package:livestream/constants/image_urls.dart';
// import 'package:livestream/constants/sized_box.dart';
// import 'package:livestream/functions/navigation_functions.dart';
// import 'package:livestream/pages/account_detail_page.dart';
// import 'package:livestream/pages/chat_list_page.dart';
// import 'package:livestream/pages/detail.dart';
// import 'package:livestream/pages/help.dart';
// import 'package:livestream/pages/homepage.dart';
// import 'package:livestream/pages/privacy.dart';
// import 'package:livestream/pages/search.dart';
// import 'package:livestream/pages/stream_feed_page.dart';
// import 'package:livestream/pages/streaming_service_page.dart';
// import 'package:livestream/pages/terms.dart';
// import 'package:livestream/services/api_urls.dart';
// import 'package:livestream/services/webservices.dart';
// import 'package:livestream/widgets/CustomTexts.dart';
// import 'package:livestream/widgets/appbar.dart';
// import 'package:livestream/widgets/customtextfield.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
//
//
// import '../constants/colors.dart';
// import '../constants/drawer.dart';
//
// class Liked_Page extends StatefulWidget {
//   const Liked_Page({Key? key}) : super(key: key);
//
//   @override
//   State<Liked_Page> createState() => _Liked_PageState();
// }
//
// bool isSwitched =false;
// bool show = true;
// bool hide = false;
//
// class _Liked_PageState extends State<Liked_Page> {
//   final List<String> items = [
//     'Netflix',
//     'Prime Video',
//     'Hulu',
//     'Peacock',
//     'TV+',
//   ];
//   String? selectedValue;
//
//   List<Map<String, dynamic>> imgList= [
//     {
//       "url":'assets/images/slider.png', },
//     {
//       "url":'assets/images/img1.jpg',},
//     {
//       "url":'assets/images/img2.png', }
//   ];
//   List latest = [
//     MyImages.movie_one,
//     MyImages.movie_two,
//     MyImages.movie_three,
//     MyImages.movie_four,
//     MyImages.movie_five,
//     MyImages.movie_six,
//   ];
//
//   List logo = [
//     MyImages.netflix_logo,
//     MyImages.prime,
//     MyImages.hulu,
//     MyImages.desney,
//     MyImages.netflix_logo,
//     MyImages.prime,
//   ];
//
//
//
//   int _currentIndex = 0;
//   TextEditingController search = TextEditingController();
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//
//
//   bool load = false;
//   getMyLikedData()async{
//     var jsonResponse = await Webservices.getData('my-liked', {});
//     myLiked = jsonResponse;
//     setState(() {
//
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     getMyLikedData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     log('the mmm ${myLiked}');
//     return Scaffold(
//         key: scaffoldKey,
//       backgroundColor: Colors.black,
//         appBar: appBar(
//             context: context,
//             title: 'Liked',
//             titlecenter: false,
//             titleColor: Colors.white,
//             leading: GestureDetector(
//               onTap: (){
//                 scaffoldKey.currentState?.openDrawer();
//               },
//               child: Icon(
//                 Icons.menu_outlined,
//               ),
//             ),
//             implyLeading: false,
//             actions: [
//               IconButton(
//                 visualDensity: VisualDensity(horizontal: -4),
//                 padding: EdgeInsets.symmetric(horizontal: 5),
//                 constraints: BoxConstraints(),
//                 onPressed: (){
//                   push(context: context, screen: StreamFeed_Page());
//                 },
//                 icon: Icon(
//                   Icons.newspaper_outlined,
//                 ),
//               ),
//               IconButton(
//                   onPressed: (){
//                     push(context: context, screen: ChatList_Page());
//                   },
//                   // padding: EdgeInsets.symmetric(horizontal: 5),
//                   constraints: BoxConstraints(),
//                   // visualDensity: VisualDensity(horizontal: -4),
//                   icon: Stack(
//                     children: [
//                       ImageIcon(
//                         AssetImage(MyImages.chat),
//                         size: 24,
//                       ),
//                       Positioned(
//                         right: 0,
//                         child: Container(
//                           height: 12,
//                           width: 12,
//                           decoration: BoxDecoration(
//                               color: MyColors.primaryColor,
//                               borderRadius: BorderRadius.circular(10)
//                           ),
//                           child: Center(
//                             child: ParagraphText(
//                               text: '4',
//                               fontSize: 10,
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   )
//
//
//
//               ),
//               // IconButton(onPressed: (){
//               //   push(context: context, screen: ChatList_Page());
//               // },
//               //     padding: EdgeInsets.symmetric(horizontal: 5),
//               //     constraints: BoxConstraints(),
//               //     visualDensity: VisualDensity(horizontal: -4),
//               //     icon: ImageIcon(
//               //       AssetImage(MyImages.chat),
//               //       size: 18,
//               //     )
//               // ),
//               // IconButton(
//               //   onPressed: (){},
//               //   visualDensity: VisualDensity(horizontal: -4),
//               //   padding: EdgeInsets.symmetric(horizontal: 5),
//               //   constraints: BoxConstraints(),
//               //   icon: Icon(
//               //     Icons.notifications,
//               //   ),
//               // ),
//             ]
//         ),
//       body: Container(
//         decoration: BoxDecoration(
//           color: MyColors.black
//           // image: DecorationImage(
//           //     image: AssetImage(MyImages.background_home),
//           //     fit: BoxFit.fitWidth,
//           //     alignment: Alignment.topLeft
//           // ),
//         ),
//         child: SingleChildScrollView(
//
//           child: Column(
//             children: [
//               vSizedBox2,
//               Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                 child:   Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     DropdownButtonHideUnderline(
//                       child: DropdownButton2(
//                         isExpanded: true,
//                         hint: Text(
//                           'Filter by provider',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.white,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         items: items
//                             .map((item) => DropdownMenuItem<String>(
//                           value: item,
//                           child: Text(
//                             item,
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ))
//                             .toList(),
//                         value: selectedValue,
//                         onChanged: (value) {
//                           setState(() {
//                             selectedValue = value as String;
//                           });
//                         },
//                         icon: const Icon(
//                           Icons.expand_more_outlined,
//                         ),
//                         iconSize: 20,
//                         iconEnabledColor: Colors.white,
//                         iconDisabledColor: Colors.grey,
//                         buttonHeight: 38,
//                         buttonWidth: 180,
//                         buttonPadding: const EdgeInsets.only(left: 14, right: 14),
//                         buttonDecoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           // border: Border.all(
//                           //   color: Colors.black26,
//                           // ),
//                           color: MyColors.primaryColor,
//                         ),
//                         buttonElevation: 2,
//                         itemHeight: 40,
//                         itemPadding: const EdgeInsets.only(left: 14, right: 14),
//                         dropdownMaxHeight: 200,
//                         dropdownWidth: 180,
//                         dropdownPadding: null,
//                         dropdownDecoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: Colors.white,
//                         ),
//                         dropdownElevation: 8,
//                         scrollbarRadius: const Radius.circular(40),
//                         scrollbarThickness: 6,
//                         scrollbarAlwaysShow: true,
//                         offset: const Offset(0, 0),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               vSizedBox2,
//
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Container(
//                   // height: ,
//                   child: ListView(
//                     physics: NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     children: [
//
//                       Wrap(
//                         runSpacing: 16,
//                         spacing: 8,
//                         direction: Axis.horizontal,
//                         children: [
//                           for(var i=0; i<6; i++)
//                           GestureDetector(
//                             onTap: (){
//                               push(context: context, screen: Details_Page());
//                             },
//                             child: Stack(
//                               children: [
//                                 Container(
//                                   width: MediaQuery.of(context).size.width / 2 - 24,
//                                   decoration: BoxDecoration(
//                                     color: Colors.black,
//                                     border: Border.all(
//                                       color: MyColors.primaryColor,
//                                     ),
//                                     borderRadius: BorderRadius.circular(10)
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                         child: Image.asset(latest[i],
//                                           height: 230,
//                                           width: MediaQuery.of(context).size.width,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Positioned(
//                                     top: 1,
//                                     left: 1,
//                                     child: Container(
//                                       width: MediaQuery.of(context).size.width / 2 - 26,
//                                       height: 220,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         gradient: LinearGradient(
//                                             colors: [Colors.black.withOpacity(1), Colors.transparent],
//                                             begin: Alignment.topCenter,
//                                             end: Alignment.bottomCenter,
//                                             stops: [0.0, 0.50]
//                                         ),
//                                       ),
//                                     )
//                                 ),
//                                 Positioned(
//                                   left: 16,
//                                   top: 16,
//                                   child: GestureDetector(
//                                     onTap: (){
//
//                                     },
//                                     child: Image.asset(logo[i], height: i==1? 30 : i==2? 15 : i==3? 30: 20,),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   right: 10,
//                                   bottom: 10,
//                                   child: Image.asset(MyImages.liked, height: 21,)
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ),
//               vSizedBox4,
//
//             ],
//           ),
//         ),
//       ),
//         drawer: get_drawer(context)
//     );
//   }
// }
