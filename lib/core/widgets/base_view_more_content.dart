// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import '../extensions/extensions.dart';
// import '../theme/theme.dart';
//
// class BaseViewMoreContent extends StatefulWidget {
//   const BaseViewMoreContent({
//     super.key,
//     required this.content,
//     this.maxLines = 3,
//     this.isSelected = false,
//     this.headerTextSpan,
//     this.isHtml = false,
//     this.viewMoreTextColor,
//     this.fontSize = 15,
//   });
//
//   final String content;
//   final int maxLines;
//   final bool isSelected;
//   final TextSpan? headerTextSpan;
//   final bool isHtml;
//   final Color? viewMoreTextColor;
//   final double fontSize;
//
//   @override
//   State<BaseViewMoreContent> createState() => _BaseViewMoreContentState();
// }
//
// class _BaseViewMoreContentState extends State<BaseViewMoreContent> {
//   late bool _isSelected;
//   // late TextSpan span;
//
//   @override
//   void initState() {
//     super.initState();
//     _isSelected = widgets.isSelected;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedCrossFade(
//       sizeCurve: Curves.linear,
//       firstChild: _buildFirstWidget(),
//       secondChild: GestureDetector(
//         onTap: () {
//           setState(() {
//             _isSelected = !_isSelected;
//           });
//         },
//         child: widgets.isHtml
//             ? Html(data: widgets.content)
//             : Text.rich(_buildTextSpan()),
//       ),
//       crossFadeState: _isSelected
//           ? CrossFadeState.showSecond
//           : CrossFadeState.showFirst,
//       duration: const Duration(milliseconds: 200),
//     );
//   }
//
//   Widget _buildFirstWidget() {
//     return widgets.isHtml
//         ? Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               widgets.isHtml
//                   ? Html(
//                       data: widgets.content.length <= 150
//                           ? widgets.content
//                           : '${widgets.content.substring(0, 150)}...',
//                       // data: widgets.content,
//                       // style: {
//                       //   '#': Style(
//                       //     maxLines: widgets.maxLines,
//                       //     textOverflow: TextOverflow.ellipsis,
//                       //   ),
//                       // },
//                     )
//                   : Text.rich(
//                       _buildTextSpan(),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: widgets.maxLines,
//                     ),
//               if (widgets.content.length > 150)
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _isSelected = !_isSelected;
//                     });
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.only(top: 4),
//                     child: Text(
//                       context.loc.txtViewMore,
//                       style:
//                           AppTextStyles.customTextStyle(
//                             fontSize: 12,
//                             fontWeightName: FontWeightName.bold,
//                             color:
//                                 widgets.viewMoreTextColor ??
//                                 AppColors.primaryColor,
//                           ).copyWith(
//                             decoration: TextDecoration.underline,
//                             decorationColor:
//                                 widgets.viewMoreTextColor ??
//                                 AppColors.primaryColor,
//                             decorationThickness: 3,
//                           ),
//                     ),
//                   ),
//                 ),
//             ],
//           )
//         : LayoutBuilder(
//             builder: (context, constraints) {
//               // Use a textpainter to determine if it will exceed max lines
//               var tp = TextPainter(
//                 maxLines: widgets.maxLines,
//                 textAlign: TextAlign.left,
//                 textDirection: TextDirection.ltr,
//                 text: _buildTextSpan(),
//               );
//
//               // trigger it to layout
//               tp.layout(maxWidth: constraints.maxWidth);
//
//               // whether the text overflowed or not
//               var exceeded = tp.didExceedMaxLines;
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text.rich(
//                     _buildTextSpan(),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: widgets.maxLines,
//                   ),
//                   if (exceeded)
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _isSelected = !_isSelected;
//                         });
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.only(top: 4),
//                         child: Text(
//                           context.loc.txtViewMore,
//                           style:
//                               AppTextStyles.customTextStyle(
//                                 fontSize: 12,
//                                 fontWeightName: FontWeightName.bold,
//                                 color:
//                                     widgets.viewMoreTextColor ??
//                                     AppColors.primaryColor,
//                               ).copyWith(
//                                 decoration: TextDecoration.underline,
//                                 decorationColor:
//                                     widgets.viewMoreTextColor ??
//                                     AppColors.primaryColor,
//                                 decorationThickness: 3,
//                               ),
//                         ),
//                       ),
//                     ),
//                 ],
//               );
//             },
//           );
//   }
//
//   TextSpan _buildTextSpan() {
//     return TextSpan(
//       // text: widgets.content,
//       // style: AppTextStyles.customTextStyle(
//       //   fontSize: 15,
//       //   fontWeightName: FontWeightName.regular,
//       // ),
//       children: [
//         if (widgets.headerTextSpan != null) widgets.headerTextSpan!,
//         TextSpan(
//           text: widgets.content,
//           style: AppTextStyles.customTextStyle(
//             fontSize: widgets.fontSize,
//             fontWeightName: FontWeightName.regular,
//           ),
//         ),
//       ],
//     );
//   }
// }
