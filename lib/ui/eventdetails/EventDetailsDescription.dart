import 'package:events/resources/AppTextStyles.dart';
import 'package:events/resources/Dimens.dart';
import 'package:flutter/widgets.dart';

class EventDetailsDescription extends StatelessWidget {
  final String _description;

  const EventDetailsDescription(this._description, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(-1, 0),
      margin: EdgeInsets.symmetric(
        horizontal: AppMargins.horizontal,
        vertical: AppMargins.vertical,
      ),
      child: Text(
        _description,
        style: AppTextStyles.body,
      ),
    );
  }
}
