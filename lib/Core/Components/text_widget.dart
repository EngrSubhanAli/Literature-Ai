import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final double? width;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final Alignment customAlignment; // New property for custom alignment

  const CustomText({
    Key? key,
    required this.text,
    this.width,
    this.maxLines,
    required this.fontSize,
    required this.color,
    required this.fontWeight,
    this.textAlign,
    this.customAlignment =
        Alignment.center, // Initialize customAlignment property
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Align(
        alignment: customAlignment, // Use customAlignment for alignment
        child: Text(
          text,
          textAlign: textAlign,
          overflow: TextOverflow
              .ellipsis, // or TextOverflow.clip for clipping without ellipsis
          maxLines: maxLines,
          style: TextStyle(
            fontSize: fontSize,
            letterSpacing: -0.6,
            color: color,
            fontFamily: "NunitoSans",
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}

// class CustomText extends StatelessWidget {
//   final String text;
//   final double fontSize;
//   final Color color;
//   final double? width;
//   final FontWeight fontWeight;
//   final TextAlign? textAlign;
//   final int? maxLines;

//   const CustomText({
//     Key? key,
//     required this.text,
//     this.width,
//     this.maxLines,
//     required this.fontSize,
//     required this.color,
//     required this.fontWeight,
//     this.textAlign,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       child: Align(
//         alignment: customAlignment,
//         child: Text(
//           text,
//           textAlign: textAlign,
//           overflow: TextOverflow
//               .ellipsis, // or TextOverflow.clip for clipping without ellipsis
//           maxLines: maxLines,
//           style: TextStyle(
//             fontSize: fontSize,
//             letterSpacing: -0.6,
//             color: color,
//             fontFamily: "NunitoSans",
//             fontWeight: fontWeight,
//           ),
//         ),
//       ),
//     );
//   }
// }
