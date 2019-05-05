import 'dart:async';

import 'package:events/models/Event.dart';
import 'package:events/models/EventAttendants.dart';
import 'package:events/models/EventImage.dart';
import 'package:events/models/EventState.dart';

abstract class EventsRepository {
  Future<List<Event>> fetchAllEvents();
}

final eventsRepository = MockEventsRepository();

class MockEventsRepository implements EventsRepository {
  @override
  Future<List<Event>> fetchAllEvents() async {
    return Future.delayed(const Duration(seconds: 2), () {
      List<Event> events = new List(3);
      events[0] = Event(
        "San Fran Bash",
        DateTime(2019, 6, 24, 18, 30),
        DateTime(2019, 6, 24, 24, 00),
        EventState.ACCEPTED,
        "Come hang with the bros as we explore the city in a romantic boat ride. We’ll start by holding hands and stroking each other, on the heads.",
        EventAttendants(12, 4, 5, 3),
        EventImage("assets/san_francisco.png"),
      );
      events[1] = Event(
        "Trip to NYC",
        DateTime(2019, 9, 20, 18, 30),
        DateTime(2019, 9, 22, 24, 00),
        EventState.MAYBE,
        "Soooo much avocado. Soy boys for life!",
        EventAttendants(24, 19, 4, 1),
        EventImage("assets/new_york.png"),
      );
      events[2] = Event(
        "New York City Tour",
        DateTime(2020, 3, 20, 18, 30),
        DateTime(2020, 3, 22, 24, 00),
        EventState.DECLINED,
        "Come hang with the bros as we explore the city in a romantic boat ride. We’ll start by holding hands and stroking each other, on the heads.",
        EventAttendants(5, 2, 1, 2),
        EventImage("assets/new_york.png"),
      );

      return events;
    });
  }
}
