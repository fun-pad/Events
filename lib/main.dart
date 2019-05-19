import 'package:events/resources/AppColors.dart';
import 'package:events/resources/AppTextStyles.dart';
import 'package:events/ui/events/EventsList.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
