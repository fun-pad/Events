import 'package:flutter/painting.dart';

import 'AppColors.dart';
import 'Dimens.dart';

class AppTextStyles {
  static TextStyle body = TextStyle(
    color: AppColors.textSecondary,
    fontSize: TextSizes.body,
  );

  static TextStyle bodyHeavy = TextStyle(
    color: AppColors.textPrimary,
    fontSize: TextSizes.body,
    fontWeight: FontWeight.bold,
  );

  static TextStyle bodyLight = TextStyle(
    color: AppColors.textLight,
    fontSize: TextSizes.body,
  );

  static TextStyle title = TextStyle(
    color: AppColors.textPrimary,
    fontSize: TextSizes.title,
    fontWeight: FontWeight.bold,
  );
}
