// import 'core/constants/constants.dart';
// import 'core/extensions/extensions.dart';
// import 'core/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'core/theme/theme.dart';
// import 'core/widgets/widgets.dart';
// import 'package:url_launcher/url_launcher.dart';

// class BaseExpansionTile extends StatefulWidget {
//   const BaseExpansionTile({
//     super.key,
//     required this.title,
//     required this.content,
//     this.iconCollapse,
//     this.iconExpand,
//     this.titleColorCollapse,
//     this.titleColorExpand,
//     this.contentColorCollapse,
//     this.iconNew,
//     this.contentColorExpand,
//     this.hasIconNew = false,
//     this.isRead = false,
//     this.onExpand,
//     this.imageUrls,
//     this.href,
//   });

//   final String title;
//   final String content;
//   final Widget? iconCollapse;
//   final Widget? iconExpand;
//   final Color? titleColorCollapse;
//   final Color? titleColorExpand;
//   final Color? contentColorCollapse;
//   final Color? contentColorExpand;
//   final Widget? iconNew;
//   final bool hasIconNew;
//   final bool isRead;
//   final VoidCallback? onExpand;
//   final List<String>? imageUrls;
//   final String? href;

//   @override
//   State<BaseExpansionTile> createState() => _BaseExpansionTileState();
// }

// class _BaseExpansionTileState extends State<BaseExpansionTile> {
//   late bool _isExpanded = false;
//   late bool _isRead;

//   @override
//   void initState() {
//     super.initState();
//     _isRead = widgets.isRead;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [_buildTitle(), _buildContent()]);
//   }

//   Widget _buildTitle() {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _isExpanded = !_isExpanded;
//           if (widgets.hasIconNew) {
//             _isRead = true;
//           }
//         });
//         widgets.onExpand?.call();
//       },
//       child: Container(
//         color: _isExpanded
//             ? (widgets.titleColorExpand ?? AppColors.primaryColor100)
//             : (widgets.titleColorCollapse ?? AppColors.backgroundColor),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 widgets.title,
//                 style: AppTextStyles.customTextStyle(
//                   fontSize: 16,
//                   fontWeightName: FontWeightName.semiBold,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             if (widgets.hasIconNew && !_isRead)
//               widgets.iconNew ?? const SizedBox.shrink(),
//             _isExpanded
//                 ? (widgets.iconCollapse ??
//                       const Icon(
//                         Icons.keyboard_arrow_up,
//                         color: AppColors.black,
//                         size: 20,
//                       ))
//                 : (widgets.iconExpand ??
//                       const Icon(
//                         Icons.keyboard_arrow_down,
//                         color: AppColors.grey700,
//                         size: 20,
//                       )),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildContent() {
//     return AnimatedCrossFade(
//       sizeCurve: Curves.linear,
//       firstChild: const SizedBox.shrink(),
//       secondChild: _buildSecondChild(),
//       crossFadeState: _isExpanded
//           ? CrossFadeState.showSecond
//           : CrossFadeState.showFirst,
//       duration: const Duration(milliseconds: 200),
//     );
//   }

//   Widget _buildSecondChild() {
//     return GestureDetector(
//       onTap: () async {
//         try {
//           if (widgets.href?.isEmpty ?? true) return;
//           await launchUrl(Uri.parse(widgets.href!));
//         } catch (e) {
//           if (mounted) {
//             DialogUtil.showFlushBar(
//               context,
//               context.loc.titleInvalidProductLink,
//               type: EFlushBarType.error,
//             );
//           }
//         }
//       },
//       child: Container(
//         color: _isExpanded
//             ? (widgets.contentColorExpand ?? AppColors.backgroundColor)
//             : (widgets.contentColorCollapse ?? AppColors.backgroundColor),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         child: Column(
//           children: [
//             _buildImageList(),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(widgets.content, style: AppTextStyles.regular),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImageList() {
//     if (widgets.imageUrls == null || widgets.imageUrls!.isEmpty) {
//       return const SizedBox.shrink();
//     }
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: ListView.separated(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: widgets.imageUrls!.length,
//         separatorBuilder: (context, index) => const Divider(),
//         itemBuilder: (context, index) =>
//             BaseCachedNetworkImage(imageUrl: widgets.imageUrls![index]),
//       ),
//     );
//   }
// }
