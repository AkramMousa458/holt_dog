import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holt_dog/features/donation/screens/donation_screen.dart';
import 'package:holt_dog/features/donation/screens/add_card_screen.dart';
import 'package:holt_dog/features/reports/screens/my_report_screen.dart';
import '../../features/onboarding/screens/splash_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/auth/screens/verify_otp_screen.dart';
import '../../features/auth/screens/reset_password_screen.dart';
import '../../features/profile/screens/privacy_policy_screen.dart';
import '../../features/home/screens/home_screen.dart';

class AppRouter {
  // Route Names
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String verifyOtp = '/verify-otp';
  static const String resetPassword = '/reset-password';
  static const String privacyPolicy = '/privacy-policy';
  static const String home = '/';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: signup,
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: verifyOtp,
        name: 'verifyOtp',
        builder: (context, state) => const VerifyOTPScreen(),
      ),
      GoRoute(
        path: resetPassword,
        name: 'resetPassword',
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: privacyPolicy,
        name: 'privacyPolicy',
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: DonationScreen.routeName,
        name: 'donation',
        builder: (context, state) => const DonationScreen(),
      ),
      GoRoute(
        path: MyReportScreen.routeName,
        name: 'myReportScreen',
        builder: (context, state) => const MyReportScreen(),
      ),
      GoRoute(
        path: AddCardScreen.routeName,
        name: 'addCardScreen',
        builder: (context, state) => const AddCardScreen(),
      ),
    ],
  );
}
