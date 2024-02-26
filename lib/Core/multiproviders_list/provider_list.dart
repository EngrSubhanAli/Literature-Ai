// ignore_for_file: depend_on_referenced_packages

import 'package:mvvm/view/edit_profile/edit_profile_view_model.dart';
import 'package:mvvm/view/forget_password/forget_passwor_view_model.dart';
import 'package:mvvm/view/home_screen/home_screen_view_model.dart';
import 'package:mvvm/view/post_story/post_story_view_model.dart';
import 'package:mvvm/view/profile_section/profile_view_model.dart';
import 'package:mvvm/view/user_side_screens/auth/user_sign_in_screen/sign_in_view_model.dart';
import 'package:mvvm/view/user_side_screens/auth/user_sign_up_screen/sign_up_view_model.dart';

import 'package:mvvm/view_models/admin_side_view_models/sign_in_view_model.dart';
import 'package:mvvm/view_models/user_side_view_models/sign_in_view_model.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

//
/// MultiProvider is a provider that merges multiple providers into one.
///
List<SingleChildWidget> providers = [
  // view models for admin side
  ChangeNotifierProvider(create: (_) => AdminSignInViewModel()),
  ChangeNotifierProvider(create: (_) => AdminSignInViewModel()),
  ChangeNotifierProvider(create: (_) => HomeScreenViewModel()),



  // view models for User side
  ChangeNotifierProvider(create: (_) => SignUpViewModel()),
    ChangeNotifierProvider(create: (_) => EditProfileViewModel()),
    ChangeNotifierProvider(create: (_) => ProfileViewModel()),
    ChangeNotifierProvider(create: (_) => SignUpViewModel()),
   ChangeNotifierProvider(create: (_) => PostStoryViewModel()),
    ChangeNotifierProvider(create: (_) => ForgetPasswordViewModel()),
    ChangeNotifierProvider(create: (_) => LogInViewModel()),
  ChangeNotifierProvider(create: (_) => UserSignInViewModel()),
  ChangeNotifierProvider(create: (_) => UserSignInViewModel()),
];
