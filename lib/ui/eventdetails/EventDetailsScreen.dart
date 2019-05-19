import 'package:events/base/StreamWidget.dart';
import 'package:events/blocs/EventDetailsBloc.dart';
import 'package:events/models/Attendant.dart';
import 'package:events/models/Comment.dart';
import 'package:events/models/EventDetails.dart';
import 'package:events/models/Reply.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'EventDetailsLayout.dart';

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
      detailViews.add(CommentView(
          comment, eventDetails.attendantsGoing, details.loggedInUser));
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

    return EventDetailsLayout(details, _eventDetailsBloc, viewsToDisplay);
  }

  @override
  Observable<Details> stream() {
    _eventDetailsBloc.fetchDetails();

    return _eventDetailsBloc.eventDetails;
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
  final User loggedInUser;

  CommentView(this.comment, this.attendees, this.loggedInUser);
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
