import 'package:events/models/Event.dart';
import 'package:events/repositories/events/EventsRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class EventsBloc {
  final _eventsFetcher = PublishSubject<List<Event>>();
  final _repository = eventsRepository;

  Observable<List<Event>> get allEvents => _eventsFetcher.stream;

  fetchAllEvents() async {
    debugPrint("fetchAllEvents");
    List<Event> events = await _repository.fetchAllEvents();
    debugPrint("fetchAllEvents :: events :: $events");
    _eventsFetcher.sink.add(events);
  }

  dispose() {
    _eventsFetcher.close();
  }
}

final eventsBloc = EventsBloc();
