import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/SplashScreen/splash_screen.dart';
import 'package:mvvm/view/analyze_screen/analyze_screen.dart';
import 'package:mvvm/view/bottom_navigation/bottom_navigation_bar.dart';
import 'package:mvvm/view/forget_password/forget_password.dart';
import 'package:mvvm/view/forget_password/forget_success.dart';
import 'package:mvvm/view/generate_story/generate_story_screen.dart';
import 'package:mvvm/view/my_stories/my_stories.dart';
import 'package:mvvm/view/on_boarding_screens/onboarding_screens.dart';
import 'package:mvvm/view/post_story/post_story_screen.dart';
import 'package:mvvm/view/profile_section/profile_screen.dart';
import 'package:mvvm/view/recommend_screen/recommend_screen.dart';
import 'package:mvvm/view/top_rated_screen/top_rated_screen.dart';
import 'package:mvvm/view/user_side_screens/auth/user_sign_in_screen/sign_in_screen.dart';

import 'package:mvvm/view/user_side_screens/auth/user_sign_up_screen/sign_up_screen.dart';
import 'package:mvvm/view/user_side_screens/user_home_screen/home_screen.dart';

class Routes {
  //Used For GetX Route
  static appRoutes() => [
        GetPage(
          name: RoutesName.splash,
          page: () => const SplashScreen(),
          // transitionDuration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RoutesName.analyze,
          page: () => const AnalyzeScreen(),
          // transitionDuration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RoutesName.bottombarscreen,
          page: () => AppMainScreen(),
          // transitionDuration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RoutesName.profile,
          page: () => AppMainScreen(),
          // transitionDuration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RoutesName.poststory,
          page: () => const PostStoryScreen(),
          // transitionDuration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RoutesName.generatestory,
          page: () => const GenerateStoryScreen(),
          // transitionDuration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RoutesName.onboarding,
          page: () => const OnboardingScreens(),
          // transitionDuration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RoutesName.signIn,
          page: () => const SignInScreen(),
          // transitionDuration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RoutesName.forgetsuccess,
          page: () => const ForgetSuccess(),
          // transitionDuration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RoutesName.forgetpass,
          page: () => const ForgetPassword(),
          // transitionDuration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RoutesName.recomend,
          page: () => const RecommendScreen(),
          // transitionDuration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RoutesName.signUp,
          page: () => const SignUpScreen(),
          // transitionDuration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RoutesName.mystories,
          page: () => const MyStoriesScreen(),
          // transitionDuration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RoutesName.mystories,
          page: () => const TopRatedStories(),
          // transitionDuration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RoutesName.signIn,
          page: () => const UserHomeScreen(),
          // transitionDuration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RoutesName.home,
          page: () => const UserHomeScreen(),
          // transitionDuration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn,
        ),
      ];

  //Used For Material Page Route
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.mystories:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MyStoriesScreen());
      case RoutesName.topstory:
        return MaterialPageRoute(
            builder: (BuildContext context) => const TopRatedStories());
      case RoutesName.generatestory:
        return MaterialPageRoute(
            builder: (BuildContext context) => const GenerateStoryScreen());
      case RoutesName.profile:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProfileScreen());
      case RoutesName.recomend:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RecommendScreen());
      case RoutesName.analyze:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AnalyzeScreen());
      case RoutesName.poststory:
        return MaterialPageRoute(
            builder: (BuildContext context) => const PostStoryScreen());
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case RoutesName.forgetpass:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgetPassword());
      case RoutesName.bottombarscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => AppMainScreen());
      case RoutesName.forgetsuccess:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgetSuccess());
      case RoutesName.onboarding:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OnboardingScreens());
      case RoutesName.signIn:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignInScreen());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const UserHomeScreen());

      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
