import 'package:livestream/services/webservices.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'navigation_functions.dart';

String? onesignal_device_id;
Future<void> initOneSignal(app_id) async {
  //this should be called in first screen init state (example: splash screen)
  OneSignal.initialize(app_id);

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  // OneSignal.Notifications().then((accepted) {
  //   print("Accepted permission: $accepted");
  // });
}

setNotificationHandler(context) async {
  //this should be called in after logged in first screen init state (example: tab)

  // OneSignal.shared.setNotificationWillShowInForegroundHandler(
  //     (OSNotificationReceivedEvent event) {
  //   // Will be called whenever a notification is received in foreground
  //   // Display Notification, pass null param for not displaying the notification
  //   event.complete(event.notification);
  // });

  // OneSignal.shared
  //     .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  //   print('the notificationnnn is ');
  //   print('the notificationnnn is ${result.notification.toString()}');
  //   notificationHandling(context, result.notification.additionalData);
  //   print("notificationopen--------------------------------" +
  //       result.notification.additionalData.toString());
  //   // Will be called whenever a notification is opened/button pressed.
  // });

  // OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
  //   // Will be called whenever the permission changes
  //   // (ie. user taps Allow on the permission prompt in iOS)
  // });
  // onesignal_device_id = await get_device_id();
  // Webservices.postData(
  //     'edit-profile',
  //     {
  //       "device_id": {"value": onesignal_device_id}
  //     },
  //     null);
  // print("device id--------------------------------" +
  //     onesignal_device_id.toString());
  // OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) async{
  //   print("subscription--------------------------------");
  //
  //
  //
  //   // Webservices.getData(url, data)
  //   // Will be called whenever the subscription changes
  //   // (ie. user gets registered with OneSignal and gets a user ID)
  // });
}

// Future<String?> get_device_id() async {
//   var deviceState = await OneSignal.shared.getDeviceState();
//   if (deviceState == null || deviceState.userId == null) return null;
//   return deviceState.userId!;
// }
