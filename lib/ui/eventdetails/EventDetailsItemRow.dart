import 'package:events/resources/AppTextStyles.dart';
import 'package:events/resources/Dimens.dart';
import 'package:events/ui/common/Avatar.dart';
import 'package:flutter/widgets.dart';

class EventDetailsItemRow extends StatelessWidget {
  final String _imagePath;
  final String _text;

  const EventDetailsItemRow(this._imagePath, this._text, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Avatar(_imagePath),
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              left: AppMargins.horizontal,
            ),
            child: Text(
              _text,
              style: AppTextStyles.body,
            ),
          ),
        ),
      ],
    );
  }
}
