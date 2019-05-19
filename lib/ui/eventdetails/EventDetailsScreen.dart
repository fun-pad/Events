import 'package:events/base/StreamWidget.dart';
import 'package:events/blocs/EventDetailsBloc.dart';
import 'package:events/models/Attendant.dart';
import 'package:events/models/Comment.dart';
import 'package:events/models/EventDetails.dart';
import 'package:events/models/Reply.dart';
import 'package:events/resources/AppColors.dart';
import 'package:events/resources/AppTextStyles.dart';
import 'package:events/resources/Dimens.dart';
import 'package:events/ui/poll/create/CreatePoll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'EventDetailsCommentView.dart';
import 'EventDetailsDescription.dart';
import 'EventDetailsReplyToCommentView.dart';
import 'EventDetailsReplyView.dart';
import 'EventDetailsTitle.dart';
import 'EventGoingGrid.dart';

class EventDetailsScreen extends StreamWidget<Details> {
  final EventDetailsBloc _eventDetailsBloc;

  EventDetailsScreen(_eventId) : _eventDetailsBloc = EventDetailsBloc(_eventId);

  List<EventDetailsView> _listOfDetails(Details details) {
    EventDetails eventDetails = details.eventDetails;

    List<EventDetailsView> detailViews = List();

    detailViews.add(TitleView("Description"));
    detailViews.add(DescriptionView(eventDetails.description));
    detailViews.add(TitleView("Who's Going?"));
    detailViews.add(AttendeesGrid(eventDetails.attendantsGoing));
    detailViews.add(TitleView("Comments"));
    eventDetails.comments.forEach((comment) {
      detailViews.add(CommentView(comment, eventDetails.attendantsGoing));
      comment.reply.forEach((reply) {
        detailViews.add(ReplyView(reply, eventDetails.attendantsGoing));
      });
      detailViews.add(NewReplyView(comment, details.loggedInUser));
    });

    return detailViews;
  }

  @override
  Widget showData(AsyncSnapshot<Details> snapshot) {
    EventDetails details = snapshot.data.eventDetails;
    List<EventDetailsView> viewsToDisplay = _listOfDetails(snapshot.data);

    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      floatingActionButton: _CreateNewPoll(details.id),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.bgPrimary,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                details.name,
                style: AppTextStyles.title,
              ),
              background: Image.asset(
                details.image.path,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                EventDetailsView viewType = viewsToDisplay[index];
                if (viewType is TitleView) {
                  return EventDetailsTitle(viewType.title);
                } else if (viewType is DescriptionView) {
                  return EventDetailsDescription(viewType.description);
                } else if (viewType is AttendeesGrid) {
                  return EventGoingGrid(details.attendantsGoing);
                } else if (viewType is CommentView) {
                  return EventDetailsCommentView(
                      viewType.comment, viewType.attendees);
                } else if (viewType is ReplyView) {
                  return EventDetailsReplyView(
                      viewType.reply, viewType.attendees);
                } else if (viewType is NewReplyView) {
                  return EventDetailsReplyToCommentView(viewType.comment,
                      viewType.loggedInUser, _eventDetailsBloc);
                } else {
                  return Container();
                }
              },
              childCount: viewsToDisplay.length,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: AppMargins.verticalLarge,
            ),
          )
        ],
      ),
    );
  }

  @override
  Observable<Details> stream() {
    _eventDetailsBloc.fetchDetails();

    return _eventDetailsBloc.eventDetails;
  }
}

class _CreateNewPoll extends StatelessWidget {
  final String _eventId;

  const _CreateNewPoll(this._eventId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.poll),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return CreatePoll(_eventId);
        }));
      },
    );
  }
}

class DescriptionView extends EventDetailsView {
  final String description;

  DescriptionView(this.description);
}

class TitleView extends EventDetailsView {
  final String title;

  TitleView(this.title);
}

class AttendeesGrid extends EventDetailsView {
  final List<User> attendees;

  AttendeesGrid(this.attendees);
}

class CommentView extends EventDetailsView {
  final Comment comment;
  final List<User> attendees;

  CommentView(this.comment, this.attendees);
}

class ReplyView extends EventDetailsView {
  final Reply reply;
  final List<User> attendees;

  ReplyView(this.reply, this.attendees);
}

class NewReplyView extends EventDetailsView {
  final Comment comment;
  final User loggedInUser;

  NewReplyView(this.comment, this.loggedInUser);
}

// Interface.
class EventDetailsView {}
