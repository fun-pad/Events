import 'package:events/models/Attendant.dart';
import 'package:events/models/Comment.dart';
import 'package:events/resources/Dimens.dart';
import 'package:flutter/widgets.dart';

import 'EventDetailsItemRow.dart';

class EventDetailsCommentView extends StatelessWidget {
  final Comment _comment;
  final List<User> _attendees;
  final User _loggedInUser;

  const EventDetailsCommentView(
      this._comment, this._attendees, this._loggedInUser,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String authorId = _comment.authorId;
    User attendant = _attendees
        .firstWhere((attendant) => attendant.id == authorId, orElse: () {
      if (_loggedInUser.id == authorId) {
        return _loggedInUser;
      } else {
        return null;
      }
    });

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: AppMargins.vertical,
            left: AppMargins.horizontal,
            right: AppMargins.horizontal,
          ),
          child: EventDetailsItemRow(attendant?.imagePath, _comment.text),
        ),
      ],
    );
  }
}
