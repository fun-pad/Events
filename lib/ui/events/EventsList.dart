import 'package:events/base/StreamWidget.dart';
import 'package:events/blocs/EventsBloc.dart';
import 'package:events/models/Event.dart';
import 'package:events/resources/AppColors.dart';
import 'package:events/resources/Dimens.dart';
import 'package:events/resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'EventsListItem.dart';

class EventsListWidget extends StreamWidget<List<Event>> {
  @override
  Widget showData(AsyncSnapshot snapshot) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: Margins.vertical),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return EventsListItem(
          event: snapshot.data[index],
        );
      },
    );
  }

  @override
  Observable<List<Event>> stream() {
    eventsBloc.fetchAllEvents();
    return eventsBloc.allEvents;
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
          onPressed: () => Navigator.of(context).pop(null),
        ),
      ),
      body: EventsListWidget(),
    );
  }
}
