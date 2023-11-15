// import 'dart:developer';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
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
// import '../constants/global_data.dart';
// import '../services/webservices.dart';
// import '../widgets/MediaBox.dart';
// import '../widgets/buttons.dart';
// import '../widgets/showSnackbar.dart';
//
// class Recommendation_Page extends StatefulWidget {
//   const Recommendation_Page({Key? key}) : super(key: key);
//
//   @override
//   State<Recommendation_Page> createState() => _Recommendation_PageState();
// }
//
// bool isSwitched =false;
// bool show = true;
// bool hide = false;
// bool hideone = false;
//
// class _Recommendation_PageState extends State<Recommendation_Page> {
//   final List<String> items = [
//     'Netflix',
//     'Prime Video',
//     'Hulu',
//     'Peacock',
//     'TV+',
//   ];
//
//   List movielist = [
//     'assets/images/stream1.png',
//     'assets/images/img1.jpg',
//     'assets/images/img2.png',
//     'assets/images/slider.png',
//     'assets/images/img2.png',
//   ];
//
//   List latest = [
//     MyImages.movie_one,
//     MyImages.movie_two,
//     MyImages.movie_three,
//     MyImages.movie_four,
//     MyImages.movie_five,
//     MyImages.movie_six,
//   ];
//
//   List streamlist = [
//     'assets/images/netflixlogo.png',
//     'assets/images/prime_logo.png',
//     'assets/images/peacock_x.png',
//     'assets/images/netflixlogo.png',
//     'assets/images/prime_logo.png',
//   ];
//
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
//   int _currentIndex = 0;
//   TextEditingController search = TextEditingController();
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//
//
//   bool load = false;
//
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     getAllData();
//     super.initState();
//   }
//
//   getAllData() async{
//
//
//     setState((){
//       load = true;
//     });
//     Map res = await Webservices.getData('explore-tab-data', {"media_type":{"value":"movie"}});
//     if (res['status'].toString() == "1") { //user is new need to signup
//       log('--thisisdata---'+res.toString()+'--------');
//       // for (var i = 0; i < res['data'].length; i++) {
//       //   res['data'][i]['checked'] = false;
//       // }
//       explorePageData = res['data'];
//       setState((){
//         load = false;
//       });
//     }
//
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//         key: scaffoldKey,
//       backgroundColor: Colors.black,
//         appBar: appBar(
//             context: context,
//             title: 'Explore',
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
//               // IconButton(onPressed: (){},
//               //   visualDensity: VisualDensity(horizontal: -4),
//               //   padding: EdgeInsets.symmetric(horizontal: 5),
//               //   constraints: BoxConstraints(),
//               //   icon: Icon(
//               //     Icons.notifications,
//               //   ),
//               // ),
//
//             ]
//         ),
//       body: Container(
//         decoration: BoxDecoration(
//           // image: DecorationImage(
//           //     image: AssetImage(MyImages.background_home),
//           //     fit: BoxFit.fitWidth,
//           //     alignment: Alignment.topLeft
//           // ),
//           color: MyColors.black
//         ),
//         child: SingleChildScrollView(
//
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   Positioned(
//                     bottom: 0,
//                     child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                           border: Border(
//                               bottom: BorderSide(
//                                   color: Colors.white.withOpacity(0.20)
//                               )
//                           )
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         GestureDetector(
//                           onTap: (){
//                             setState(() {
//                               show = true;
//                               hide = false;
//                               hideone = false;
//                             });
//                           },
//                           child: Column(
//                             children: [
//                               ParagraphText(
//                                 text:'Movies',
//                                 fontFamily: show? 'medium':'light',
//                                 color: show? MyColors.primaryColor:  Colors.white,
//                                 fontSize: 16,
//                               ),
//                               vSizedBox05,
//                               // if(show==true)
//                               Container(
//                                 height: 1,
//                                 width: 100,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(2),
//                                     color: show==true? MyColors.primaryColor: Colors.transparent
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         hSizedBox4,
//                         GestureDetector(
//                           onTap: (){
//                             setState(() {
//                               show = false;
//                               hide = true;
//                               hideone = false;
//                             });
//                           },
//                           child: Column(
//                             children: [
//                               ParagraphText(
//                                 fontFamily: hide? 'medium':'light',
//                                 color: hide? MyColors.primaryColor:  Colors.white,
//                                 fontSize: 16,
//                                 text: 'TV Shows',
//                               ),
//                               vSizedBox05,
//                               // if(hide==true)
//                               Container(
//                                 height: 1,
//                                 width: 80,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(2),
//                                     color: hide==true? MyColors.primaryColor: Colors.transparent
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         hSizedBox4,
//                         GestureDetector(
//                           onTap: (){
//                             setState(() {
//                               show = false;
//                               hide = false;
//                               hideone = true;
//                             });
//                           },
//                           child: Column(
//                             children: [
//                               ParagraphText(
//                                 fontFamily:  hideone? 'medium':'light',
//                                 color:  hideone? MyColors.primaryColor:  Colors.white,
//                                 fontSize: 16,
//                                 text: 'Sports',
//                               ),
//                               vSizedBox05,
//                               // if(hide==true)
//                               Container(
//                                 height: 1,
//                                 width: 80,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(2),
//                                     color: hideone==true? MyColors.primaryColor: Colors.transparent
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               vSizedBox2,
//               vSizedBox05,
//               if(show == true)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16),
//                     child:   Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         DropdownButtonHideUnderline(
//                           child: DropdownButton2(
//                             isExpanded: true,
//                             hint: Text(
//                               'Filter by provider',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.white,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             items: items
//                                 .map((item) => DropdownMenuItem<String>(
//                               value: item,
//                               child: Text(
//                                 item,
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ))
//                                 .toList(),
//                             value: selectedValue,
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedValue = value as String;
//                               });
//                             },
//                             icon: const Icon(
//                               Icons.expand_more_outlined,
//                             ),
//                             iconSize: 20,
//                             iconEnabledColor: Colors.white,
//                             iconDisabledColor: Colors.grey,
//                             buttonHeight: 38,
//                             buttonWidth: 180,
//                             buttonPadding: const EdgeInsets.only(left: 14, right: 14),
//                             buttonDecoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               // border: Border.all(
//                               //   color: Colors.black26,
//                               // ),
//                               color: MyColors.primaryColor,
//                             ),
//                             buttonElevation: 2,
//                             itemHeight: 40,
//                             itemPadding: const EdgeInsets.only(left: 14, right: 14),
//                             dropdownMaxHeight: 200,
//                             dropdownWidth: 180,
//                             dropdownPadding: null,
//                             dropdownDecoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: Colors.white,
//                             ),
//                             dropdownElevation: 8,
//                             scrollbarRadius: const Radius.circular(40),
//                             scrollbarThickness: 6,
//                             scrollbarAlwaysShow: true,
//                             offset: const Offset(0, 0),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   vSizedBox2,
//                   // Add Section
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16),
//                     child: Image.asset(MyImages.addtwo),
//                   ),
//                   // Add Section
//                   vSizedBox2,
//
//                   for(int i=0;i<explorePageData.length;i++)
//                     Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children:[
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ParagraphText(text: explorePageData[i]['title'], fontSize: 16, fontFamily: 'medium',),
//                                 GestureDetector(
//                                   onTap: (){
//                                     showSnackbar("Coming Soon!");
//
//                                   },
//                                   child: ParagraphText(
//                                     text: 'See all',
//                                     color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
//
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           vSizedBox05,
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Container(
//                               height: 270,
//                               child: ListView(
//                                 scrollDirection: Axis.horizontal,
//                                 children: [
//                                   for(var j=0; j<explorePageData[i]['data'].length; j++)
//                                     MediaBox(
//                                       data:explorePageData[i]['data'][j],
//                                       onTap: () async {
//                                         push(context: context, screen: Details_Page(id:explorePageData[i]['data'][j]['id'].toString(),details: explorePageData[i]['data'][j],));
//                                       },
//
//                                     ),
//
//                                 ],
//                               ),
//                             ),
//                           ),
//                           vSizedBox2,
//                         ]
//                     ),
//
//
//
//                   vSizedBox2,
//                 ],
//               ),
//               if(hide == true)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child:   Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           DropdownButtonHideUnderline(
//                             child: DropdownButton2(
//                               isExpanded: true,
//                               hint: Text(
//                                 'Filter by provider',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.white,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               items: items
//                                   .map((item) => DropdownMenuItem<String>(
//                                 value: item,
//                                 child: Text(
//                                   item,
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ))
//                                   .toList(),
//                               value: selectedValue,
//                               onChanged: (value) {
//                                 setState(() {
//                                   selectedValue = value as String;
//                                 });
//                               },
//                               icon: const Icon(
//                                 Icons.expand_more_outlined,
//                               ),
//                               iconSize: 20,
//                               iconEnabledColor: Colors.white,
//                               iconDisabledColor: Colors.grey,
//                               buttonHeight: 38,
//                               buttonWidth: 180,
//                               buttonPadding: const EdgeInsets.only(left: 14, right: 14),
//                               buttonDecoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 // border: Border.all(
//                                 //   color: Colors.black26,
//                                 // ),
//                                 color: MyColors.primaryColor,
//                               ),
//                               buttonElevation: 2,
//                               itemHeight: 40,
//                               itemPadding: const EdgeInsets.only(left: 14, right: 14),
//                               dropdownMaxHeight: 200,
//                               dropdownWidth: 180,
//                               dropdownPadding: null,
//                               dropdownDecoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 color: Colors.white,
//                               ),
//                               dropdownElevation: 8,
//                               scrollbarRadius: const Radius.circular(40),
//                               scrollbarThickness: 6,
//                               scrollbarAlwaysShow: true,
//                               offset: const Offset(0, 0),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     vSizedBox2,
//                     // Add Section
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Image.asset(MyImages.addtwo),
//                     ),
//                     vSizedBox2,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ParagraphText(text: 'Recommendations', fontSize: 16, fontFamily: 'medium',),
//                           GestureDetector(
//                             onTap: (){
//
//                             },
//                             child: ParagraphText(
//                               text: 'See all',
//                               color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
//
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     vSizedBox05,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Container(
//                         height: 270,
//                         child: ListView(
//                           scrollDirection: Axis.horizontal,
//                           children: [
//                             for(var i=0; i<5; i++)
//                               GestureDetector(
//                                 onTap: (){
//                                   push(context: context, screen: Details_Page());
//                                 },
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       Stack(
//                                         children: [
//                                           Container(
//                                             width: MediaQuery.of(context).size.width / 2 - 16,
//                                             margin: EdgeInsets.only(right: 8),
//                                             decoration: BoxDecoration(
//                                                 color: Colors.black,
//                                                 border: Border.all(
//                                                   color: MyColors.primaryColor,
//                                                 ),
//                                                 borderRadius: BorderRadius.circular(12)
//                                             ),
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 ClipRRect(
//                                                   borderRadius: BorderRadius.only(
//                                                     topLeft: Radius.circular(12),
//                                                     topRight: Radius.circular(12),
//                                                   ),
//                                                   child: Image.asset(latest[i],
//                                                     height: 170,
//                                                     width: MediaQuery.of(context).size.width,
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 ),
//                                                 vSizedBox05,
//                                                 Container(
//                                                   padding: EdgeInsets.symmetric(horizontal: 8),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       ParagraphText(text: 'Harry Potter and the Philosopher\'s Stone (2001)',
//                                                         fontSize: 12,
//                                                         fontFamily: 'medium',
//                                                         maxline: 2,
//
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           ParagraphText(text: 'IMDB : ',
//                                                             color: MyColors.yellow,
//                                                             fontSize: 12,
//                                                             fontFamily: 'bold',
//                                                           ),
//                                                           ParagraphText(text: '8.9/10',
//                                                             color: MyColors.white,
//                                                             fontSize: 12,
//                                                             fontFamily: 'regular',
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       vSizedBox05,
//                                                       // if(i==0 || i==2 || i==4)
//                                                       Row(
//                                                         children: [
//                                                           RoundEdgedButton(
//                                                             text: 'Seen',
//                                                             textColor: Colors.white,
//                                                             borderRadius: 8,
//                                                             fontfamily: 'semibold',
//                                                             width: 60,
//                                                             horizontalMargin: 0,
//                                                             horizontalPadding: 0,
//                                                             verticalPadding: 0,
//                                                             height: 25,
//                                                             fontSize: 14,
//                                                           ), hSizedBox05,
//                                                           RoundEdgedButton(
//                                                             text: 'Share',
//                                                             textColor: Colors.white,
//                                                             borderRadius: 8,
//                                                             fontfamily: 'semibold',
//                                                             width: 60,
//                                                             horizontalMargin: 0,
//                                                             horizontalPadding: 0,
//                                                             verticalPadding: 0,
//                                                             height: 25,
//                                                             fontSize: 14,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       // if(i==1 || i==3)
//                                                       //   vSizedBox2,
//                                                       // SizedBox(height:19,),
//                                                       //   RoundEdgedButton(
//                                                       //     text: 'Watch now',
//                                                       //     textColor: Colors.white,
//                                                       //     width: 80,
//                                                       //     horizontalMargin: 0,
//                                                       //     horizontalPadding: 0,
//                                                       //     verticalPadding: 0,
//                                                       //     height: 20,
//                                                       //     fontSize: 12,
//                                                       //   ),
//                                                       SizedBox(height: 4,)
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Positioned(
//                                               top: 1,
//                                               left: 1,
//                                               child: Container(
//                                                 width: MediaQuery.of(context).size.width / 2 - 18,
//                                                 height: 220,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   gradient: LinearGradient(
//                                                       colors: [Colors.black.withOpacity(1), Colors.transparent],
//                                                       begin: Alignment.topCenter,
//                                                       end: Alignment.bottomCenter,
//                                                       stops: [0.0, 0.50]
//                                                   ),
//                                                 ),
//                                               )
//                                           ),
//                                           Positioned(
//                                             left: 16,
//                                             top: 16,
//                                             child: GestureDetector(
//                                               onTap: (){
//
//                                               },
//                                               child: Image.asset(streamlist[i], width: 50,),
//                                             ),
//                                           ),
//                                           // Positioned(
//                                           //   right: 16,
//                                           //   top: 16,
//                                           //   child: GestureDetector(
//                                           //     onTap: (){
//                                           //
//                                           //     },
//                                           //     child: RoundEdgedButton(
//                                           //       text: 'Seen',
//                                           //       textColor: Colors.white,
//                                           //       width: 40,
//                                           //       horizontalMargin: 0,
//                                           //       horizontalPadding: 0,
//                                           //       verticalPadding: 0,
//                                           //       height: 20,
//                                           //       fontSize: 12,
//                                           //
//                                           //     )
//                                           //
//                                           //     ,
//                                           //   ),
//                                           // )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                     vSizedBox2,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ParagraphText(text: 'New Seasons', fontSize: 16, fontFamily: 'medium',),
//                           GestureDetector(
//                             onTap: (){
//
//                             },
//                             child: ParagraphText(
//                               text: 'See all',
//                               color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
//
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     vSizedBox,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Container(
//                         height: 270,
//                         child: ListView(
//                           scrollDirection: Axis.horizontal,
//                           children: [
//                             for(var i=0; i<5; i++)
//                               GestureDetector(
//                                 onTap: (){
//                                   push(context: context, screen: Details_Page());
//                                 },
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       Stack(
//                                         children: [
//                                           Container(
//                                             width: MediaQuery.of(context).size.width / 2 - 16,
//                                             margin: EdgeInsets.only(right: 8),
//                                             decoration: BoxDecoration(
//                                                 color: Colors.black,
//                                                 border: Border.all(
//                                                   color: MyColors.primaryColor,
//                                                 ),
//                                                 borderRadius: BorderRadius.circular(12)
//                                             ),
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 ClipRRect(
//                                                   borderRadius: BorderRadius.only(
//                                                     topLeft: Radius.circular(12),
//                                                     topRight: Radius.circular(12),
//                                                   ),
//                                                   child: Image.asset(latest[i],
//                                                     height: 170,
//                                                     width: MediaQuery.of(context).size.width,
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 ),
//                                                 vSizedBox05,
//                                                 Container(
//                                                   padding: EdgeInsets.symmetric(horizontal: 8),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       ParagraphText(text: 'Harry Potter and the Philosopher\'s Stone (2001)',
//                                                         fontSize: 12,
//                                                         fontFamily: 'medium',
//                                                         maxline: 2,
//
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           ParagraphText(text: 'IMDB : ',
//                                                             color: MyColors.yellow,
//                                                             fontSize: 12,
//                                                             fontFamily: 'bold',
//                                                           ),
//                                                           ParagraphText(text: '8.9/10',
//                                                             color: MyColors.white,
//                                                             fontSize: 12,
//                                                             fontFamily: 'regular',
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       vSizedBox05,
//                                                       // if(i==0 || i==2 || i==4)
//                                                       Row(
//                                                         children: [
//                                                           RoundEdgedButton(
//                                                             text: 'Seen',
//                                                             textColor: Colors.white,
//                                                             borderRadius: 8,
//                                                             fontfamily: 'semibold',
//                                                             width: 60,
//                                                             horizontalMargin: 0,
//                                                             horizontalPadding: 0,
//                                                             verticalPadding: 0,
//                                                             height: 25,
//                                                             fontSize: 14,
//                                                           ), hSizedBox05,
//                                                           RoundEdgedButton(
//                                                             text: 'Share',
//                                                             textColor: Colors.white,
//                                                             borderRadius: 8,
//                                                             fontfamily: 'semibold',
//                                                             width: 60,
//                                                             horizontalMargin: 0,
//                                                             horizontalPadding: 0,
//                                                             verticalPadding: 0,
//                                                             height: 25,
//                                                             fontSize: 14,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       // if(i==1 || i==3)
//                                                       //   vSizedBox2,
//                                                       // SizedBox(height:19,),
//                                                       //   RoundEdgedButton(
//                                                       //     text: 'Watch now',
//                                                       //     textColor: Colors.white,
//                                                       //     width: 80,
//                                                       //     horizontalMargin: 0,
//                                                       //     horizontalPadding: 0,
//                                                       //     verticalPadding: 0,
//                                                       //     height: 20,
//                                                       //     fontSize: 12,
//                                                       //   ),
//                                                       SizedBox(height: 4,)
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Positioned(
//                                               top: 1,
//                                               left: 1,
//                                               child: Container(
//                                                 width: MediaQuery.of(context).size.width / 2 - 18,
//                                                 height: 220,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   gradient: LinearGradient(
//                                                       colors: [Colors.black.withOpacity(1), Colors.transparent],
//                                                       begin: Alignment.topCenter,
//                                                       end: Alignment.bottomCenter,
//                                                       stops: [0.0, 0.50]
//                                                   ),
//                                                 ),
//                                               )
//                                           ),
//                                           Positioned(
//                                             left: 16,
//                                             top: 16,
//                                             child: GestureDetector(
//                                               onTap: (){
//
//                                               },
//                                               child: Image.asset(streamlist[i], width: 50,),
//                                             ),
//                                           ),
//                                           // Positioned(
//                                           //   right: 16,
//                                           //   top: 16,
//                                           //   child: GestureDetector(
//                                           //     onTap: (){
//                                           //
//                                           //     },
//                                           //     child: RoundEdgedButton(
//                                           //       text: 'Seen',
//                                           //       textColor: Colors.white,
//                                           //       width: 40,
//                                           //       horizontalMargin: 0,
//                                           //       horizontalPadding: 0,
//                                           //       verticalPadding: 0,
//                                           //       height: 20,
//                                           //       fontSize: 12,
//                                           //
//                                           //     )
//                                           //
//                                           //     ,
//                                           //   ),
//                                           // )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                     vSizedBox2,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ParagraphText(text: 'Popular TV shows ', fontSize: 16, fontFamily: 'medium',),
//                           GestureDetector(
//                             onTap: (){
//
//                             },
//                             child: ParagraphText(
//                               text: 'See all',
//                               color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
//
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     vSizedBox,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Container(
//                         height: 270,
//                         child: ListView(
//                           scrollDirection: Axis.horizontal,
//                           children: [
//                             for(var i=0; i<5; i++)
//                               GestureDetector(
//                                 onTap: (){
//                                   push(context: context, screen: Details_Page());
//                                 },
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       Stack(
//                                         children: [
//                                           Container(
//                                             width: MediaQuery.of(context).size.width / 2 - 16,
//                                             margin: EdgeInsets.only(right: 8),
//                                             decoration: BoxDecoration(
//                                                 color: Colors.black,
//                                                 border: Border.all(
//                                                   color: MyColors.primaryColor,
//                                                 ),
//                                                 borderRadius: BorderRadius.circular(12)
//                                             ),
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 ClipRRect(
//                                                   borderRadius: BorderRadius.only(
//                                                     topLeft: Radius.circular(12),
//                                                     topRight: Radius.circular(12),
//                                                   ),
//                                                   child: Image.asset(latest[i],
//                                                     height: 170,
//                                                     width: MediaQuery.of(context).size.width,
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 ),
//                                                 vSizedBox05,
//                                                 Container(
//                                                   padding: EdgeInsets.symmetric(horizontal: 8),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       ParagraphText(text: 'Harry Potter and the Philosopher\'s Stone (2001)',
//                                                         fontSize: 12,
//                                                         fontFamily: 'medium',
//                                                         maxline: 2,
//
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           ParagraphText(text: 'IMDB : ',
//                                                             color: MyColors.yellow,
//                                                             fontSize: 12,
//                                                             fontFamily: 'bold',
//                                                           ),
//                                                           ParagraphText(text: '8.9/10',
//                                                             color: MyColors.white,
//                                                             fontSize: 12,
//                                                             fontFamily: 'regular',
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       vSizedBox05,
//                                                       // if(i==0 || i==2 || i==4)
//                                                       Row(
//                                                         children: [
//                                                           RoundEdgedButton(
//                                                             text: 'Seen',
//                                                             textColor: Colors.white,
//                                                             borderRadius: 8,
//                                                             fontfamily: 'semibold',
//                                                             width: 60,
//                                                             horizontalMargin: 0,
//                                                             horizontalPadding: 0,
//                                                             verticalPadding: 0,
//                                                             height: 25,
//                                                             fontSize: 14,
//                                                           ), hSizedBox05,
//                                                           RoundEdgedButton(
//                                                             text: 'Share',
//                                                             textColor: Colors.white,
//                                                             borderRadius: 8,
//                                                             fontfamily: 'semibold',
//                                                             width: 60,
//                                                             horizontalMargin: 0,
//                                                             horizontalPadding: 0,
//                                                             verticalPadding: 0,
//                                                             height: 25,
//                                                             fontSize: 14,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       // if(i==1 || i==3)
//                                                       //   vSizedBox2,
//                                                       // SizedBox(height:19,),
//                                                       //   RoundEdgedButton(
//                                                       //     text: 'Watch now',
//                                                       //     textColor: Colors.white,
//                                                       //     width: 80,
//                                                       //     horizontalMargin: 0,
//                                                       //     horizontalPadding: 0,
//                                                       //     verticalPadding: 0,
//                                                       //     height: 20,
//                                                       //     fontSize: 12,
//                                                       //   ),
//                                                       SizedBox(height: 4,)
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Positioned(
//                                               top: 1,
//                                               left: 1,
//                                               child: Container(
//                                                 width: MediaQuery.of(context).size.width / 2 - 18,
//                                                 height: 220,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   gradient: LinearGradient(
//                                                       colors: [Colors.black.withOpacity(1), Colors.transparent],
//                                                       begin: Alignment.topCenter,
//                                                       end: Alignment.bottomCenter,
//                                                       stops: [0.0, 0.50]
//                                                   ),
//                                                 ),
//                                               )
//                                           ),
//                                           Positioned(
//                                             left: 16,
//                                             top: 16,
//                                             child: GestureDetector(
//                                               onTap: (){
//
//                                               },
//                                               child: Image.asset(MyImages.netflix_logo, width: 50,),
//                                             ),
//                                           ),
//                                           // Positioned(
//                                           //   right: 16,
//                                           //   top: 16,
//                                           //   child: GestureDetector(
//                                           //     onTap: (){
//                                           //
//                                           //     },
//                                           //     child: RoundEdgedButton(
//                                           //       text: 'Seen',
//                                           //       textColor: Colors.white,
//                                           //       width: 40,
//                                           //       horizontalMargin: 0,
//                                           //       horizontalPadding: 0,
//                                           //       verticalPadding: 0,
//                                           //       height: 20,
//                                           //       fontSize: 12,
//                                           //
//                                           //     )
//                                           //
//                                           //     ,
//                                           //   ),
//                                           // )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                     vSizedBox2,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ParagraphText(text: 'Retiring TV Shows', fontSize: 16, fontFamily: 'medium',),
//                           GestureDetector(
//                             onTap: (){
//
//                             },
//                             child: ParagraphText(
//                               text: 'See all',
//                               color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
//
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     vSizedBox,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Container(
//                         height: 270,
//                         child: ListView(
//                           scrollDirection: Axis.horizontal,
//                           children: [
//                             for(var i=0; i<5; i++)
//                               GestureDetector(
//                                 onTap: (){
//                                   push(context: context, screen: Details_Page());
//                                 },
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       Stack(
//                                         children: [
//                                           Container(
//                                             width: MediaQuery.of(context).size.width / 2 - 16,
//                                             margin: EdgeInsets.only(right: 8),
//                                             decoration: BoxDecoration(
//                                                 color: Colors.black,
//                                                 border: Border.all(
//                                                   color: MyColors.primaryColor,
//                                                 ),
//                                                 borderRadius: BorderRadius.circular(12)
//                                             ),
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 ClipRRect(
//                                                   borderRadius: BorderRadius.only(
//                                                     topLeft: Radius.circular(12),
//                                                     topRight: Radius.circular(12),
//                                                   ),
//                                                   child: Image.asset(latest[i],
//                                                     height: 170,
//                                                     width: MediaQuery.of(context).size.width,
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 ),
//                                                 vSizedBox05,
//                                                 Container(
//                                                   padding: EdgeInsets.symmetric(horizontal: 8),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       ParagraphText(text: 'Harry Potter and the Philosopher\'s Stone (2001)',
//                                                         fontSize: 12,
//                                                         fontFamily: 'medium',
//                                                         maxline: 2,
//
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           ParagraphText(text: 'IMDB : ',
//                                                             color: MyColors.yellow,
//                                                             fontSize: 12,
//                                                             fontFamily: 'bold',
//                                                           ),
//                                                           ParagraphText(text: '8.9/10',
//                                                             color: MyColors.white,
//                                                             fontSize: 12,
//                                                             fontFamily: 'regular',
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       vSizedBox05,
//                                                       // if(i==0 || i==2 || i==4)
//                                                       Row(
//                                                         children: [
//                                                           RoundEdgedButton(
//                                                             text: 'Seen',
//                                                             textColor: Colors.white,
//                                                             borderRadius: 8,
//                                                             fontfamily: 'semibold',
//                                                             width: 60,
//                                                             horizontalMargin: 0,
//                                                             horizontalPadding: 0,
//                                                             verticalPadding: 0,
//                                                             height: 25,
//                                                             fontSize: 14,
//                                                           ), hSizedBox05,
//                                                           RoundEdgedButton(
//                                                             text: 'Share',
//                                                             textColor: Colors.white,
//                                                             borderRadius: 8,
//                                                             fontfamily: 'semibold',
//                                                             width: 60,
//                                                             horizontalMargin: 0,
//                                                             horizontalPadding: 0,
//                                                             verticalPadding: 0,
//                                                             height: 25,
//                                                             fontSize: 14,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       // if(i==1 || i==3)
//                                                       //   vSizedBox2,
//                                                       // SizedBox(height:19,),
//                                                       //   RoundEdgedButton(
//                                                       //     text: 'Watch now',
//                                                       //     textColor: Colors.white,
//                                                       //     width: 80,
//                                                       //     horizontalMargin: 0,
//                                                       //     horizontalPadding: 0,
//                                                       //     verticalPadding: 0,
//                                                       //     height: 20,
//                                                       //     fontSize: 12,
//                                                       //   ),
//                                                       SizedBox(height: 4,)
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Positioned(
//                                               top: 1,
//                                               left: 1,
//                                               child: Container(
//                                                 width: MediaQuery.of(context).size.width / 2 - 18,
//                                                 height: 220,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   gradient: LinearGradient(
//                                                       colors: [Colors.black.withOpacity(1), Colors.transparent],
//                                                       begin: Alignment.topCenter,
//                                                       end: Alignment.bottomCenter,
//                                                       stops: [0.0, 0.50]
//                                                   ),
//                                                 ),
//                                               )
//                                           ),
//                                           Positioned(
//                                             left: 16,
//                                             top: 16,
//                                             child: GestureDetector(
//                                               onTap: (){
//
//                                               },
//                                               child: Image.asset(MyImages.hulu, width: 50,),
//                                             ),
//                                           ),
//                                           // Positioned(
//                                           //   right: 16,
//                                           //   top: 16,
//                                           //   child: GestureDetector(
//                                           //     onTap: (){
//                                           //
//                                           //     },
//                                           //     child: RoundEdgedButton(
//                                           //       text: 'Seen',
//                                           //       textColor: Colors.white,
//                                           //       width: 40,
//                                           //       horizontalMargin: 0,
//                                           //       horizontalPadding: 0,
//                                           //       verticalPadding: 0,
//                                           //       height: 20,
//                                           //       fontSize: 12,
//                                           //
//                                           //     )
//                                           //
//                                           //     ,
//                                           //   ),
//                                           // )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                     vSizedBox2,
//                   ],
//                 ),
//               if(hideone == true)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child:   Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           DropdownButtonHideUnderline(
//                             child: DropdownButton2(
//                               isExpanded: true,
//                               hint: Text(
//                                 'Filter by provider',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.white,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               items: items
//                                   .map((item) => DropdownMenuItem<String>(
//                                 value: item,
//                                 child: Text(
//                                   item,
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ))
//                                   .toList(),
//                               value: selectedValue,
//                               onChanged: (value) {
//                                 setState(() {
//                                   selectedValue = value as String;
//                                 });
//                               },
//                               icon: const Icon(
//                                 Icons.expand_more_outlined,
//                               ),
//                               iconSize: 20,
//                               iconEnabledColor: Colors.white,
//                               iconDisabledColor: Colors.grey,
//                               buttonHeight: 38,
//                               buttonWidth: 180,
//                               buttonPadding: const EdgeInsets.only(left: 14, right: 14),
//                               buttonDecoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 // border: Border.all(
//                                 //   color: Colors.black26,
//                                 // ),
//                                 color: MyColors.primaryColor,
//                               ),
//                               buttonElevation: 2,
//                               itemHeight: 40,
//                               itemPadding: const EdgeInsets.only(left: 14, right: 14),
//                               dropdownMaxHeight: 200,
//                               dropdownWidth: 180,
//                               dropdownPadding: null,
//                               dropdownDecoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 color: Colors.white,
//                               ),
//                               dropdownElevation: 8,
//                               scrollbarRadius: const Radius.circular(40),
//                               scrollbarThickness: 6,
//                               scrollbarAlwaysShow: true,
//                               offset: const Offset(0, 0),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     vSizedBox2,
//                     // Add Section
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Image.asset(MyImages.addtwo),
//                     ),
//                     vSizedBox2,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ParagraphText(text: 'Recommendations', fontSize: 16, fontFamily: 'medium',),
//                           GestureDetector(
//                             onTap: (){
//
//                             },
//                             child: ParagraphText(
//                               text: 'See all',
//                               color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
//
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     vSizedBox05,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Container(
//                         height: 270,
//                         child: ListView(
//                           clipBehavior: Clip.none,
//                           scrollDirection: Axis.horizontal,
//                           children: [
//                             for(var i=0; i<5; i++)
//                               GestureDetector(
//                                 onTap: (){
//                                   push(context: context, screen: Details_Page());
//                                 },
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       Stack(
//                                         children: [
//                                           Container(
//                                             width: MediaQuery.of(context).size.width / 2 - 16,
//                                             margin: EdgeInsets.only(right: 8),
//                                             decoration: BoxDecoration(
//                                                 color: Colors.black,
//                                                 border: Border.all(
//                                                   color: MyColors.primaryColor,
//                                                 ),
//                                                 borderRadius: BorderRadius.circular(12)
//                                             ),
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 ClipRRect(
//                                                   borderRadius: BorderRadius.only(
//                                                     topLeft: Radius.circular(12),
//                                                     topRight: Radius.circular(12),
//                                                   ),
//                                                   child: Image.asset(latest[i],
//                                                     height: 170,
//                                                     width: MediaQuery.of(context).size.width,
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 ),
//                                                 vSizedBox05,
//                                                 Container(
//                                                   padding: EdgeInsets.symmetric(horizontal: 8),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       ParagraphText(text: 'Harry Potter and the Philosopher\'s Stone (2001)',
//                                                         fontSize: 12,
//                                                         fontFamily: 'medium',
//                                                         maxline: 2,
//
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           ParagraphText(text: 'IMDB : ',
//                                                             color: MyColors.yellow,
//                                                             fontSize: 12,
//                                                             fontFamily: 'bold',
//                                                           ),
//                                                           ParagraphText(text: '8.9/10',
//                                                             color: MyColors.white,
//                                                             fontSize: 12,
//                                                             fontFamily: 'regular',
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       vSizedBox05,
//                                                       // if(i==0 || i==2 || i==4)
//                                                       Row(
//                                                         children: [
//                                                           RoundEdgedButton(
//                                                             text: 'Seen',
//                                                             textColor: Colors.white,
//                                                             borderRadius: 8,
//                                                             fontfamily: 'semibold',
//                                                             width: 60,
//                                                             horizontalMargin: 0,
//                                                             horizontalPadding: 0,
//                                                             verticalPadding: 0,
//                                                             height: 25,
//                                                             fontSize: 14,
//                                                           ), hSizedBox05,
//                                                           RoundEdgedButton(
//                                                             text: 'Share',
//                                                             textColor: Colors.white,
//                                                             borderRadius: 8,
//                                                             fontfamily: 'semibold',
//                                                             width: 60,
//                                                             horizontalMargin: 0,
//                                                             horizontalPadding: 0,
//                                                             verticalPadding: 0,
//                                                             height: 25,
//                                                             fontSize: 14,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       // if(i==1 || i==3)
//                                                       //   vSizedBox2,
//                                                       // SizedBox(height:19,),
//                                                       //   RoundEdgedButton(
//                                                       //     text: 'Watch now',
//                                                       //     textColor: Colors.white,
//                                                       //     width: 80,
//                                                       //     horizontalMargin: 0,
//                                                       //     horizontalPadding: 0,
//                                                       //     verticalPadding: 0,
//                                                       //     height: 20,
//                                                       //     fontSize: 12,
//                                                       //   ),
//                                                       SizedBox(height: 4,)
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Positioned(
//                                               top: 1,
//                                               left: 1,
//                                               child: Container(
//                                                 width: MediaQuery.of(context).size.width / 2 - 18,
//                                                 height: 220,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   gradient: LinearGradient(
//                                                       colors: [Colors.black.withOpacity(1), Colors.transparent],
//                                                       begin: Alignment.topCenter,
//                                                       end: Alignment.bottomCenter,
//                                                       stops: [0.0, 0.50]
//                                                   ),
//                                                 ),
//                                               )
//                                           ),
//                                           Positioned(
//                                             left: 16,
//                                             top: 16,
//                                             child: GestureDetector(
//                                               onTap: (){
//
//                                               },
//                                               child: Image.asset(streamlist[i], width: 50,),
//                                             ),
//                                           ),
//                                           // Positioned(
//                                           //   right: 16,
//                                           //   top: 16,
//                                           //   child: GestureDetector(
//                                           //     onTap: (){
//                                           //
//                                           //     },
//                                           //     child: RoundEdgedButton(
//                                           //       text: 'Seen',
//                                           //       textColor: Colors.white,
//                                           //       width: 40,
//                                           //       horizontalMargin: 0,
//                                           //       horizontalPadding: 0,
//                                           //       verticalPadding: 0,
//                                           //       height: 20,
//                                           //       fontSize: 12,
//                                           //
//                                           //     )
//                                           //
//                                           //     ,
//                                           //   ),
//                                           // )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                     vSizedBox2,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ParagraphText(text: 'Live & Upcoming Games', fontSize: 16, fontFamily: 'medium',),
//                           GestureDetector(
//                             onTap: (){
//
//                             },
//                             child: ParagraphText(
//                               text: 'See all',
//                               color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
//
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     vSizedBox,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Container(
//                         height: 270,
//                         child: ListView(
//                           clipBehavior: Clip.none,
//                           scrollDirection: Axis.horizontal,
//                           children: [
//                             for(var i=0; i<5; i++)
//                               GestureDetector(
//                                 onTap: (){
//                                   push(context: context, screen: Details_Page());
//                                 },
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       Stack(
//                                         children: [
//                                           Container(
//                                             width: MediaQuery.of(context).size.width / 2 - 16,
//                                             margin: EdgeInsets.only(right: 8),
//                                             decoration: BoxDecoration(
//                                                 color: Colors.black,
//                                                 border: Border.all(
//                                                   color: MyColors.primaryColor,
//                                                 ),
//                                                 borderRadius: BorderRadius.circular(12)
//                                             ),
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 ClipRRect(
//                                                   borderRadius: BorderRadius.only(
//                                                     topLeft: Radius.circular(12),
//                                                     topRight: Radius.circular(12),
//                                                   ),
//                                                   child: Image.asset(latest[i],
//                                                     height: 170,
//                                                     width: MediaQuery.of(context).size.width,
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 ),
//                                                 vSizedBox05,
//                                                 Container(
//                                                   padding: EdgeInsets.symmetric(horizontal: 8),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       ParagraphText(text: 'Harry Potter and the Philosopher\'s Stone (2001)',
//                                                         fontSize: 12,
//                                                         fontFamily: 'medium',
//                                                         maxline: 2,
//
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           ParagraphText(text: 'IMDB : ',
//                                                             color: MyColors.yellow,
//                                                             fontSize: 12,
//                                                             fontFamily: 'bold',
//                                                           ),
//                                                           ParagraphText(text: '8.9/10',
//                                                             color: MyColors.white,
//                                                             fontSize: 12,
//                                                             fontFamily: 'regular',
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       vSizedBox05,
//                                                       // if(i==0 || i==2 || i==4)
//                                                       Row(
//                                                         children: [
//                                                           RoundEdgedButton(
//                                                             text: 'Seen',
//                                                             textColor: Colors.white,
//                                                             borderRadius: 8,
//                                                             fontfamily: 'semibold',
//                                                             width: 60,
//                                                             horizontalMargin: 0,
//                                                             horizontalPadding: 0,
//                                                             verticalPadding: 0,
//                                                             height: 25,
//                                                             fontSize: 14,
//                                                           ), hSizedBox05,
//                                                           RoundEdgedButton(
//                                                             text: 'Share',
//                                                             textColor: Colors.white,
//                                                             borderRadius: 8,
//                                                             fontfamily: 'semibold',
//                                                             width: 60,
//                                                             horizontalMargin: 0,
//                                                             horizontalPadding: 0,
//                                                             verticalPadding: 0,
//                                                             height: 25,
//                                                             fontSize: 14,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       // if(i==1 || i==3)
//                                                       //   vSizedBox2,
//                                                       // SizedBox(height:19,),
//                                                       //   RoundEdgedButton(
//                                                       //     text: 'Watch now',
//                                                       //     textColor: Colors.white,
//                                                       //     width: 80,
//                                                       //     horizontalMargin: 0,
//                                                       //     horizontalPadding: 0,
//                                                       //     verticalPadding: 0,
//                                                       //     height: 20,
//                                                       //     fontSize: 12,
//                                                       //   ),
//                                                       SizedBox(height: 4,)
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Positioned(
//                                               top: 1,
//                                               left: 1,
//                                               child: Container(
//                                                 width: MediaQuery.of(context).size.width / 2 - 18,
//                                                 height: 220,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   gradient: LinearGradient(
//                                                       colors: [Colors.black.withOpacity(1), Colors.transparent],
//                                                       begin: Alignment.topCenter,
//                                                       end: Alignment.bottomCenter,
//                                                       stops: [0.0, 0.50]
//                                                   ),
//                                                 ),
//                                               )
//                                           ),
//                                           Positioned(
//                                             left: 16,
//                                             top: 16,
//                                             child: GestureDetector(
//                                               onTap: (){
//
//                                               },
//                                               child: Image.asset(streamlist[i], width: 50,),
//                                             ),
//                                           ),
//                                           // Positioned(
//                                           //   right: 16,
//                                           //   top: 16,
//                                           //   child: GestureDetector(
//                                           //     onTap: (){
//                                           //
//                                           //     },
//                                           //     child: RoundEdgedButton(
//                                           //       text: 'Seen',
//                                           //       textColor: Colors.white,
//                                           //       width: 40,
//                                           //       horizontalMargin: 0,
//                                           //       horizontalPadding: 0,
//                                           //       verticalPadding: 0,
//                                           //       height: 20,
//                                           //       fontSize: 12,
//                                           //
//                                           //     )
//                                           //
//                                           //     ,
//                                           //   ),
//                                           // )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                     vSizedBox2,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ParagraphText(text: 'Past Games ', fontSize: 16, fontFamily: 'medium',),
//                           GestureDetector(
//                             onTap: (){
//
//                             },
//                             child: ParagraphText(
//                               text: 'See all',
//                               color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
//
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     vSizedBox,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Container(
//                         height: 270,
//                         child: ListView(
//                           clipBehavior: Clip.none,
//                           scrollDirection: Axis.horizontal,
//                           children: [
//                             for(var i=0; i<5; i++)
//                               GestureDetector(
//                                 onTap: (){
//                                   push(context: context, screen: Details_Page());
//                                 },
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       Stack(
//                                         children: [
//                                           Container(
//                                             width: MediaQuery.of(context).size.width / 2 - 16,
//                                             margin: EdgeInsets.only(right: 8),
//                                             decoration: BoxDecoration(
//                                                 color: Colors.black,
//                                                 border: Border.all(
//                                                   color: MyColors.primaryColor,
//                                                 ),
//                                                 borderRadius: BorderRadius.circular(12)
//                                             ),
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 ClipRRect(
//                                                   borderRadius: BorderRadius.only(
//                                                     topLeft: Radius.circular(12),
//                                                     topRight: Radius.circular(12),
//                                                   ),
//                                                   child: Image.asset(latest[i],
//                                                     height: 170,
//                                                     width: MediaQuery.of(context).size.width,
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 ),
//                                                 vSizedBox05,
//                                                 Container(
//                                                   padding: EdgeInsets.symmetric(horizontal: 8),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       ParagraphText(text: 'Harry Potter and the Philosopher\'s Stone (2001)',
//                                                         fontSize: 12,
//                                                         fontFamily: 'medium',
//                                                         maxline: 2,
//
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           ParagraphText(text: 'IMDB : ',
//                                                             color: MyColors.yellow,
//                                                             fontSize: 12,
//                                                             fontFamily: 'bold',
//                                                           ),
//                                                           ParagraphText(text: '8.9/10',
//                                                             color: MyColors.white,
//                                                             fontSize: 12,
//                                                             fontFamily: 'regular',
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       vSizedBox05,
//                                                       // if(i==0 || i==2 || i==4)
//                                                       Row(
//                                                         children: [
//                                                           RoundEdgedButton(
//                                                             text: 'Seen',
//                                                             textColor: Colors.white,
//                                                             borderRadius: 8,
//                                                             fontfamily: 'semibold',
//                                                             width: 60,
//                                                             horizontalMargin: 0,
//                                                             horizontalPadding: 0,
//                                                             verticalPadding: 0,
//                                                             height: 25,
//                                                             fontSize: 14,
//                                                           ), hSizedBox05,
//                                                           RoundEdgedButton(
//                                                             text: 'Share',
//                                                             textColor: Colors.white,
//                                                             borderRadius: 8,
//                                                             fontfamily: 'semibold',
//                                                             width: 60,
//                                                             horizontalMargin: 0,
//                                                             horizontalPadding: 0,
//                                                             verticalPadding: 0,
//                                                             height: 25,
//                                                             fontSize: 14,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       // if(i==1 || i==3)
//                                                       //   vSizedBox2,
//                                                       // SizedBox(height:19,),
//                                                       //   RoundEdgedButton(
//                                                       //     text: 'Watch now',
//                                                       //     textColor: Colors.white,
//                                                       //     width: 80,
//                                                       //     horizontalMargin: 0,
//                                                       //     horizontalPadding: 0,
//                                                       //     verticalPadding: 0,
//                                                       //     height: 20,
//                                                       //     fontSize: 12,
//                                                       //   ),
//                                                       SizedBox(height: 4,)
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Positioned(
//                                               top: 1,
//                                               left: 1,
//                                               child: Container(
//                                                 width: MediaQuery.of(context).size.width / 2 - 18,
//                                                 height: 220,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   gradient: LinearGradient(
//                                                       colors: [Colors.black.withOpacity(1), Colors.transparent],
//                                                       begin: Alignment.topCenter,
//                                                       end: Alignment.bottomCenter,
//                                                       stops: [0.0, 0.50]
//                                                   ),
//                                                 ),
//                                               )
//                                           ),
//                                           Positioned(
//                                             left: 16,
//                                             top: 16,
//                                             child: GestureDetector(
//                                               onTap: (){
//
//                                               },
//                                               child: Image.asset(MyImages.netflix_logo, width: 50,),
//                                             ),
//                                           ),
//                                           // Positioned(
//                                           //   right: 16,
//                                           //   top: 16,
//                                           //   child: GestureDetector(
//                                           //     onTap: (){
//                                           //
//                                           //     },
//                                           //     child: RoundEdgedButton(
//                                           //       text: 'Seen',
//                                           //       textColor: Colors.white,
//                                           //       width: 40,
//                                           //       horizontalMargin: 0,
//                                           //       horizontalPadding: 0,
//                                           //       verticalPadding: 0,
//                                           //       height: 20,
//                                           //       fontSize: 12,
//                                           //
//                                           //     )
//                                           //
//                                           //     ,
//                                           //   ),
//                                           // )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                     vSizedBox2,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ParagraphText(text: ' All Sports ', fontSize: 16, fontFamily: 'medium',),
//                           GestureDetector(
//                             onTap: (){
//
//                             },
//                             child: ParagraphText(
//                               text: 'See all',
//                               color: MyColors.primaryColor,fontSize: 16, fontFamily: 'medium',
//
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     vSizedBox,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Container(
//                         height: 270,
//                         child: ListView(
//                           clipBehavior: Clip.none,
//                           scrollDirection: Axis.horizontal,
//                           children: [
//                             for(var i=0; i<5; i++)
//                               GestureDetector(
//                                 onTap: (){
//                                   push(context: context, screen: Details_Page());
//                                 },
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       Stack(
//                                         children: [
//                                           Container(
//                                             width: MediaQuery.of(context).size.width / 2 - 16,
//                                             margin: EdgeInsets.only(right: 8),
//                                             decoration: BoxDecoration(
//                                                 color: Colors.black,
//                                                 border: Border.all(
//                                                   color: MyColors.primaryColor,
//                                                 ),
//                                                 borderRadius: BorderRadius.circular(12)
//                                             ),
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 ClipRRect(
//                                                   borderRadius: BorderRadius.only(
//                                                     topLeft: Radius.circular(12),
//                                                     topRight: Radius.circular(12),
//                                                   ),
//                                                   child: Image.asset(latest[i],
//                                                     height: 170,
//                                                     width: MediaQuery.of(context).size.width,
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 ),
//                                                 vSizedBox05,
//                                                 Container(
//                                                   padding: EdgeInsets.symmetric(horizontal: 8),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       ParagraphText(text: 'Harry Potter and the Philosopher\'s Stone (2001)',
//                                                         fontSize: 12,
//                                                         fontFamily: 'medium',
//                                                         maxline: 2,
//
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           ParagraphText(text: 'IMDB : ',
//                                                             color: MyColors.yellow,
//                                                             fontSize: 12,
//                                                             fontFamily: 'bold',
//                                                           ),
//                                                           ParagraphText(text: '8.9/10',
//                                                             color: MyColors.white,
//                                                             fontSize: 12,
//                                                             fontFamily: 'regular',
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       vSizedBox05,
//                                                       // if(i==0 || i==2 || i==4)
//                                                       Row(
//                                                         children: [
//                                                           RoundEdgedButton(
//                                                             text: 'Seen',
//                                                             textColor: Colors.white,
//                                                             borderRadius: 8,
//                                                             fontfamily: 'semibold',
//                                                             width: 60,
//                                                             horizontalMargin: 0,
//                                                             horizontalPadding: 0,
//                                                             verticalPadding: 0,
//                                                             height: 25,
//                                                             fontSize: 14,
//                                                           ), hSizedBox05,
//                                                           RoundEdgedButton(
//                                                             text: 'Share',
//                                                             textColor: Colors.white,
//                                                             borderRadius: 8,
//                                                             fontfamily: 'semibold',
//                                                             width: 60,
//                                                             horizontalMargin: 0,
//                                                             horizontalPadding: 0,
//                                                             verticalPadding: 0,
//                                                             height: 25,
//                                                             fontSize: 14,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       // if(i==1 || i==3)
//                                                       //   vSizedBox2,
//                                                       // SizedBox(height:19,),
//                                                       //   RoundEdgedButton(
//                                                       //     text: 'Watch now',
//                                                       //     textColor: Colors.white,
//                                                       //     width: 80,
//                                                       //     horizontalMargin: 0,
//                                                       //     horizontalPadding: 0,
//                                                       //     verticalPadding: 0,
//                                                       //     height: 20,
//                                                       //     fontSize: 12,
//                                                       //   ),
//                                                       SizedBox(height: 4,)
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Positioned(
//                                               top: 1,
//                                               left: 1,
//                                               child: Container(
//                                                 width: MediaQuery.of(context).size.width / 2 - 18,
//                                                 height: 220,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   gradient: LinearGradient(
//                                                       colors: [Colors.black.withOpacity(1), Colors.transparent],
//                                                       begin: Alignment.topCenter,
//                                                       end: Alignment.bottomCenter,
//                                                       stops: [0.0, 0.50]
//                                                   ),
//                                                 ),
//                                               )
//                                           ),
//                                           Positioned(
//                                             left: 16,
//                                             top: 16,
//                                             child: GestureDetector(
//                                               onTap: (){
//
//                                               },
//                                               child: Image.asset(MyImages.hulu, width: 50,),
//                                             ),
//                                           ),
//                                           // Positioned(
//                                           //   right: 16,
//                                           //   top: 16,
//                                           //   child: GestureDetector(
//                                           //     onTap: (){
//                                           //
//                                           //     },
//                                           //     child: RoundEdgedButton(
//                                           //       text: 'Seen',
//                                           //       textColor: Colors.white,
//                                           //       width: 40,
//                                           //       horizontalMargin: 0,
//                                           //       horizontalPadding: 0,
//                                           //       verticalPadding: 0,
//                                           //       height: 20,
//                                           //       fontSize: 12,
//                                           //
//                                           //     )
//                                           //
//                                           //     ,
//                                           //   ),
//                                           // )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                     vSizedBox2,
//                   ],
//                 ),
//
//
//
//
//             ],
//           ),
//         ),
//       ),
//         drawer: get_drawer(context)
//     );
//   }
// }
