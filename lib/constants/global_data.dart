import 'image_urls.dart';
enum MediaType{
  movie, tv,sport
}
MediaType visibilityFromString(String value) {
  return MediaType.values.firstWhere(
          (e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}

// String visibilityFromEnumType<T>(T value){
//   return value.toString().split('.')[1];
// }

Map? user_data = null;
String token = "";
String user_id = "";
List homePageData=[];
List explorePageData=[];

List mediaCategories=[];

List sportsExplorePage = [];
List moviesExplorePage = [];
List tvExplorePage = [];
String country_id = "1";
String country_code = "us";
String currency_symbol = "\$";
bool changed_country = false;

Map? myLiked;
List mySportsWatchlist = [];
List myMoviesWatchlist = [];
List myTvWatchList = [];


List myLikedSports = [];
List myLikedMovies = [];
List myLikedTv = [];
List startProvider=[

];
List allProviderList=[

];
List freeProviderList=[

];
List subscriptionProviderList=[

];
List purchaseList=[

];
List countries=[];


List contentList=[

];

List genreList=[

];

int NotiCount =0;
int unreadChatCount =0;
int unreadGroupChatCount =0;
int singleChatCount =0;
// import 'package:shared_preferences/shared_preferences.dart';

// enum CustomThemes { light, dark, colorblind }

//
//
// // List prompts = [];
// List genders = [
//   'Male',
//   'Female',
//   'Other'
// ];
// List vaccinationStatus = [
//   {
//     'id': '1',
//     'title': 'Fully Vacinated',
//   },
//   {
//     'id': '2',
//     'title': 'Partially Vacinated',
//   },
//   {
//     'id': '3',
//     'title': 'Unvaccinated',
//   },
// ];
// late SharedPreferences sharedPreferences;
// CustomThemes? selectedTheme = CustomThemes.light;