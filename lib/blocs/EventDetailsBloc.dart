import 'package:events/models/EventDetails.dart';
import 'package:events/repositories/events/EventsRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class EventDetailsBloc {
  int _eventId;

  EventDetailsBloc(this._eventId);

  final _eventsFetcher = BehaviorSubject<EventDetails>();
  final _repository = eventsRepository;

  Observable<EventDetails> get eventDetails => _eventsFetcher.stream;

  void fetchDetails() async {
    debugPrint("fetchDetails");
    EventDetails event = await _repository.fetchEventDetails(_eventId);
    debugPrint("fetchDetails result :: event :: $event");
    _eventsFetcher.sink.add(event);
  }

  void dispose() {
    _eventsFetcher.close();
  }
}

EventDetailsBloc eventsBloc(int eventId) => EventDetailsBloc(eventId);
