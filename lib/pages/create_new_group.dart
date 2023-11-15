import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/auth.dart';
import 'package:livestream/constants/image_urls.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/functions/globalFunctions.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/select_genres.dart';
import 'package:livestream/widgets/CustomTexts.dart';
import 'package:livestream/widgets/appbar.dart';
import 'package:livestream/widgets/avatar.dart';
import 'package:livestream/widgets/buttons.dart';
import 'package:livestream/widgets/custom_circular_image.dart';
import 'package:livestream/widgets/customtextfield.dart';
import '../functions/image_picker.dart';
import '../services/webservices.dart';
import '../widgets/showSnackbar.dart';
import 'chat_list_page.dart';
import 'homepage.dart';

import '../constants/colors.dart';
enum SingingCharacter { lafayette, jefferson }
class Create_New_Group_Page extends StatefulWidget {
  final String? group_id;
  const Create_New_Group_Page({
    Key? key,
    this.group_id
  }) : super(key: key);

  @override
  State<Create_New_Group_Page> createState() => _Create_New_Group_PageState();
}

int count = 0;
class _Create_New_Group_PageState extends State<Create_New_Group_Page> {
  SingingCharacter? _character = SingingCharacter.lafayette;
  TextEditingController search = TextEditingController();
  TextEditingController groupname = TextEditingController();
  String created_by="";
  ScrollController _controller =
  ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  bool isUpdate=false;

  bool isView=true;
 List prefrence=[];
  Widget? profile=null;
  File? groupIcon=null;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Map selected_users={

  };
  bool loading = false;
  bool groupCreating = false;
  Map searchParams={
    "page":{"value":"1"},
    "keywords":{"value":""}
  };
  List results=[];
  @override
  void initState() {
    // TODO: implement initState

     check();
    _controller.addListener(() {
      var isEnd = _controller.offset == _controller.position.maxScrollExtent;

      if (isEnd) {
        print('object-789');
        // log('reach end - '+page.toString());
        // setState(() {
        if (loading == false) {
          print('object-555');

          getUsers();

          //  get_transactions();
        }

        // });
      }
    });


    profile=Icon(Icons.groups, color: Colors.white, size:50);

    getUsers();
    super.initState();
  }

  check() async{

    if(widget.group_id!=null){
      getGroup();
    }
    else{
      isUpdate=false;
    }





  }

  getGroup() async {
    var params={
       "group_id":{"value":widget.group_id!}
    };
    Map res = await Webservices.getData('group-detail', params);

    print("group details----- ${res['data']}");
    groupname.text= res["data"]["title"];
    profile = Image.network(res["data"]["icon"]);

    String current_user = await getCurrentUserId();

    for(var i=0;i<res["data"]["members"].length;i++){
      if(res["data"]["members"][i]['user_id'].toString()!=current_user)
       selected_users[res["data"]["members"][i]['user_id'].toString()]=res["data"]["members"][i];
    }

    log('checking ------'+current_user+"---"+res["data"]["create_by"].toString());
    if(current_user==res["data"]["create_by"].toString()){

      isUpdate=true;
      isView=false;
    }
    else{
      isView=true;
      isUpdate=false;

    }


    setState(() {

    });
  }


  getUsers() async{
    loading = true;
    setState(() {});
    bool hasNewData=false;
    if(searchParams['page']['value']=="1"){
      results=[];
    }
    print("friends-----"+searchParams.toString());
    Map res = await Webservices.getData('my-friends', searchParams);
    if(res["status"].toString()=='1'){
      print(res.toString());
      loading = false;
      setState(() {});
      if(res["data"].toString()!='null'){
        for(int m=0;m<res["data"]['data'].length;m++){
          hasNewData = true;
          res["data"]["data"][m]['load']=false;
          results.add(res["data"]["data"][m]);
        }

      }

      if(hasNewData==true){
        searchParams['page']['value']= (int.parse(searchParams['page']['value'])+1).toString();
        // page = page + 1;
      }

      setState(() {

      });
    }
    else{

      showSnackbar(res['message']);
      loading = false;
      setState(() {      });
    }
    log("this is response"+res.toString());

  }









