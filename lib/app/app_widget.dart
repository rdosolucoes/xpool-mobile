import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../shared/auth/stores/auth_store.dart';
import '../shared/helpers/custom_colors.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: omit_local_variable_types
    AuthStore authStore = Modular.get();
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId("e51890bd-fbf3-485c-9dfb-5c8e38b833f4");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });

    OneSignal.shared.getDeviceState().then((value) {
      if (value != null) {
        var playerId = value.userId;
        debugPrint('PlayerID: $playerId');
        authStore.setPlayerId(value.userId);
      }
    });

    Modular.setInitialRoute('/splash');

    return MaterialApp.router(
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
        supportedLocales: [const Locale('pt', 'BR')],
        debugShowCheckedModeBanner: false,
        title: 'Flutter Slidy',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
            primarySwatch: CustomColors.blueBar,
            canvasColor: Colors.grey[10],
            primaryIconTheme: IconThemeData(color: Colors.white),
            primaryTextTheme: TextTheme(
                headline6: TextStyle(color: Colors.white, fontSize: 18)),
            appBarTheme: AppBarTheme(
                color: CustomColors.primary,
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 16))),
        builder: (context, child) => ResponsiveWrapper.builder(
              child = asuka.builder(context, child),
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.resize(300, name: MOBILE),
                ResponsiveBreakpoint.autoScale(1280, name: TABLET),
                //ResponsiveBreakpoint.resize(1280, name: DESKTOP),
                //ResponsiveBreakpoint.autoScale(2460, name: '4K'),
              ],
            ));
  }
}
