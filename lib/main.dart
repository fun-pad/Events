import 'package:appcenter/appcenter.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';
import 'package:events/resources/AppColors.dart';
import 'package:events/resources/AppTextStyles.dart';
import 'package:events/ui/events/EventsList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _appSecret;

  _MyAppState() {
    final ios = defaultTargetPlatform == TargetPlatform.iOS;
    _appSecret = ios
        ? "dc3aee2c-5d61-4850-914a-4fc16e743e0"
        : "997e3c51-dda5-4cb9-b4ce-2d07a003749a";
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    await AppCenter.start(_appSecret, [AppCenterCrashes.id]);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textSecondary,
        );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: textTheme,
        primaryColor: AppColors.bgPrimary,
        accentColor: AppColors.accent,
        backgroundColor: AppColors.bgPrimary,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: AppTextStyles.bodyLight,
          fillColor: AppColors.textPrimary,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.textPrimary),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.textPrimary),
          ),
        ),
      ),
      home: EventsList(),
    );
  }
}
