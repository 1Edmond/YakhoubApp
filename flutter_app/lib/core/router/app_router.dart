import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/screens/auth_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/screens/forget_password_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/screens/login_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/screens/otp_login_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/screens/reset_password_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/splash/screens/splash_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/onboarding/screens/onboarding_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/maintenance/maintenance_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/home/screens/home_screens.dart';

import 'package:flutter_sixvalley_ecommerce/features/vendor/auth/screens/registration_screen.dart' as vendor_registration;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auth/screens/login_screen.dart' as vendor_login;
import 'package:flutter_sixvalley_ecommerce/features/vendor/pending_approval/pending_approval_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  redirect: (context, state) {
    final auth = context.read<AuthController>();
    final location = state.matchedLocation;
    final isLoggedIn = auth.isLoggedIn();
    final publicPaths = ['/splash', '/onboarding', '/login', '/register', '/forgot-password', '/reset-password', '/otp-login', '/vendor/login', '/vendor/register', '/maintenance'];
    if (!isLoggedIn && !publicPaths.any((p) => location.startsWith(p))) {
      return '/login';
    }
    return null;
  },
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/onboarding', builder: (context, state) => OnBoardingScreen()),
    GoRoute(path: '/maintenance', builder: (context, state) => const MaintenanceScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen(fromLogout: false)),
    GoRoute(path: '/register', builder: (context, state) => const AuthScreen()),
    GoRoute(path: '/forgot-password', builder: (context, state) => const ForgetPasswordScreen()),
    GoRoute(path: '/reset-password', builder: (context, state) => const ResetPasswordScreen(mobileNumber: '', otp: '')),
    GoRoute(path: '/otp-login', builder: (context, state) => const OtpLoginScreen()),
    GoRoute(path: '/vendor/login', builder: (context, state) => const vendor_login.LoginScreen()),
    GoRoute(path: '/vendor/register', builder: (context, state) => const vendor_registration.RegistrationScreen()),
    GoRoute(path: '/vendor/pending-approval', builder: (context, state) => const PendingApprovalScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    GoRoute(path: '/vendor/dashboard', builder: (context, state) => const Scaffold(body: Center(child: Text('Vendor Dashboard')))),
  ],
);
