//
///
// To use localization thorugh the get package, you need to add the following

import 'package:get/get.dart';

import '../languages/hebrew.dart';

// This class is used to get the current locale of the app
class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'he_IL': Hebrew.map,
      };
}
