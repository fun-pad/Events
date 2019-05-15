import 'package:events/base/StreamWidget.dart';
import 'package:events/blocs/EventDetailsBloc.dart';
import 'package:events/models/EventDetails.dart';
import 'package:events/resources/AppColors.dart';
import 'package:events/resources/AppTextStyles.dart';
import 'package:events/resources/Dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'EventCommentsSection.dart';
import 'EventDetailsTitle.dart';
import 'EventGoingGrid.dart';

class EventDetailsScreen extends StreamWidget<EventDetails> {
  final EventDetailsBloc _eventDetailsBloc;

  EventDetailsScreen(_eventId) : _eventDetailsBloc = EventDetailsBloc(_eventId);

  @override
  Widget showData(AsyncSnapshot<EventDetails> snapshot) {
    EventDetails details = snapshot.data;

    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
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
          ];
        },
        body: Column(
          children: <Widget>[
            EventDetailsTitle("Description"),
            Container(
              alignment: Alignment(-1, 0),
              margin: EdgeInsets.only(
                left: Margins.horizontal,
                right: Margins.horizontal,
                top: Margins.vertical,
                bottom: Margins.vertical,
              ),
              child: Text(
                details.description,
                style: AppTextStyles.body,
              ),
            ),
            EventDetailsTitle("Who's Going?"),
            EventGoingGrid(details.attendantsGoing),
            EventDetailsTitle("Comments"),
            EventCommentsSection(details.comments, details.attendantsGoing)
          ],
        ),
      ),
    );
  }

  @override
  Observable<EventDetails> stream() {
    _eventDetailsBloc.fetchDetails();

    return _eventDetailsBloc.eventDetails;
  }
}
