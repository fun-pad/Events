import 'package:events/models/Attendant.dart';
import 'package:events/models/Comment.dart';
import 'package:events/models/Event.dart';
import 'package:events/models/EventAttendants.dart';
import 'package:events/models/EventDetails.dart';
import 'package:events/models/EventImage.dart';
import 'package:events/models/EventState.dart';
import 'package:events/models/Reply.dart';
import 'package:events/repositories/real/EventsRepository.dart';
import 'package:uuid/uuid.dart';

import 'MockUserRepository.dart';

final mockEventsRepository = MockEventsRepository();

class MockEventsRepository implements EventsRepository {
  List<Event> _events;
  List<Comment> _comments;
  List<User> _attendants;

  @override
  Future<Comment> addReply(Reply reply) {
    Comment comment =
        _allComments().singleWhere((comment) => comment.id == reply.commentId);
    comment.reply.add(reply);

    return Future.delayed(const Duration(milliseconds: 250), () {
      return comment;
    });
  }

  @override
  Future<List<Event>> fetchAllEvents() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return _allFakeEvents();
    });
  }

  @override
  Future<EventDetails> fetchEventDetails(String eventId) async {
    return Future.delayed(const Duration(milliseconds: 500), () {
      List<Event> events = _allFakeEvents();
      Event result = events.singleWhere((event) => event.id == eventId,
          orElse: () => null);

      List<User> attendants = _allAttendants();
      List<Comment> comments = _allComments();

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

  List<Comment> _allComments() {
    if (_comments != null) return _comments;

    List<User> attendants = _allAttendants();

    Uuid uuid = Uuid();
    _comments = List();
    List<Reply> replies = List();

    String commentId1 = uuid.v4();
    replies.add(Reply(uuid.v4(), commentId1, attendants[2].id,
        "I'm going to beat you this time, I love deep throating bananas"));
    replies.add(Reply(uuid.v4(), commentId1, attendants[1].id,
        "Which orifice are we using?"));

    _comments.add(Comment(commentId1, attendants[0].id,
        "Who's bringing the bananas for the contest", replies));

    List<Reply> replies2 = List();
    String commentId2 = uuid.v4();
    replies2.add(Reply(
        uuid.v4(), commentId2, attendants[3].id, "I don't like Fork-Knife"));

    _comments.add(Comment(
        commentId2, attendants[5].id, "Don't forget your floss", replies2));

    return _comments;
  }

  List<User> _allAttendants() {
    if (_attendants != null) return _attendants;

    Uuid uuid = Uuid();
    _attendants = new List();

    _attendants.add(mockUserRepository.loggedInUserInternal());
    _attendants.add(
        User("assets/people/brian_profile.png", "Brian Payton", uuid.v4()));
    _attendants.add(
        User("assets/people/joe_profile.png", "Joseph Cherian", uuid.v4()));
    _attendants.add(User(
        "assets/people/dimitri_profile.png", "Dimitri Koshkin", uuid.v4()));
    _attendants
        .add(User("assets/people/tim_profile.png", "Timothy Weeks", uuid.v4()));
    _attendants.add(
        User("assets/people/joe_t_profile.png", "Joseph Truncale", uuid.v4()));
    return _attendants;
  }

  List<Event> _allFakeEvents() {
    if (_events != null) return _events;

    Uuid uuid = Uuid();
    _events = new List();
    _events.add(Event(
      uuid.v4(),
      "San Fran Bash",
      DateTime(2019, 6, 24, 18, 30),
      DateTime(2019, 6, 24, 24, 00),
      EventState.ACCEPTED,
      "Come hang with the bros as we explore the city in a romantic boat ride. We’ll start by holding hands and stroking each other, on the heads.",
      EventAttendantsOverview(12, 4, 5, 3),
      EventImage("assets/san_francisco.png"),
    ));
    _events.add(Event(
      uuid.v4(),
      "Trip to NYC",
      DateTime(2019, 9, 20, 18, 30),
      DateTime(2019, 9, 22, 24, 00),
      EventState.MAYBE,
      "Soooo much avocado. Soy boys for life!",
      EventAttendantsOverview(24, 19, 4, 1),
      EventImage("assets/new_york.png"),
    ));
    _events.add(Event(
      uuid.v4(),
      "New York City Tour",
      DateTime(2020, 3, 20, 18, 30),
      DateTime(2020, 3, 22, 24, 00),
      EventState.DECLINED,
      "Come hang with the bros as we explore the city in a romantic boat ride. We’ll start by holding hands and stroking each other, on the heads.",
      EventAttendantsOverview(5, 2, 1, 2),
      EventImage("assets/new_york.png"),
    ));

    return _events;
  }
}
