import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/auth.dart';
import 'package:livestream/constants/image_urls.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/services/webservices.dart';
import 'package:livestream/widgets/CustomTexts.dart';
import 'package:livestream/widgets/appbar.dart';
import 'package:livestream/widgets/buttons.dart';
import 'package:livestream/widgets/customtextfield.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:livestream/widgets/showSnackbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../constants/colors.dart';
import '../constants/global_data.dart';
import '../functions/navigation_functions.dart';
import '../widgets/MediaBox.dart';
import 'detail.dart';

class SearchPage extends StatefulWidget {
  final bool filter;

  const SearchPage({
    required this.filter,
    Key? key
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

bool isChecked = false;

class _SearchPageState extends State<SearchPage> {
  ScrollController _controller =
  ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  int lastCall=0;
  double min = DateTime.now().year-75;
  double max = DateTime.now().year+5;
  RangeValues _currentRangeValues = RangeValues(DateTime.now().year-20, DateTime.now().year+5);
  // int page=1;
  bool loading = false;
  Map selected_genre={};
  Map selected_content={};
  String selected_category="";

  final List<String> items = [
    '2001 - 2002',
    '2002 - 2003',
    '2004 - 2005',
  ];


  final List text = [
    'Latest movies',
    'Upcoming movies',
    'Top 10 rated movies',
    'New seasons',
    'Upcoming seasons',
    'Retiring TV shows',
    'Popular TV shows',
    'Popular games',
    'Most rated games',
    'Upcoming games',
    'Latest movies',
  ];


  String? selectedValue;
  TextEditingController search = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();



  int _selectedIndex = 0;
  bool show=false;

  Map searchParams={
    "media_type":{"value":""},
    "genres":{"value":""},
    "keywords":{"value":""},
    "page":{"value":"1"},
    "start_date":{"value":""},
    "end_date":{"value":""},
    "media_category":{"value":""}

  };

  List results=[];
  late FocusNode myFocusNode;
  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }


  @override
  void initState() {
    myFocusNode = FocusNode();
    // TODO: implement initState
    _controller.addListener(() {

      var isEnd = _controller.offset == _controller.position.maxScrollExtent;

      if (isEnd) {
        print('object-789');
        // log('reach end - '+page.toString());
        // s etState(() {
        if (loading == false) {
          print('object-555');

          getResults(false);

          //  get_transactions();
        }

        // });
      }
    });

    getALL();
    super.initState();
  }



  getALL() async{
     if(widget.filter==true){
      showFilter();
    }
    else{
      myFocusNode.requestFocus();
    }
    applyFilter(true);
    // getResults();
    setState(() {
      // show=true;
    });

  }

  getResults(bool isFirst) async{
    int callId=new Random().nextInt(100);
    lastCall = callId;
    loading = true;
    if(this.mounted)
    setState(() {});
    bool hasNewData=false;
    if(searchParams['page']['value']=="1"){
      results=[];
    }
    Map res = await Webservices.getData('search', searchParams);
    if(lastCall==callId){
      if(res["status"].toString()=='1'){
        if(loading==false && isFirst==true){
          return;
        }
        loading = false;
        if(this.mounted)
        setState(() {});
        if(searchParams['page']['value']=='1'){
          results=[];
        }
        if (res['data'].length > 0) {
          for(int m=0;m<res["data"].length;m++){
            results.add(res["data"][m]);
          }
          searchParams['page']['value'] = (int.parse(searchParams['page']['value'])+1).toString();

        }


        if(this.mounted)
        setState(() {

        });



      }
      else{

        showSnackbar(res['message']);
        loading = false;
        if(this.mounted)
        setState(() {      });
      }
    }

    // log("this is response"+res.toString());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        appBar:
            appBar(context: context, title: 'Search', titleColor: Colors.white,
                actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                ),
              )
            ]),
        body: Container(
          color: MyColors.black,
          child: ListView(
            controller: _controller,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30
                          ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              textInputAction: TextInputAction.search,
                              controller: search,
                              focusNode: myFocusNode,

                              onChange: (value){
                                if(value==null || value ==''){
                                  searchParams["keywords"]["value"]="";
                                  searchParams['page']['value'] = "1";
                                  getResults(false);
                                  setState(() {});
                                }
                              },
                              onSubmitted: (value){
                                searchParams["keywords"]["value"]=search.text;
                                searchParams['page']['value'] = "1";
                                getResults(false);

                                setState(() {});

                              },
                              hintText: 'Search',
                              prefixIcon: MyImages.search,
                              borderradius: 0,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                print("show filter");
                                showFilter();

                              },
                              child: Image.asset(
                                MyImages.filter,
                                height: 45,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                vSizedBox2,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if(search.text!='' && false)
                      ParagraphText(
                        text: 'Search results for:',
                        fontSize: 16,
                        fontFamily: 'medium',
                      ),
                      if(search.text!='' && false)
                      ParagraphText(
                        text: ' '+search.text,
                        color: MyColors.primaryColor,
                        fontSize: 16,
                        fontFamily: 'medium',
                      )
                    ],
                  ),
                ),
                vSizedBox05,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    runSpacing: 16,
                    spacing: 8,
                    children: [
                      for (var i = 0; i < results.length; i++)
                        MediaBox(
                          marginRight: (i%2==0)?8:0,
                          data: results[i],
                          onTap: (){
                            goDetails(context: context, data: results[i], mediaType: MediaType.movie);
                          },

                        ),
                    ],
                  ),
                ),

                if(loading==false)
                  SizedBox(height:60),

                if(loading==true && searchParams['page']['value'] == "1")
                  SizedBox(height:100),


                if(loading==true)
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

                SizedBox(height:10)
              ],

          ),
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ));
  }

  showFilter(){
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(builder:
            (BuildContext context,
            StateSetter setState) {
          return Container(
            height: 700,
            padding: EdgeInsets.symmetric(
                horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ParagraphText(
                    text: 'Filter',
                    fontFamily: 'semibold',
                    fontSize: 28,
                    color: Colors.black,
                  ),
                  vSizedBox,
                  ParagraphText(
                    text: 'Filter by genre',
                    fontFamily: 'medium',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  vSizedBox,
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      for(int i=0; i<genreList.length&&i<10;i++)
                        FittedBox(
                          // width: MediaQuery.of(context).size.width / 3.5,
                          child: Row(
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.black,
                                    backgroundColor: Colors.white),
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  // fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: selected_genre[genreList[i]['tvdb_id'].toString()]??false,
                                  activeColor: MyColors.black,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if(value!=null){
                                        if(value==true)
                                          selected_genre[genreList[i]['tvdb_id'].toString()]=true;
                                        else
                                          selected_genre.remove(genreList[i]['tvdb_id'].toString());
                                      }



                                      // genreList[i]['genreChecked'] = value!;

                                      // isChecked = value!;
                                    });
                                  },
                                ),
                              ),
                              ParagraphText(
                                text: genreList[i]['name'],
                                color: Colors.black,
                                fontSize: 14,
                              )
                            ],
                          ),
                        ),

                    ],
                  ),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: ParagraphText(
                          text:
                          'Click here for more actions',
                          underlined: true,
                          color: MyColors.black,
                          fontSize: 12,
                          fontFamily: 'medium',
                        ),
                        onTap: () async{
                          await showModalBottomSheet<void>(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContextcontext) {
                                return StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      return Container(
                                        padding: EdgeInsets.only(top: 80),
                                        height: MediaQuery.of(context).size.height,
                                        color: MyColors.white,
                                        child: Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                  child: ParagraphText(
                                                    text: 'Filter by genre',
                                                    fontFamily: 'medium',
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                vSizedBox,
                                                Wrap(
                                                  runSpacing: 0, spacing: 10,
                                                  children: [
                                                    for(int i=0; i<genreList.length;i++)
                                                      FittedBox(
                                                        // width: MediaQuery.of(context).size.width / 3.5,
                                                        child: Row(
                                                          children: [
                                                            Theme(
                                                              data: Theme.of(context).copyWith(
                                                                  unselectedWidgetColor: Colors.black,
                                                                  backgroundColor: Colors.white),
                                                              child: Checkbox(
                                                                checkColor: Colors.white,
                                                                // fillColor: MaterialStateProperty.resolveWith(getColor),
                                                                value: selected_genre[genreList[i]['tvdb_id']]??false,
                                                                activeColor: MyColors.black,
                                                                onChanged: (bool? value) {
                                                                  setState(() {
                                                                    if(value!=null){
                                                                      if(value==true)
                                                                        selected_genre[genreList[i]['tvdb_id'].toString()]=true;
                                                                      else
                                                                        selected_genre.remove(genreList[i]['tvdb_id'].toString());
                                                                    }
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            ParagraphText(
                                                              text: genreList[i]['name'],
                                                              color: Colors.black,
                                                              fontSize: 14,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Padding(
                                                padding: EdgeInsets.all(16),
                                                child:  RoundEdgedButton(
                                                  onTap:(){

                                                    Navigator.pop(context);
                                                    showSnackbar("coming soon!");
                                                  },
                                                  text: 'Done',

                                                  textColor: Colors.white,
                                                  minWidth: 150,
                                                  horizontalPadding: 0,
                                                  borderRadius: 30,
                                                  color:
                                                  MyColors.primaryColor,
                                                  fontSize: 16,
                                                  height: 31,
                                                  verticalPadding: 0,
                                                  // onTap: (){
                                                  //
                                                  // },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              });
                          setState((){});
                        },
                      )
                    ],
                  ),

                  Divider(
                    height: 20,
                    color: Colors.black.withOpacity(0.10),
                  ),
                  vSizedBox,
                  ParagraphText(
                    text: 'Filter by content',
                    fontFamily: 'medium',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  vSizedBox,
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      for(int i=0; i<contentList.length;i++)
                        FittedBox(
                          // width: MediaQuery.of(context).size.width / 3.5,
                          child: Row(
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.black,
                                    backgroundColor: Colors.white),
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  // fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value:selected_content[contentList[i]['slug'].toString()]??false,
                                  activeColor: MyColors.black,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if(value!=null){
                                        if(value==true)
                                          selected_content[contentList[i]['slug'].toString()]=true;
                                        else
                                          selected_content.remove(contentList[i]['slug'].toString());
                                      }
                                    });
                                  },
                                ),
                              ),
                              ParagraphText(
                                text: contentList[i]['name'],
                                color: Colors.black,
                                fontSize: 14,
                              )
                            ],
                          ),
                        ),

                    ],
                  ),

                  Divider(
                    height: 20,
                    color: Colors.black.withOpacity(0.10),
                  ),
                  vSizedBox,




                  ParagraphText(
                    text: 'Filter by year('+_currentRangeValues.start.toInt().toString()+' - '+_currentRangeValues.end.toInt().toString()+')' ,
                    fontFamily: 'medium',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  vSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Min:"+min.toInt().toString()),
                    Text("Max:"+max.toInt().toString())
                  ],),
                  RangeSlider(
                    activeColor: Colors.black,

                    values: _currentRangeValues,
                    max: max,
                    min:min,
                    divisions: (max.toInt() - min.toInt()),
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                    },
                  ),
                  // DropdownButtonHideUnderline(
                  //   child: DropdownButton2(
                  //     isExpanded: true,
                  //     hint: Text('2000 - 2001',
                  //       style: TextStyle(
                  //         fontSize: 14,
                  //         color: Colors.white,
                  //       ),
                  //       overflow: TextOverflow.ellipsis,
                  //     ),
                  //     items: items.map((item) =>
                  //         DropdownMenuItem<String>(
                  //           value: item,
                  //           child: Text(
                  //             item,
                  //             style: const TextStyle(
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.white,
                  //             ),
                  //             overflow: TextOverflow.ellipsis,
                  //           ),
                  //         ))
                  //         .toList(),
                  //     value: selectedValue,
                  //     onChanged: (value) {
                  //       set State(() {
                  //         selectedValue = value as String;
                  //       });
                  //     },
                  //     icon: const Icon(
                  //       Icons.expand_more_outlined,
                  //     ),
                  //     iconSize: 20,
                  //     iconEnabledColor: Colors.white,
                  //     iconDisabledColor: Colors.grey,
                  //     buttonHeight: 30,
                  //     buttonWidth: 155,
                  //     buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  //     buttonDecoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(30),
                  //       // border: Border.all(
                  //       //   color: Colors.black26,
                  //       // ),
                  //       color: Colors.black,
                  //     ),
                  //     buttonElevation: 2,
                  //     itemHeight: 40,
                  //     itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  //     dropdownMaxHeight: 200,
                  //     dropdownWidth: 250,
                  //     dropdownPadding: null,
                  //     dropdownDecoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8),
                  //       color: Colors.black,
                  //     ),
                  //     dropdownElevation: 8,
                  //     scrollbarRadius: const Radius.circular(40),
                  //     scrollbarThickness: 6,
                  //     scrollbarAlwaysShow: true,
                  //     offset: const Offset(0, 0),
                  //   ),
                  // ),
                  vSizedBox,
                  Divider(
                    height: 20,
                    color: Colors.black.withOpacity(0.10),
                  ),
                  vSizedBox,
                  ParagraphText(
                    text: 'Filter by Category',
                    fontFamily: 'medium',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  vSizedBox,
                  Wrap(
                    spacing: 10,
                    // runSpacing: 5,
                    children: [
                      for (var i = 0; i < mediaCategories.length; i++)
                        ChoiceChip(
                          labelPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          shape: StadiumBorder(
                              side: BorderSide(color: MyColors.bordercolor)
                          ),
                          backgroundColor: Colors.white,
                          selectedColor: MyColors.black,
                          selected: selected_category == mediaCategories[i]['slug'],
                          label: Text(
                            mediaCategories[i]['title'],
                            style: TextStyle(
                                color: mediaCategories[i]['slug'] == selected_category ? MyColors.white : MyColors.black,
                                fontFamily: 'medium',
                                fontSize: 14
                            ),
                          ),
                          onSelected: (selected) {
                            if (selected) {

                              setState(() {
                                selected_category = mediaCategories[i]['slug'];
                              });
                            }
                            else{
                              setState(() {
                                selected_category = '';
                              });
                            }
                          },
                        ),
                      hSizedBox,
                    ],
                  ),
                  vSizedBox,
                  Divider(
                    height: 20,
                    color: Colors.black.withOpacity(0.10),
                  ),

                  // vSizedBox4,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundEdgedButton(
                        text: 'Apply Filter',
                        textColor: Colors.white,
                        minWidth: 150,
                        horizontalPadding: 0,
                        borderRadius: 30,
                        color: MyColors.primaryColor,
                        fontSize: 16,
                        height: 31,
                        verticalPadding: 0,
                        onTap: (){
                          applyFilter(false);
                         Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  applyFilter(bool isFirst){
    searchParams['media_type']['value'] = selected_content.keys.toList().join(",");
    searchParams['genres']['value'] =  selected_genre.keys.toList().join(",");
    searchParams['media_category']['value']= selected_category;
    searchParams['start_date']['value'] = _currentRangeValues.start.toInt().toString();
    searchParams['end_date']['value']= _currentRangeValues.end.toInt().toString();
    searchParams['page']['value'] = "1";
    getResults(isFirst);
  }
}
