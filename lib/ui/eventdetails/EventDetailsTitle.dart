import 'package:events/resources/AppTextStyles.dart';
import 'package:events/resources/Dimens.dart';
import 'package:flutter/material.dart';

class EventDetailsTitle extends StatelessWidget {
  final String _title;

  EventDetailsTitle(this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(-1, 0),
      margin: EdgeInsets.only(
        left: AppMargins.horizontal,
        top: AppMargins.vertical,
      ),
      child: Text(
        _title,
        style: AppTextStyles.title,
      ),
    );
  }
}
