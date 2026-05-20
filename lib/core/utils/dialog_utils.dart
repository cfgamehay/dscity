// import 'package:another_flushbar/flushbar.dart';
// import '../constants/constants.dart';
// import '../extensions/extensions.dart';
// import '../theme/theme.dart';
// import 'utils.dart';
// import '../widgets/modal_header.dart';
// import '../widgets/widgets.dart';
// import 'package:flutter/material.dart';
//
// class DialogUtil {
//   DialogUtil._();
//
//   static void showFlushBar(
//     BuildContext context,
//     String message, {
//     Color? backgroundColor,
//     Widget? iconFlushBar,
//     Color? messageColor,
//     Color? leftBarIndicatorColor,
//     FlushbarPosition flushbarPosition = FlushbarPosition.TOP,
//     Duration duration = const Duration(seconds: 5),
//     EFlushBarType type = EFlushBarType.success,
//   }) {
//     Flushbar(
//       backgroundColor: backgroundColor ?? AppColors.black,
//       flushbarStyle: FlushbarStyle.FLOATING,
//       messageColor: messageColor ?? AppColors.white,
//       duration: duration,
//       flushbarPosition: flushbarPosition,
//       icon:
//           iconFlushBar ??
//           (type == EFlushBarType.success
//               ? const Icon(Icons.check_circle_rounded, color: AppColors.green)
//               : const Icon(Icons.warning_rounded, color: AppColors.red)),
//       leftBarIndicatorColor:
//           leftBarIndicatorColor ??
//           (type == EFlushBarType.success ? AppColors.green : AppColors.red),
//       margin: const EdgeInsets.all(6.0),
//       borderRadius: BorderRadius.circular(8),
//       message: message,
//     ).show(context);
//   }
//
//   static void showToast(
//     BuildContext context,
//     String message, {
//     String? actionName,
//     function,
//     SnackBarBehavior? behavior,
//     Duration duration = const Duration(seconds: 5),
//   }) {
//     ScaffoldMessenger.of(context).removeCurrentSnackBar();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         behavior: behavior ?? SnackBarBehavior.floating,
//         duration: duration,
//         content: Text(message, maxLines: 2, overflow: TextOverflow.ellipsis),
//         action: actionName == null
//             ? null
//             : SnackBarAction(label: actionName, onPressed: function ?? () {}),
//       ),
//     );
//   }
//
//   static Future<T?> showAppBottomSheet<T>(
//     BuildContext context,
//     Widget widgets, {
//     bool isDismissible = true,
//     bool enableDrag = true,
//   }) {
//     return showModalBottomSheet<T>(
//       useSafeArea: true,
//       clipBehavior: Clip.antiAlias,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       context: context,
//       isDismissible: isDismissible,
//       enableDrag: enableDrag,
//       isScrollControlled: true,
//       builder: (context) {
//         return Wrap(
//           children: [
//             ModalHeader(
//               onClose: enableDrag ? () => Navigator.pop(context) : null,
//               isEnableIconClose: isDismissible && enableDrag,
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                 bottom: MediaQuery.viewInsetsOf(context).bottom,
//               ),
//               child: widgets,
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   static Future<T?> showAppBottomSheets<T>(
//     BuildContext context,
//     Widget widgets, {
//     bool isDismissible = true,
//     bool enableDrag = true,
//   }) {
//     return showModalBottomSheet<T>(
//       clipBehavior: Clip.antiAlias,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       context: context,
//       isDismissible: isDismissible,
//       enableDrag: enableDrag,
//       isScrollControlled: true,
//       builder: (context) {
//         return Wrap(
//           children: [
//             ModalHeader(
//               onClose: enableDrag ? () => Navigator.pop(context) : null,
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                 bottom: MediaQuery.viewInsetsOf(context).bottom,
//               ),
//               child: widgets,
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   static Future<T?> showDialogAlert<T>(
//     BuildContext context, {
//     String? title,
//     dynamic content,
//     String? submitText,
//     Color? submitTextColor,
//     Function? onSubmit,
//   }) {
//     return showDialog<T>(
//       context: context,
//       barrierDismissible: false, // user must tap button
//       builder: (BuildContext context) {
//         return PopScope(
//           canPop: false,
//           child: AlertDialog(
//             title: title == null
//                 ? null
//                 : Text(
//                     title,
//                     style: AppTextStyles.customTextStyle(
//                       fontSize: 13,
//                       fontWeightName: FontWeightName.semiBold,
//                     ),
//                     textAlign: TextAlign.start,
//                   ),
//             // elevation: 8,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(4),
//             ),
//             content: (content != null && content is String)
//                 ? Text(
//                     content,
//                     style: AppTextStyles.customTextStyle(
//                       fontSize: 12,
//                       fontWeightName: FontWeightName.regular,
//                       color: AppColors.grey700,
//                     ),
//                     textAlign: TextAlign.start,
//                   )
//                 : content,
//             actionsPadding: const EdgeInsets.only(
//               left: 16,
//               right: 16,
//               bottom: 16,
//             ),
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   PrimaryButton(
//                     height: 30,
//                     borderRadius: BorderRadius.circular(4),
//                     onPressed: () {
//                       Navigator.pop(context);
//                       if (onSubmit != null) {
//                         onSubmit();
//                       }
//                     },
//                     child: Text(
//                       submitText ?? context.loc.btnConfirm,
//                       style: AppTextStyles.customTextStyle(
//                         fontSize: 12,
//                         fontWeightName: FontWeightName.bold,
//                         color: AppColors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   /// Function to show options to either pick image or take from camera.
//   /// Return [ImageSourceType] to pass to the [ImagePicker] constructor
//   static Future<dynamic> showImageSelectionSheet(
//     BuildContext context, {
//     String? title,
//   }) {
//     return showAppBottomSheet(
//       context,
//       SafeArea(
//         child: Column(
//           children: [
//             if (title != null && title.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.only(top: 12, bottom: 6),
//                 child: Text(
//                   title,
//                   style: const TextStyle(fontSize: 15, color: Colors.black54),
//                 ),
//               ),
//             ListTile(
//               leading: const Icon(Icons.image, color: Colors.blue),
//               horizontalTitleGap: 8,
//               title: const Text('Chọn ảnh từ thư viện'),
//               onTap: () async {
//                 Navigator.pop(context, EImageSourceType.multiImage);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.camera, color: Colors.blue),
//               horizontalTitleGap: 8,
//               title: const Text('Chụp ảnh'),
//               onTap: () async {
//                 //Check Permission
//                 await DeviceUtils.grantCameraPermissions();
//                 if (context.mounted) {
//                   Navigator.pop(context, EImageSourceType.camera);
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
