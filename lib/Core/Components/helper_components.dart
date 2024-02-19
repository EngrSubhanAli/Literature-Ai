import 'package:flutter/material.dart';

// horizontal space
class HorizontalSizedBox extends StatelessWidget {
  final double? horizontalSpace;

  const HorizontalSizedBox({
    super.key,
    required this.horizontalSpace,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: horizontalSpace,
    );
  }
}

//vertical space
class VerticalSizedBox extends StatelessWidget {
  final double? vertical;

  const VerticalSizedBox({
    super.key,
    required this.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: vertical,
    );
  }
}
