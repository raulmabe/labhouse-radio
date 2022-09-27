import 'package:flutter/material.dart';

class HorizontalListWheelScrollView extends StatelessWidget {
  const HorizontalListWheelScrollView({
    super.key,
    required this.childCount,
    required this.builder,
    this.controller,
    this.itemExtent = 180,
  });

  final int childCount;
  final double itemExtent;
  final ScrollController? controller;
  final Widget Function(BuildContext, int) builder;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: itemExtent,
        offAxisFraction: -.5,
        diameterRatio: 3,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: childCount,
          builder: (context, index) => RotatedBox(
            quarterTurns: -1,
            child: builder(context, index),
          ),
        ),
      ),
    );
  }
}
