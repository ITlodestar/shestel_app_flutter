
import 'package:livestream/widgets/showSnackbar.dart';

Map<String,RegExp> regex =
  {
    "EMAIL":RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
    "PHONE":RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)'),
    "USERNAME":RegExp(r"^[a-zA-Z0-9_.-]{4,20}$"),
  };


// Map messages = {
//   "email":"Please Enter Valid Mail"
// };



int validateMap(data){
  int r = 1;
  try {
    (data as Map<dynamic, dynamic>).forEach((key, value) {
      print('email error---'+value['value']);
      if (value['type'] != "NO") {

        if (regex[value['type']] != null) {

          bool? c = regex[value['type']]?.hasMatch(value['value']);
          if (c == false || c == null) {

            showSnackbar(value['msg']);
            r = 0;
            throw "";
          }
        }
      }
      else {

        if (value['msg'] != "") {
          if(value['value']=="" || value['value']==null) {
            showSnackbar(value['msg']);
            r = 0;
            throw "";
          };


        }
        else {
          r = 1;
        }
      }
    });
  }
  catch(e){
    print('throw ho gaha');
    return r;
  }
   return r;
}



// String? validateEmail(String email) {
//   bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
//   if (emailValid == false || email == null) {
//
//     showSnackbar('');
//     return 'Enter a valid email address';
//   }
//   else
//     return null;
// }