// import 'dart:developer';
// import 'dart:io';
// import 'dart:ui';
//
// import '../extensions/extensions.dart';
// import '../utils/utils.dart';
// import 'widgets.dart';
// import 'package:crop_image/crop_image.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:uuid/uuid.dart';
//
// class BaseCropImageFile extends StatefulWidget {
//   const BaseCropImageFile({super.key, required this.imageFile});
//
//   final File imageFile;
//
//   @override
//   State<BaseCropImageFile> createState() => _BaseCropImageFileState();
// }
//
// class _BaseCropImageFileState extends State<BaseCropImageFile> {
//   final cropController = CropController(
//     aspectRatio: 1.0,
//     // defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
//   );
//
//   @override
//   void dispose() {
//     cropController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(Icons.close, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: CropImage(
//             controller: cropController,
//             image: Image.file(widgets.imageFile),
//             paddingSize: 16.0,
//             alwaysMove: true,
//             minimumImageSize: 200,
//             maximumImageSize: 500,
//           ),
//         ),
//       ),
//       bottomNavigationBar: _buildButtons(),
//     );
//   }
//
//   Widget _buildButtons() => BottomAppBar(
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         IconButton(
//           icon: const Icon(Icons.restart_alt_rounded),
//           onPressed: () {
//             cropController.rotation = CropRotation.up;
//             cropController.crop = const Rect.fromLTRB(0, 0, 1, 1);
//             cropController.aspectRatio = 1.0;
//           },
//         ),
//         // IconButton(
//         //   icon: const Icon(Icons.aspect_ratio),
//         //   onPressed: _aspectRatios,
//         // ),
//         IconButton(
//           icon: const Icon(Icons.rotate_90_degrees_ccw_outlined),
//           onPressed: _rotateLeft,
//         ),
//         IconButton(
//           icon: const Icon(Icons.rotate_90_degrees_cw_outlined),
//           onPressed: _rotateRight,
//         ),
//         TextButton(
//           onPressed: _finished,
//           child: const Text(
//             'Xong',
//             style: TextStyle(
//               color: Colors.green,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
//
//   // Future<void> _aspectRatios() async {
//   //   final value = await showDialog<double>(
//   //     context: context,
//   //     builder: (context) {
//   //       return SimpleDialog(
//   //         title: const Text('Select aspect ratio'),
//   //         children: [
//   //           // special case: no aspect ratio
//   //           SimpleDialogOption(
//   //             onPressed: () => Navigator.pop(context, -1.0),
//   //             child: const Text('free'),
//   //           ),
//   //           SimpleDialogOption(
//   //             onPressed: () => Navigator.pop(context, 1.0),
//   //             child: const Text('square'),
//   //           ),
//   //           SimpleDialogOption(
//   //             onPressed: () => Navigator.pop(context, 2.0),
//   //             child: const Text('2:1'),
//   //           ),
//   //           SimpleDialogOption(
//   //             onPressed: () => Navigator.pop(context, 1 / 2),
//   //             child: const Text('1:2'),
//   //           ),
//   //           SimpleDialogOption(
//   //             onPressed: () => Navigator.pop(context, 4.0 / 3.0),
//   //             child: const Text('4:3'),
//   //           ),
//   //           SimpleDialogOption(
//   //             onPressed: () => Navigator.pop(context, 16.0 / 9.0),
//   //             child: const Text('16:9'),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   //   if (value != null) {
//   //     controller.aspectRatio = value == -1 ? null : value;
//   //     controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
//   //   }
//   // }
//
//   Future<void> _rotateLeft() async => cropController.rotateLeft();
//
//   Future<void> _rotateRight() async => cropController.rotateRight();
//
//   Future<void> _finished() async {
//     LoadingWidget.show();
//     final file = await _cropImage();
//     LoadingWidget.hide();
//     // Crop image failed
//     if (file == null) {
//       if (mounted) {
//         DialogUtil.showToast(context, context.loc.txtErrorException);
//       }
//       return;
//     }
//
//     // Crop image successfully
//     if (mounted) {
//       // Go back and return the cropped image
//       Navigator.pop(context, file);
//     }
//   }
//
//   Future<File?> _cropImage() async {
//     try {
//       var croppedImage = await cropController.croppedBitmap();
//       final data = await croppedImage.toByteData(format: ImageByteFormat.png);
//
//       if (data == null) {
//         return null;
//       }
//       final bytes = data.buffer.asUint8List();
//
//       Uuid uuid = const Uuid();
//       final tempDir = await getApplicationCacheDirectory();
//       File file = File('${tempDir.path}/${uuid.v4()}.png');
//
//       file = await file.writeAsBytes(bytes, flush: true);
//       return file;
//     } catch (e) {
//       log('Error Crop Image: $e\n${StackTrace.current}');
//       return null;
//     }
//
//     // final image = await cropController.croppedImage();
//     // if (mounted) {
//     //   await showDialog<bool>(
//     //     context: context,
//     //     builder: (context) {
//     //       return SimpleDialog(
//     //         contentPadding: const EdgeInsets.all(6.0),
//     //         titlePadding: const EdgeInsets.all(8.0),
//     //         title: const Text('Cropped image'),
//     //         children: [
//     //           Text('relative: ${controller.crop}'),
//     //           Text('pixels: ${controller.cropSize}'),
//     //           const SizedBox(height: 5),
//     //           image,
//     //           TextButton(
//     //             onPressed: () => Navigator.pop(context, true),
//     //             child: const Text('OK'),
//     //           ),
//     //         ],
//     //       );
//     //     },
//     //   );
//     // }
//   }
// }
