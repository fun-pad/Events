import 'package:events/base/StreamWidget.dart';
import 'package:events/blocs/EventsBloc.dart';
import 'package:events/models/Event.dart';
import 'package:events/resources/AppColors.dart';
import 'package:events/resources/Dimens.dart';
import 'package:events/resources/Strings.dart';
import 'package:events/ui/eventdetails/EventDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'EventsListItem.dart';

class EventsListWidget extends StreamWidget<List<Event>> {
  @override
  Widget showData(AsyncSnapshot snapshot) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: AppMargins.vertical),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        Event event = snapshot.data[index];
        return EventsListItem(
          event: event,
          itemSelected: () {
            _showDetails(context, event);
          },
        );
      },
    );
  }

  @override
  Observable<List<Event>> stream() {
    eventsBloc.fetchAllEvents();
    return eventsBloc.allEvents;
  }

  void _showDetails(BuildContext context, Event event) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return EventDetailsScreen(event.id);
    }));
  }
}

class EventsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      appBar: AppBar(
        title: Text(Strings.eventsTitle),
        leading: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: EventsListWidget(),
    );
  }
}
