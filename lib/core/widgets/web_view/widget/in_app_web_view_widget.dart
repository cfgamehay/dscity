// import 'dart:developer';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class InAppWebViewWidget extends StatefulWidget {
//   final String uRLRequest;
//   final Function(int) onProgress;
//   const InAppWebViewWidget({
//     super.key,
//     required this.uRLRequest,
//     required this.onProgress,
//   });
//
//   @override
//   State<InAppWebViewWidget> createState() => _InAppWebViewWidgetState();
// }
//
// class _InAppWebViewWidgetState extends State<InAppWebViewWidget> {
//   final GlobalKey webViewKey = GlobalKey();
//   InAppWebViewController? webViewController;
//
//   InAppWebViewSettings settings = InAppWebViewSettings(
//     isInspectable: kDebugMode,
//     mediaPlaybackRequiresUserGesture: false,
//     allowsInlineMediaPlayback: true,
//     iframeAllowFullscreen: true,
//   );
//
//   late ContextMenu contextMenu;
//   String url = '';
//   double progress = 0;
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InAppWebView(
//       key: webViewKey,
//       initialUrlRequest: URLRequest(url: WebUri(widgets.uRLRequest)),
//       // initialUserScripts: UnmodifiableListView<UserScript>([]),"
//       initialSettings: settings,
//       onWebViewCreated: (controller) {
//         webViewController = controller;
//       },
//       onLoadStart: (controller, url) {
//         setState(() {
//           this.url = url.toString();
//         });
//       },
//       onPermissionRequest: (controller, request) async {
//         return PermissionResponse(
//           resources: request.resources,
//           action: PermissionResponseAction.GRANT,
//         );
//       },
//       shouldOverrideUrlLoading: (controller, navigationAction) async {
//         var uri = navigationAction.request.url;
//
//         if (!['http', 'https', 'file', 'chrome', 'data', 'javascript', 'about']
//             .contains(uri?.scheme)) {
//           if (await canLaunchUrl(uri!)) {
//             // Launch the App
//             await launchUrl(
//               uri,
//             );
//             // and cancel the request
//             return NavigationActionPolicy.CANCEL;
//           }
//         }
//         return NavigationActionPolicy.ALLOW;
//       },
//       onLoadStop: (controller, url) async {
//         setState(() {
//           this.url = url.toString();
//         });
//       },
//       onProgressChanged: (controller, progress) {
//         widgets.onProgress.call(progress);
//       },
//       onUpdateVisitedHistory: (controller, url, androidIsReload) {
//         setState(() {
//           this.url = url.toString();
//         });
//       },
//       onConsoleMessage: (controller, consoleMessage) {
//         log(consoleMessage.toString());
//       },
//     );
//   }
// }
