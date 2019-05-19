import 'package:events/models/Attendant.dart';
import 'package:events/models/Comment.dart';
import 'package:events/models/EventDetails.dart';
import 'package:events/models/Reply.dart';
import 'package:events/repositories/real/EventsRepository.dart';
import 'package:events/repositories/real/UserRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class EventDetailsBloc {
  String _eventId;

  EventDetailsBloc(this._eventId);

  final _eventsFetcher = BehaviorSubject<Details>();
  final _eventsRepository = eventsRepository;
  final _userRepository = userRepository;

  Observable<Details> get eventDetails => _eventsFetcher.stream;

  void addReply(Comment comment, String text) {
    _userRepository.loggedInUser().then(
      (user) {
        String replyId = Uuid().v4();
        Reply reply = Reply(replyId, comment.id, user.id, text);
        _eventsRepository.addReply(reply).whenComplete(() => fetchDetails());
      },
    );
  }

  void fetchDetails() async {
    EventDetails event = await _eventsRepository.fetchEventDetails(_eventId);
    User loggedInUser = await _userRepository.loggedInUser();

    _eventsFetcher.sink.add(Details(event, loggedInUser));
  }

  void dispose() {
    _eventsFetcher.close();
  }
}

EventDetailsBloc eventsBloc(String eventId) => EventDetailsBloc(eventId);

class Details {
  final EventDetails _eventDetails;
  final User _loggedInUser;

  Details(this._eventDetails, this._loggedInUser);

  User get loggedInUser => _loggedInUser;

  EventDetails get eventDetails => _eventDetails;
}
