// import '../../theme/theme.dart';
// import '../widgets.dart';
// import 'package:flutter/material.dart';
//
// import 'widgets/in_app_web_view_widget.dart';
//
// class WebViewPage extends StatefulWidget {
//   final String url;
//   const WebViewPage({super.key, required this.url});
//
//   @override
//   State<StatefulWidget> createState() => _WebViewPageState();
// }
//
// class _WebViewPageState extends State<WebViewPage> {
//   double progressValue = 0;
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: BaseAppBar(
//         context: context,
//         // title: titleAvailable ? widgets.title! : '',
//       ),
//       body: Stack(
//         children: [
//           InAppWebViewWidget(
//             uRLRequest: widgets.url,
//             onProgress: (progress) {
//               setState(() {
//                 progressValue = progress.toDouble();
//               });
//             },
//           ),
//           if (progressValue < 100)
//             Positioned(
//               child: LinearProgressIndicator(
//                 value: progressValue / 100,
//                 color: Theme.of(context).primaryColor,
//                 backgroundColor: Colors.red[40],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
