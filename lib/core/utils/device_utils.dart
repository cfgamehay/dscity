// import 'dart:developer';
// import 'dart:io';
//
// import '../constants/constants.dart';
// import 'utils.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:open_file/open_file.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:store_redirect/store_redirect.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// /// Helper class for device related operations.
// class DeviceUtils {
//   DeviceUtils._();
//
//   /// hides the keyboard if its already open
//   static void hideKeyboard(BuildContext context) {
//     FocusManager.instance.primaryFocus?.unfocus();
//   }
//
//   /// accepts a double [scale] and returns scaled sized based on the screen orientation
//   static double getScaledSize(BuildContext context, double scale) =>
//       scale *
//       (MediaQuery.of(context).orientation == Orientation.portrait
//           ? MediaQuery.of(context).size.width
//           : MediaQuery.of(context).size.height);
//
//   /// accepts a double [scale] and returns scaled sized based on the screen width
//   static double getScaledWidth(BuildContext context, double scale) =>
//       scale * MediaQuery.of(context).size.width;
//
//   /// accepts a double [scale] and returns scaled sized based on the screen height
//   static double getScaledHeight(BuildContext context, double scale) =>
//       scale * MediaQuery.of(context).size.height;
//
//   /// set preferred orientation
//   static Future<void> setPreferredOrientations() {
//     return SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }
//
//   ///get device language
//   static String getDeviceLanguage() {
//     return Platform.localeName.contains('_')
//         ? Platform.localeName.split('_')[0]
//         : Platform.localeName;
//   }
//
//   /// Getting device detail
//   ///
//   /// [0] - device Id
//   ///
//   /// [1] - device name
//   ///
//   /// [2] - OS version
//   ///
//   /// [3] - OS name (Android/iOS)
//   static Future<List<String>> getDeviceDetails() async {
//     String identifier = '-1 (Not Android or iOS device)';
//     String deviceName = 'Unknown model (Not Android or iOS device)';
//     String deviceVersion = 'Unknown version (Not Android or iOS device)';
//     String os = 'Unknown';
//     final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//
//     try {
//       if (Platform.isAndroid) {
//         AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
//         identifier = build.id; //UUID for Android
//         deviceName = build.model;
//         deviceVersion = build.version.release;
//         os = 'android';
//       } else if (Platform.isIOS) {
//         var data = await deviceInfoPlugin.iosInfo;
//         identifier = data.identifierForVendor ?? identifier; //UUID for iOS
//         deviceName = data.name;
//         deviceVersion = data.systemVersion;
//         os = 'ios';
//       }
//     } on PlatformException {
//       log('Failed to get platform version');
//     }
//
//     return [identifier, deviceName, deviceVersion, os];
//   }
//
//   ///Get token from firebase messaging
//   static Future<String?> getFcmToken() async {
//     try {
//       // Case platform iOS
//       if (Platform.isIOS) {
//         // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
//         final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
//         if (apnsToken == null) {
//           // APNS token is not available
//           log('APNS token is not available');
//           return null;
//         }
//       }
//       return await FirebaseMessaging.instance.getToken();
//     } catch (e) {
//       log('Failed to get FCM token: ${e.toString()}');
//       return null;
//     }
//   }
//
//   ///Open file
//   static Future<void> openFile({
//     BuildContext? context,
//     required String path,
//   }) async {
//     try {
//       var result = await OpenFile.open(path);
//
//       log('type=${result.type}  message=${result.message}');
//       if (result.type == ResultType.done) {
//         return;
//       }
//       if (context != null && context.mounted) {
//         DialogUtil.showFlushBar(
//           context,
//           result.message,
//           type: EFlushBarType.error,
//         );
//       }
//     } catch (e) {
//       log('Failed to open file: ${e.toString()}');
//     }
//   }
//
//   ///Get Storage Permissions
//   static Future<void> grantStoragePermissions() async {
//     try {
//       // Check if permissions are already granted
//       final bool storageGranted = await Permission.storage.isGranted;
//
//       // If permissions are not granted, request them
//       if (!storageGranted) {
//         final Map<Permission, PermissionStatus> statuses = await [
//           Permission.storage,
//         ].request();
//
//         // If permissions are permanently denied, open app settings
//         if (statuses[Permission.storage] ==
//             PermissionStatus.permanentlyDenied) {
//           // Open app settings to allow users to grant permissions
//           await openAppSettings();
//         }
//       }
//     } catch (e) {
//       // Handle any exceptions that occur during permission handling
//       debugPrint('Error granting permissions: $e');
//     }
//   }
//
//   /// Get Camera Permissions
//   static Future<void> grantCameraPermissions() async {
//     try {
//       // Check if camera permission is already granted
//       final bool cameraGranted = await Permission.camera.isGranted;
//
//       // If not granted, request it
//       if (!cameraGranted) {
//         final Map<Permission, PermissionStatus> statuses = await [
//           Permission.camera,
//         ].request();
//
//         // If permanently denied, redirect to settings
//         if (statuses[Permission.camera] == PermissionStatus.permanentlyDenied) {
//           await openAppSettings();
//         }
//       }
//     } catch (e) {
//       debugPrint('Error granting camera permissions: $e');
//     }
//   }
//
//   /// Get Camera and Microphone Permissions
//   static Future<void> grantCameraMicrophonePermissions() async {
//     try {
//       // Check if permissions are already granted
//       final bool cameraGranted = await Permission.camera.isGranted;
//       final bool micGranted = await Permission.microphone.isGranted;
//
//       if (!cameraGranted || !micGranted) {
//         // Request both permissions simultaneously
//         final Map<Permission, PermissionStatus> statuses = await [
//           Permission.camera,
//           Permission.microphone,
//         ].request();
//
//         // Check if either is permanently denied
//         if (statuses[Permission.camera] == PermissionStatus.permanentlyDenied ||
//             statuses[Permission.microphone] ==
//                 PermissionStatus.permanentlyDenied) {
//           await openAppSettings();
//         }
//       }
//     } catch (e) {
//       debugPrint('Error granting camera/mic permissions: $e');
//     }
//   }
//
//   /// Can Launch URL
//   static Future<void> canLaunchUrl(String url) async {
//     try {
//       await launchUrl(Uri.parse(url));
//     } catch (e) {
//       debugPrint('Error launching URL: $e');
//     }
//   }
//
//   /// Check update version
//   // static Future<void> checkUpdate(BuildContext context, WidgetRef ref) async {
//   //   try {
//   //     // final newVersion = NewVersionPlus();
//   //     // //Advanced check
//   //     // final status = await newVersion.getVersionStatus();
//   //     // if (status != null) {
//   //     //   log('Release Notes: ${status.releaseNotes}');
//   //     //   log('App Store Link: ${status.appStoreLink}');
//   //     //   log('Local Version: ${status.localVersion}');
//   //     //   log('Store Version: ${status.storeVersion}');
//   //     //   log('Can Update: ${status.canUpdate}');
//   //     //   if (status.canUpdate) {
//   //     //     if (context.mounted) {
//   //     //       newVersion.showUpdateDialog(
//   //     //         context: context,
//   //     //         versionStatus: status,
//   //     //         dialogTitle: 'Cập nhật ứng dụng',
//   //     //         dialogText: 'Đã có phiên bản mới, vui lòng cập nhật ứng dụng.',
//   //     //         dismissButtonText: 'Để sau',
//   //     //         updateButtonText: 'Cập nhật',
//   //     //         launchModeVersion: LaunchModeVersion.external,
//   //     //         // allowDismissal: false,
//   //     //       );
//   //     //     }
//   //     //   }
//   //     // }
//   //     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//   //     final localBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;
//   //     String platform = '';
//   //     if (Platform.isAndroid) {
//   //       platform = 'ANDROID';
//   //     } else if (Platform.isIOS) {
//   //       platform = 'IOS';
//   //     }
//   //     final storeBuildNumber = await ref
//   //         .read(authRepositoryProvider)
//   //         .getBuildNumberAppVersion(os: platform, status: '1');
//   //     log('Local Build Number: $localBuildNumber');
//   //     log('Store Build Number: $storeBuildNumber');
//   //     if (storeBuildNumber > localBuildNumber) {
//   //       if (context.mounted) {
//   //         DialogUtil.showAppBottomSheet(
//   //           context,
//   //           enableDrag: false,
//   //           isDismissible: false,
//   //           _buildAppUpdate(context, () async {
//   //             await openStore();
//   //           }),
//   //         );
//   //       }
//   //     }
//   //   } catch (e) {
//   //     log('Check Update Error: $e\n${StackTrace.current}');
//   //   }
//   // }
//
//   // static Widget _buildAppUpdate(BuildContext context, VoidCallback onConfirm) {
//   //   return PopScope(
//   //     canPop: false,
//   //     child: Padding(
//   //       padding: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
//   //       child: Column(
//   //         mainAxisSize: MainAxisSize.min,
//   //         children: [
//   //           Text(
//   //             'Đã có phiên bản mới, vui lòng cập nhật ứng dụng.',
//   //             style: AppTextStyles.customTextStyle(
//   //               fontSize: 18,
//   //               fontWeightName: FontWeightName.bold,
//   //             ),
//   //             textAlign: TextAlign.center,
//   //           ),
//   //           const SizedBox(height: 40),
//   //           Row(
//   //             mainAxisAlignment: MainAxisAlignment.center,
//   //             children: [
//   //               PrimaryButton(
//   //                 height: 45,
//   //                 width: getScaledWidth(context, 0.5),
//   //                 onPressed: () {
//   //                   // Navigator.pop(context);
//   //                   onConfirm();
//   //                 },
//   //                 child: Text('Cập nhật', style: AppTextStyles.buttonWhiteText),
//   //               ),
//   //             ],
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   static Future<void> openStore() async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     StoreRedirect.redirect(
//       androidAppId: packageInfo.packageName,
//       iOSAppId: 'id6752543361',
//     );
//   }
// }
