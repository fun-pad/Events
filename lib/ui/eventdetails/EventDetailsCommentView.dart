import 'package:events/models/Attendant.dart';
import 'package:events/models/Comment.dart';
import 'package:events/resources/Dimens.dart';
import 'package:flutter/widgets.dart';

import 'EventDetailsItemRow.dart';

class EventDetailsCommentView extends StatelessWidget {
  final Comment _comment;
  final List<User> _attendees;

  const EventDetailsCommentView(this._comment, this._attendees, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String authorId = _comment.authorId;
    User attendant =
        _attendees.firstWhere((attendant) => attendant.id == authorId);

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: AppMargins.vertical,
            left: AppMargins.horizontal,
            right: AppMargins.horizontal,
          ),
          child: EventDetailsItemRow(attendant.imagePath, _comment.text),
        ),
//        NotificationListener<OverscrollIndicatorNotification>(
//          onNotification: (OverscrollIndicatorNotification notification) {
//            notification.disallowGlow();
//          },
//          child: ListView.builder(
//            physics: const NeverScrollableScrollPhysics(),
//            padding: EdgeInsets.only(top: 0),
//            shrinkWrap: true,
//            itemCount: _comment.reply.length,
//            itemBuilder: (context, commentPos) {
//              return _ReplyView(_comment.reply[commentPos], _attendees);
//            },
//          ),
//        ),
//        _ReplyToComment(_comment.id, _currentUser.imagePath),
      ],
    );
  }
}