  List<String> text=[
    'Email',
    'In - app',
    'Pop-up',
    'SMS',
    'SMS',
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: appBar(
        context: context,
        title: 'Create New Group',
        titleColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: MyColors.black,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox2,

                // CustomCircularImage(imageUrl: '');
                Row(

                  children: [

                    GestureDetector(
                      onTap:() async{
                        groupIcon = await openImagePicker(context,shouldCrop: true);
                        // prfl = await pickImage(shouldCrop:true);
                        if(groupIcon!=null){
                          profile = Image.file(groupIcon!, height: 80, width: 80, fit: BoxFit.cover,);
                          setState(() {

                          });
                        }
                      },
                      child:    Container(
                        height:80,
                        width:80,
                        // clipBehavior: Clip.hardEdge,
                        margin: EdgeInsets.only(left:10,right:10),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color:MyColors.primaryColor, width: 2, style:BorderStyle.solid)
                        ),
                        child:Container(
                          clipBehavior: Clip.hardEdge,
                          height:76,
                          width:76,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(38)
                          ),
                          // clipBehavior: Clip.hardEdge,
                          child: profile,

                        ),

                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 110,
                      margin: EdgeInsets.all(2),
                      child: CustomTextField(
                        controller: groupname,
                        textColor: Colors.white,
                        hintText: 'Type group name here.....',
                        hintcolor: MyColors.white,
                        bgColor: Colors.white10,
                        borderradius: 15,
                        border: Border.all(color: MyColors.white.withOpacity(0.5)),

                      ),
                    ),
                  ],
                ),
                vSizedBox2,
                if(selected_users.values.toList().length>0)
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: ParagraphText(text: 'Selected users', fontSize: 12,)),
                if(selected_users.values.toList().length>0)
                Container(
                  height: 78,
                  child: Padding(

                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView(

                      scrollDirection: Axis.horizontal,
                    children: getlistofselectedusers(),
                    ),
                  ),
                ),


                vSizedBox2,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomTextField(
                    controller: search,
                    hintText: 'Search',
                    prefixIcon: MyImages.search,
                    suffixheight: 18,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (v){
                      print('onsubmitted');
                      searchParams["keywords"]["value"]=search.text;
                      searchParams['page']['value'] = "1";
                      getUsers();
                      setState(() {});
                    },
                  ),
                ),
                // vSizedBox,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: ParagraphText(text: "All friends"),
                ),
                // Container(
                //   padding: EdgeInsets.only(left: 16.0),
                //   height:MediaQuery.of(context).size.height - ((selected_users.values.toList().length>0)?510:410),
                //   child:
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(left: 16.0, right:16.0),
                      controller: _controller,
                      children: [
                        for (var i = 0; i < results.length; i++)
                          Column(
                            children: [
                              Row(

                                children: [
                                  Row(
                                    children: [
                                      CustomCircularImage(imageUrl:  results[i]['profile'],
                                        height: 50,
                                          width: 50,

                                      ),
                                      hSizedBox,
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ParagraphText(
                                            text: results[i]['first_name'].toString().toCapitalize() + " "+ results[i]['last_name'].toString().toLowerCase(),
                                            fontSize: 15,
                                            fontFamily: 'medium',
                                            color: MyColors.primaryColor,
                                          ),
                                          ParagraphText(
                                            text: "@"+results[i]['username'],
                                            fontSize: 12,
                                            color: Colors.white.withOpacity(0.55),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Theme(
                                    data: Theme.of(context).copyWith(
                                            unselectedWidgetColor: MyColors.primaryColor,
                                            backgroundColor: Colors.white
                                    ),
                                    child: Checkbox(
                                          visualDensity: VisualDensity(horizontal: 0),
                                          checkColor: Colors.white,
                                          // fillColor: MaterialStateProperty.resolveWith(getColor),
                                          value: (selected_users[results[i]['id'].toString()]!=null)?true:false,
                                          activeColor: MyColors.primaryColor,
                                          onChanged: (bool? value) {
                                            // if(value!=null){
                                              if(value==true)
                                                selected_users[results[i]['id'].toString()]=results[i];
                                              else
                                                selected_users.remove(results[i]['id'].toString());

                                              setState(() {

                                              });
                                            // }

                                          },
                                    ),
                                  ),
                                        ],
                                      )
                                  ),
                                ],
                              ),
                              Divider(
                                height: 30,
                                indent: 60,
                                color: Colors.white.withOpacity(0.30),
                              )
                            ],
                          ),


                        if(loading==false)
                          SizedBox(height:60),
                        if(loading==false && results.length==0)
                          Center(child: Padding(
                            padding: const EdgeInsets.only(top:100),
                            child: ParagraphText(text: "No data found", color: Colors.white,),
                          )),

                        if(loading==true && searchParams['page']['value']=="1")
                          SizedBox(height:100),


                        if(loading==true)
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top:10),
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
                // ),
                vSizedBox2,
                // if(isView==false)
                Center(
                  child:
                  RoundEdgedButton(
                    text: (isUpdate)?'Update':'Done',
                    load: groupCreating,
                    textColor: Colors.white,
                    width: MediaQuery.of(context).size.width - 200,
                    color: MyColors.primaryColor,
                    onTap: () async{
                      if(groupIcon==null && isUpdate==false){
                        showSnackbar('Please upload group icon');
                        return;
                      }
                      else if(groupname.text==''){
                        showSnackbar('Please enter group name');
                        return;
                      }
                      else if(selected_users.keys.toList().length<2){
                        showSnackbar('Please select atleast 2 friends');
                        return;

                      }
                      Map param={
                        "title"   :{"value":groupname.text},
                        "members" :{"value":selected_users.keys.toList().join(',')},
                        "description"    :{"value":""},
                      };
                      if(isUpdate==true){
                        param["group_id"] = {"value":widget.group_id};
                      }

                      Map<String,File>? files=null;
                      if(groupIcon!=null){
                        files= {
                          "icon"     :groupIcon!,
                        };
                      }


                      groupCreating = true;

                      setState(() { });

                      Map res = await Webservices.postData(isUpdate==true?'edit-group':'create-group', param,files);
                      groupCreating = false;

                      setState(() { });

                      // loadComment = false;
                      // setState(() {   });
                      if(res["status"].toString()=="1"){
                        if(isUpdate){
                          showSnackbar("Group updated successfully");
                        }
                        else{
                          showSnackbar("Group created successfully");
                        }

                        Navigator.pop(context);
                        // message.text="";
                        // getComments();
                      }




                      if(isUpdate==true)
                        Navigator.pop(context);
                    },

                  ),
                ),
                vSizedBox,
              ],
            ),
          ],
        ),
      ),

    );
  }


  List<Widget> getlistofselectedusers(){
   List<Widget> users =  [];
   List selectedUsers=selected_users.values.toList();
      for(int i=0;i<selectedUsers.length;i++){
        users.add(Container(
          padding: EdgeInsets.only(left:5,right:5),
          // width: 110,
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CustomCircularImage(
                    imageUrl: selectedUsers[i]['profile'],
                    height: 50,
                    width: 50,
                  ),
                  Positioned(
                      right: -2,
                      bottom: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: MyColors.white,
                          ),
                        ),
                      )
                  ),
                  Positioned(
                      right: -5,
                      bottom: 0,
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: MyColors.primaryColor,
                        size: 20,
                      )
                  ),
                ],
              ),
              vSizedBox,
              ParagraphText(
                text: selectedUsers[i]['first_name'].toString().toCapitalize() + " "+ selectedUsers[i]['last_name'].toString().toLowerCase(),
                fontSize: 12,
                // maxline: 1,
                // overflow: TextOverflow.ellipsis,
                fontFamily: 'medium',
              ),
            ],
          ),
        ));
      }


    return users;

  }
}
