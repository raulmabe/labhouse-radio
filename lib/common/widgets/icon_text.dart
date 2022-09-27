import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:labhouse_test/common/common.dart';

class IconText extends StatelessWidget {
  const IconText({super.key, required this.icon, required this.text});
  final Widget icon;
  final Widget text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [icon, text]
          .separateBy(
            const Gap(
              10,
            ),
          )
          .toList(),
    );
  }
}
