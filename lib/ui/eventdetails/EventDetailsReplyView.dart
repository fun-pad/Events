import 'package:events/models/Attendant.dart';
import 'package:events/models/Reply.dart';
import 'package:events/resources/Dimens.dart';
import 'package:flutter/widgets.dart';

import 'EventDetailsItemRow.dart';

class EventDetailsReplyView extends StatelessWidget {
  final Reply _reply;
  final List<User> _attendees;

  const EventDetailsReplyView(this._reply, this._attendees, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    User attendant = _attendees.firstWhere((attendant) {
      return attendant.id == _reply.authorId;
    });

    return Container(
      margin: EdgeInsets.only(
        top: AppMargins.vertical,
        left: (AppMargins.horizontal + AppSizes.avatarRadius) * 2,
        right: AppMargins.horizontal,
      ),
      child: EventDetailsItemRow(attendant.imagePath, _reply.text),
    );
  }
}
