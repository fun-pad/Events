import 'package:events/resources/Dimens.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String _imagePath;

  const Avatar(this._imagePath, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSizes.avatarRadius,
      child: Image.asset(
        _imagePath,
        fit: BoxFit.fill,
      ),
    );
  }
}
