import 'package:flutter/material.dart';

import 'image_urls.dart';
bool staticVisible = false;
BoxShadow boxShadow = BoxShadow(
color: Color(0xFF000000).withOpacity(0.04),
offset: Offset(0.0,10.0),
spreadRadius: 0.0,
blurRadius: 11.0
);

BoxShadow shadow = BoxShadow(
color: Color(0xFF000000).withOpacity(0.09),
offset: Offset(0.0,3.0),
spreadRadius: 0.0,
blurRadius: 12.0
);

BoxShadow boxShadowtop = BoxShadow(
color: Color(0xFF000000).withOpacity(0.09),
offset: Offset(0.0,-1.0),
spreadRadius: 0.0,
blurRadius: 12.0
);



EdgeInsets pad_horizontal = EdgeInsets.symmetric(horizontal: 16);


enum UserType{
  user,provider
}

UserType currentUserType = UserType.user;


List<Map<String, dynamic>> imgList= [
  {
    "url":'assets/images/slider2.png', },
  {
    "url":'assets/images/slider3.png',},
  {
    "url":'assets/images/slider4.png', }
];

List movielist = [
  'assets/images/stream1.png',
  'assets/images/img1.jpg',
  'assets/images/img2.png',
  'assets/images/slider.png',
  'assets/images/img2.png',
];

List latest = [
  MyImages.movie_one,
  MyImages.movie_two,
  MyImages.movie_three,
  MyImages.movie_four,
  MyImages.movie_five,
  MyImages.movie_six,
];

List streamlist = [
  'assets/images/netflixlogo.png',
  'assets/images/prime_logo.png',
  'assets/images/peacock_x.png',
  'assets/images/netflixlogo.png',
  'assets/images/prime_logo.png',
];