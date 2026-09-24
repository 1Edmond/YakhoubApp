import 'dart:async';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:multishop_tchad/core/helpers/route_helper.dart';
// import 'package:multishop_tchad/core/guest/guest_mode_controller.dart'
//    as multishop_tchad;

import 'core/di/di_container.dart' as di;
import 'core/di/provider_setup.dart' as di_providers;
import 'package:multishop_tchad/core/di/local/cache_response.dart';
import 'core/localization/app_localization.dart';
import 'core/localization/controllers/localization_controller.dart';
// import 'package:multishop_tchad/core/router/app_router.dart';
import 'package:multishop_tchad/core/theme/controllers/theme_controller.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'package:multishop_tchad/features/auth/controllers/auth_controller.dart';
// import 'features/customer/screens/splash_screen.dart';
import 'features/customer/splash/controllers/splash_controller.dart';
import 'features/customer/profile/controllers/profile_contrroller.dart';
import 'package:multishop_tchad/features/shared/push_notification/models/notification_body.dart';
import 'package:multishop_tchad/features/shared/push_notification/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final database = AppDatabase();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    if (Platform.isAndroid) {
      try {
        await Firebase.initializeApp(
          name: 'multishop-tchad',
          options: const FirebaseOptions(
            apiKey: AppConstants.firebaseApiKey,
            projectId: AppConstants.firebaseProjectId,
            messagingSenderId: AppConstants.firebaseMessagingSenderId,
            appId: AppConstants.firebaseAppId,
          ),
        );
      } catch (_) {
        await Firebase.initializeApp();
      }
    } else {
      await Firebase.initializeApp();
    }
  }

  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await di.init();

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  NotificationBody? body;
  String? initialRoute;

  try {
    final RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      body = NotificationHelper.convertNotification(remoteMessage.data);
    }
    await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    initialRoute = await initDynamicLinks();
  } catch (_) {}

  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(
    MultiProvider(
        providers: di_providers.getProviders(),
        child: MyApp(body: body, initialRoute: initialRoute)),
  );
}

StreamSubscription<Uri?>? _sub;

Future<String?> initDynamicLinks() async {
  final appLinks = AppLinks();
  final uri = await appLinks.getInitialLink();
  if (uri != null) {
    return uri.path;
  }

  _sub = appLinks.uriLinkStream.listen((Uri? uri) {
    if (uri != null) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (navigatorKey.currentContext != null) {
          navigatorKey.currentContext!.go(uri.path);
        }
      });
    }
  });

  return null;
}

class MyApp extends StatefulWidget {
  final NotificationBody? body;
  final String? initialRoute;

  const MyApp({super.key, required this.body, this.initialRoute});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
    super.initState();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  void _loadData() async {
    if (widget.initialRoute != null) {
      final AuthController authProvider =
          Provider.of<AuthController>(context, listen: false);

      if (authProvider.isLoggedIn()) {
        await Provider.of<ProfileController>(context, listen: false)
            .getUserInfo(context, isLoggedIn: true);
      }

      if (mounted) {
        await Provider.of<SplashController>(context, listen: false).initConfig(
          context,
          null,
          null,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Locale> locals = [];
    for (final language in AppConstants.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }

    return Consumer2<ThemeController, SplashController>(
      builder: (context, themeController, splashController, _) {
        return MaterialApp.router(
          routerConfig: RouterHelper.goRoutes,
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: themeController.darkTheme
              ? dark(
                  primaryColor: Theme.of(context).primaryColor,
                  secondaryColor: Theme.of(context).colorScheme.secondary,
                )
              : light(
                  primaryColor: Theme.of(context).primaryColor,
                  secondaryColor: Theme.of(context).colorScheme.secondary,
                ),
          locale: Provider.of<LocalizationController>(context).locale,
          localizationsDelegates: const [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.noScaling),
              child: SafeArea(top: false, child: child!),
            );
          },
          supportedLocales: locals,
        );
      },
    );
  }
}

class Get {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigator => navigatorKey.currentState;
}
