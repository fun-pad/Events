import 'package:events/models/Poll.dart';
import 'package:events/resources/AppColors.dart';
import 'package:events/resources/AppTextStyles.dart';
import 'package:events/resources/Dimens.dart';
import 'package:flutter/material.dart';

class CreatePoll extends StatefulWidget {
  const CreatePoll({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreatePoll();
}

class _CreatePoll extends State<CreatePoll> {
  final Poll _poll = Poll(
    options: List.generate(
      2,
      (i) => PollOption(),
      growable: true,
    ),
  );

  void _newPollOption() {
    setState(() {
      _poll.options.add(PollOption());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "New Poll",
          style: AppTextStyles.title,
        ),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppMargins.horizontal,
            vertical: AppMargins.vertical,
          ),
          child: Column(
            children: <Widget>[
              _PollQuestion(_poll),
              _PollOptions(
                _poll.options,
                _newPollOption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PollOptions extends StatelessWidget {
  final List<PollOption> _options;
  final GestureTapCallback _newOption;

  _PollOptions(this._options, this._newOption, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: AppMargins.verticalLarge * 2,
        bottom: AppMargins.vertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Options:",
            style: AppTextStyles.title,
          ),
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification notification) {
              notification.disallowGlow();
            },
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _options.length,
              itemBuilder: (BuildContext context, int index) {
                return _PollOption(_options[index]);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: AppMargins.verticalLarge),
            child: Center(
              child: RaisedButton.icon(
                color: AppColors.accent,
                label: Text(
                  "New Poll Option",
                  style: AppTextStyles.body,
                ),
                icon: Icon(
                  Icons.add_circle,
                  color: AppColors.textPrimary,
                ),
                onPressed: () {
                  _newOption();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PollQuestion extends StatelessWidget {
  final Poll _poll;

  const _PollQuestion(this._poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppTextStyles.input,
      decoration: InputDecoration(
        icon: Icon(
          Icons.help_outline,
          color: AppColors.accent,
        ),
        labelText: "Poll Question",
      ),
      maxLines: 1,
      onChanged: (text) {
        _poll.question = text;
      },
    );
  }
}

class _PollOption extends StatelessWidget {
  final PollOption _pollOption;

  _PollOption(this._pollOption, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppTextStyles.input,
      decoration: InputDecoration(
        icon: Icon(
          Icons.poll,
          color: AppColors.accent,
        ),
        labelText: "New Option",
      ),
      maxLines: 1,
      onChanged: (text) {
        _pollOption.answer = text;
      },
    );
  }
}
