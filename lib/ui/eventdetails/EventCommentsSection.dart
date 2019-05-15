import 'package:events/models/Attendant.dart';
import 'package:events/models/Comment.dart';
import 'package:events/models/Reply.dart';
import 'package:events/resources/AppTextStyles.dart';
import 'package:events/resources/Dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventCommentsSection extends StatelessWidget {
  final List<Comment> _comments;
  final List<Attendant> _attendants;

  EventCommentsSection(this._comments, this._attendants);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification notification) {
        notification.disallowGlow();
      },
      child: ListView.builder(
        padding: EdgeInsets.only(top: Margins.vertical),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _comments.length,
        itemBuilder: (context, position) {
          return _CommentView(_comments[position], _attendants);
        },
      ),
    );
  }
}

class _ReplyView extends StatelessWidget {
  final Reply _reply;
  final List<Attendant> _attendees;

  const _ReplyView(this._reply, this._attendees, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Attendant attendant =
        _attendees.firstWhere((attendant) => attendant.id == _reply.authorId);

    return Container(
      margin: EdgeInsets.only(
        top: Margins.vertical,
        left: (Margins.horizontal + AppSizes.avatarRadius) * 2,
        right: Margins.horizontal,
      ),
      child: _ItemRow(attendant.imagePath, _reply.text),
    );
  }
}

class _CommentView extends StatelessWidget {
  final Comment _comment;
  final List<Attendant> _attendees;

  const _CommentView(this._comment, this._attendees, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Attendant attendant =
        _attendees.firstWhere((attendant) => attendant.id == _comment.authorId);

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: Margins.vertical,
            left: Margins.horizontal,
            right: Margins.horizontal,
          ),
          child: _ItemRow(attendant.imagePath, _comment.text),
        ),
        NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification notification) {
            notification.disallowGlow();
          },
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 0),
            shrinkWrap: true,
            itemCount: _comment.reply.length,
            itemBuilder: (context, commentPos) {
              return _ReplyView(_comment.reply[commentPos], _attendees);
            },
          ),
        ),
      ],
    );
  }
}

class _ItemRow extends StatelessWidget {
  final String _imagePath;
  final String _text;

  const _ItemRow(this._imagePath, this._text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: AppSizes.avatarRadius,
          child: Image.asset(
            _imagePath,
            fit: BoxFit.fill,
          ),
        ),
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              left: Margins.horizontal,
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
