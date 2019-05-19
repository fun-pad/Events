import 'dart:async';

import 'package:events/models/Attendant.dart';
import 'package:events/models/Comment.dart';
import 'package:events/models/Event.dart';
import 'package:events/models/EventAttendants.dart';
import 'package:events/models/EventDetails.dart';
import 'package:events/models/EventImage.dart';
import 'package:events/models/EventState.dart';
import 'package:events/models/Reply.dart';
import 'package:events/repositories/mock/MockEventsRepository.dart';
import 'package:uuid/uuid.dart';

abstract class EventsRepository {
  Future<List<Event>> fetchAllEvents();

  Future<EventDetails> fetchEventDetails(String eventId);

  Future<Comment> addReply(Reply reply);
}

final eventsRepository = mockEventsRepository;
