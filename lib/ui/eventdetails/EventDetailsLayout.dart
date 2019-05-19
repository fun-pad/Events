import 'package:events/blocs/EventDetailsBloc.dart';
import 'package:events/models/EventDetails.dart';
import 'package:events/resources/AppColors.dart';
import 'package:events/resources/AppTextStyles.dart';
import 'package:events/resources/Dimens.dart';
import 'package:events/ui/poll/create/CreatePoll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'EventDetailsCommentView.dart';
import 'EventDetailsDescription.dart';
import 'EventDetailsReplyToCommentView.dart';
import 'EventDetailsReplyView.dart';
import 'EventDetailsScreen.dart';
import 'EventDetailsTitle.dart';
import 'EventGoingGrid.dart';

class EventDetailsLayout extends StatefulWidget {
  final EventDetails _details;
  final EventDetailsBloc _eventDetailsBloc;
  final List<EventDetailsView> _views;

  const EventDetailsLayout(this._details, this._eventDetailsBloc, this._views,
      {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventDetailsLayout();
}

class _EventDetailsLayout extends State<EventDetailsLayout> {
  ScrollController _scrollController;
  bool _showFab = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        print("offset :: " + _scrollController.offset.toString());
        _showFab = _scrollController.offset < 12.0;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      floatingActionButton: _CreateNewPoll(_showFab),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.bgPrimary,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                widget._details.name,
                style: AppTextStyles.title,
              ),
              background: Image.asset(
                widget._details.image.path,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                EventDetailsView viewType = widget._views[index];
                if (viewType is TitleView) {
                  return EventDetailsTitle(viewType.title);
                } else if (viewType is DescriptionView) {
                  return EventDetailsDescription(viewType.description);
                } else if (viewType is AttendeesGrid) {
                  return EventGoingGrid(widget._details.attendantsGoing);
                } else if (viewType is CommentView) {
                  return EventDetailsCommentView(viewType.comment,
                      viewType.attendees, viewType.loggedInUser);
                } else if (viewType is ReplyView) {
                  return EventDetailsReplyView(
                      viewType.reply, viewType.attendees);
                } else if (viewType is NewReplyView) {
                  return EventDetailsReplyToCommentView(viewType.comment,
                      viewType.loggedInUser, widget._eventDetailsBloc);
                } else {
                  return Container();
                }
              },
              childCount: widget._views.length,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: AppMargins.verticalLarge,
            ),
          )
        ],
      ),
    );
  }
}

class _CreateNewPoll extends StatelessWidget {
  final bool _showFab;

  const _CreateNewPoll(this._showFab, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 250),
      opacity: _showFab ? 1.0 : 0,
      child: IgnorePointer(
        ignoring: !_showFab,
        child: FloatingActionButton(
            child: Icon(Icons.poll),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return CreatePoll();
              }));
            }),
      ),
    );
  }
}
