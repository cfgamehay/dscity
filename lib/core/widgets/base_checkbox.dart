import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theme/theme.dart';

import '../assets/assets.dart';

class BaseCheckbox extends StatefulWidget {
  const BaseCheckbox({super.key, required this.value, this.onChanged});

  final bool value;
  final Function(bool?)? onChanged;

  @override
  State<BaseCheckbox> createState() => _BaseCheckboxState();
}

class _BaseCheckboxState extends State<BaseCheckbox> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppColors.white,
      splashColor: AppColors.white,
      onTap: () {
        setState(() {
          _value = !_value;
        });
        widget.onChanged?.call(_value);
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        height: 21,
        width: 21,
        child: SvgPicture.asset(
          _value
              ? ImagesResource.svgIcCheckboxCircleActive
              : ImagesResource.svgIcCheckboxCircleInactive,
        ),
      ),
    );
  }
}
