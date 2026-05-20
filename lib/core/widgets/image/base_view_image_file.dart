// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:bank/core/theme/theme.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';

// class BaseViewImageFile extends ConsumerStatefulWidget {
//   const BaseViewImageFile({
//     super.key,
//     required this.filePaths,
//     this.currentIndex = 0,
//   });

//   final List<String> filePaths;
//   final int currentIndex;

//   @override
//   ConsumerState<BaseViewImageFile> createState() => _BaseViewImageFileState();
// }

// class _BaseViewImageFileState extends ConsumerState<BaseViewImageFile> {
//   late int _currentIndex;

//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widgets.currentIndex;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           "${_currentIndex + 1}/${widgets.filePaths.length}",
//           style: AppTextStyles.customTextStyle(
//             fontSize: 16,
//             fontWeightName: FontWeightName.medium,
//             color: AppColors.white,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Hero(
//         tag: widgets.filePaths[_currentIndex] + widgets.currentIndex.toString(),
//         transitionOnUserGestures: true,
//         child: PhotoViewGallery.builder(
//           itemCount: widgets.filePaths.length,
//           builder: (context, index) {
//             return PhotoViewGalleryPageOptions(
//               // imageProvider: CachedNetworkImageProvider(
//               //   widgets.filePaths[index],
//               // ),
//               imageProvider: FileImage(File(widgets.filePaths[index])),
//               minScale: PhotoViewComputedScale.contained * 0.8,
//               maxScale: PhotoViewComputedScale.covered * 2,
//               errorBuilder: (context, error, stackTrace) {
//                 return const Center(child: Icon(Icons.error));
//               },
//             );
//           },
//           pageController: PageController(initialPage: _currentIndex),
//           onPageChanged: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//           scrollPhysics: const BouncingScrollPhysics(),
//         ),
//       ),
//     );
//   }
// }
