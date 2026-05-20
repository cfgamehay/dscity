// import 'widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
//
// class BasePDFViewerCachedFromUrl extends StatelessWidget {
//   const BasePDFViewerCachedFromUrl({super.key, required this.url});
//
//   final String url;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: BaseAppBar(context: context, title: 'Xem file đính kèm'),
//       body: const PDF().cachedFromUrl(
//         url,
//         placeholder: (double progress) =>
//             Center(child: CircularProgressIndicator(value: progress)),
//         errorWidget: (dynamic error) {
//           debugPrint(error.toString());
//           return const Center(child: EmptyWidget());
//         },
//       ),
//     );
//   }
// }
