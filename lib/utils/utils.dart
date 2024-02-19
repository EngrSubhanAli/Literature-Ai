import 'package:flutter/cupertino.dart';

class Utils {
  //
  /// This method is used to get the average rating of the product or what you want;
  /// [rating] is the list of the rating of the product;
  static double averageRating(List<int> rating) {
    var avgRating = 0;
    for (int i = 0; i < rating.length; i++) {
      avgRating = avgRating + rating[i];
    }
    return double.parse((avgRating / rating.length).toStringAsFixed(1));
  }

  //
  /// This method is used to change the focus of the field;
  /// [context] is the context of the screen;
  /// [current] is the current focus node;
  /// [nextFocus] is the next focus node;
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //
  /// Or add more methods here;
  /// ...
}
