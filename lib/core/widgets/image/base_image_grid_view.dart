// import 'package:flutter/material.dart';
// import '../../theme/theme.dart';
// import '../widgets.dart';
//
// class BaseImageGridView extends StatelessWidget {
//   final List<String> imageUrls;
//
//   const BaseImageGridView({super.key, required this.imageUrls});
//
//   void _pushImageView(BuildContext context, int index) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) =>
//             BaseViewImageNetwork(imageUrls: imageUrls, currentIndex: index),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(color: AppColors.grey200, child: buildImageGrid(context));
//   }
//
//   Widget buildImageGrid(BuildContext context) {
//     int count = imageUrls.length;
//     double imageHeight = 200;
//
//     if (count == 1) {
//       return Hero(
//         tag: '${imageUrls[0]}0',
//         child: GestureDetector(
//           onTap: () => _pushImageView(context, 0),
//           child: BaseCachedNetworkImage(
//             imageUrl: imageUrls[0],
//             imageHeight: imageHeight,
//             imageWidth: double.infinity,
//           ),
//         ),
//       );
//     } else if (count == 2) {
//       return Row(
//         children: List.generate(imageUrls.length, (index) {
//           return Expanded(
//             child: Hero(
//               tag: imageUrls[index] + index.toString(),
//               child: GestureDetector(
//                 onTap: () => _pushImageView(context, index),
//                 child: BaseCachedNetworkImage(
//                   imageUrl: imageUrls[index],
//                   imageHeight: imageHeight,
//                 ),
//               ),
//             ),
//           );
//         }),
//       );
//     } else if (count == 3) {
//       return SizedBox(
//         height: imageHeight,
//         child: Row(
//           children: [
//             Expanded(
//               child: Hero(
//                 tag: '${imageUrls[0]}0',
//                 child: GestureDetector(
//                   onTap: () => _pushImageView(context, 0),
//                   child: BaseCachedNetworkImage(imageUrl: imageUrls[0]),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   final double imageWidth = constraints.maxWidth;
//                   final double imageHeight = constraints.maxHeight / 2;
//                   return Column(
//                     children: [
//                       Hero(
//                         tag: '${imageUrls[1]}1',
//                         child: GestureDetector(
//                           onTap: () => _pushImageView(context, 1),
//                           child: SizedBox(
//                             height: imageHeight,
//                             width: imageWidth,
//                             child: BaseCachedNetworkImage(
//                               imageUrl: imageUrls[1],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Hero(
//                         tag: '${imageUrls[2]}2',
//                         child: GestureDetector(
//                           onTap: () => _pushImageView(context, 2),
//                           child: SizedBox(
//                             height: imageHeight,
//                             width: imageWidth,
//                             child: BaseCachedNetworkImage(
//                               imageUrl: imageUrls[2],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       );
//     } else if (count == 4) {
//       return GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//         ),
//         itemCount: 4,
//         itemBuilder: (context, index) =>
//             BaseCachedNetworkImage(imageUrl: imageUrls[index]),
//       );
//     } else {
//       return GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//         ),
//         itemCount: 4,
//         itemBuilder: (context, index) {
//           if (index == 3) {
//             return Stack(
//               fit: StackFit.expand,
//               children: [
//                 BaseCachedNetworkImage(imageUrl: imageUrls[index]),
//                 Positioned.fill(
//                   child: Container(
//                     color: Colors.black45,
//                     child: Center(
//                       child: Text(
//                         '+${count - 4}',
//                         style: const TextStyle(
//                           fontSize: 32,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }
//           return BaseCachedNetworkImage(imageUrl: imageUrls[index]);
//         },
//       );
//     }
//   }
//
//   // Widget buildImage(String url) {
//   //   return BaseCachedNetworkImage(
//   //     imageUrl: url,
//   //   );
//   // }
// }
