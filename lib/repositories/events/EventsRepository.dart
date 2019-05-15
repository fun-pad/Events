import 'dart:async';

import 'package:events/models/Attendant.dart';
import 'package:events/models/Comment.dart';
import 'package:events/models/Event.dart';
import 'package:events/models/EventAttendants.dart';
import 'package:events/models/EventDetails.dart';
import 'package:events/models/EventImage.dart';
import 'package:events/models/EventState.dart';
import 'package:events/models/Reply.dart';

abstract class EventsRepository {
  Future<List<Event>> fetchAllEvents();

  Future<EventDetails> fetchEventDetails(int eventId);
}

final eventsRepository = MockEventsRepository();

class MockEventsRepository implements EventsRepository {
  @override
  Future<List<Event>> fetchAllEvents() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return _allFakeEvents();
    });
  }

  @override
  Future<EventDetails> fetchEventDetails(int eventId) async {
    return Future.delayed(const Duration(milliseconds: 500), () {
      List<Event> events = _allFakeEvents();
      Event result = events.singleWhere((event) => event.id == eventId,
          orElse: () => null);

      List<Attendant> attendants = new List(6);
      attendants[0] =
          Attendant("assets/people/taras_profile.png", "Taras Koshkin", 0);
      attendants[1] =
          Attendant("assets/people/brian_profile.png", "Brian Payton", 1);
      attendants[2] =
          Attendant("assets/people/joe_profile.png", "Joseph Cherian", 2);
      attendants[3] =
          Attendant("assets/people/dimitri_profile.png", "Dimitri Koshkin", 3);
      attendants[4] =
          Attendant("assets/people/tim_profile.png", "Timothy Weeks", 4);
      attendants[5] =
          Attendant("assets/people/joe_t_profile.png", "Joseph Truncale", 5);

      List<Comment> comments = List(2);
      List<Reply> replies = List(2);
      replies[0] = Reply(0, 2,
          "I'm going to beat you this time, I love deep throating bananas");
      replies[1] = Reply(1, 1, "Which orifice are we using?");
      comments[0] =
          Comment(0, 0, "Who's bringing the bananas for the contest", replies);
      List<Reply> replies2 = List(1);
      replies2[0] = Reply(2, 3, "I don't like Fork-Knife");
      comments[1] = Comment(1, 5, "Don't forget your floss", replies2);

      return EventDetails(
        result.id,
        result.name,
        result.startDate,
        result.endDate,
        result.state,
        result.description,
        attendants,
        comments,
        result.image,
      );
    });
  }

  List<Event> _allFakeEvents() {
    List<Event> events = new List(3);
    events[0] = Event(
      0,
      "San Fran Bash",
      DateTime(2019, 6, 24, 18, 30),
      DateTime(2019, 6, 24, 24, 00),
      EventState.ACCEPTED,
      "Come hang with the bros as we explore the city in a romantic boat ride. We’ll start by holding hands and stroking each other, on the heads.",
      EventAttendantsOverview(12, 4, 5, 3),
      EventImage("assets/san_francisco.png"),
    );
    events[1] = Event(
      1,
      "Trip to NYC",
      DateTime(2019, 9, 20, 18, 30),
      DateTime(2019, 9, 22, 24, 00),
      EventState.MAYBE,
      "Soooo much avocado. Soy boys for life!",
      EventAttendantsOverview(24, 19, 4, 1),
      EventImage("assets/new_york.png"),
    );
    events[2] = Event(
      2,
      "New York City Tour",
      DateTime(2020, 3, 20, 18, 30),
      DateTime(2020, 3, 22, 24, 00),
      EventState.DECLINED,
      "Come hang with the bros as we explore the city in a romantic boat ride. We’ll start by holding hands and stroking each other, on the heads.",
      EventAttendantsOverview(5, 2, 1, 2),
      EventImage("assets/new_york.png"),
    );

    return events;
  }
}
